#include "Player.h"
#include "Chat.h"
#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "Item.h"
#include "Config.h"
#include "Pet.h"
#include "PreparedStatement.h"
#pragma execution_character_set("utf-8")

class Gossip_OnNpcZy :CreatureScript
{
public:
        Gossip_OnNpcZy() :CreatureScript("npc_zy") {}
        
//转职函数
bool SetClassToNew(Player* player, uint8 newclass)
{
        //检查
        if (!player || !player->IsInWorld() || !player->IsAlive() || player->IsInCombat() || player->getClass() == newclass || newclass <= 0 || newclass >= MAX_CLASSES)
                return false;

        //移除宠物 与相关的东西
        if (Pet* pet = player->GetPet())
        {
                uint32 PGuid = pet->GetCharmInfo()->GetPetNumber();
                player->RemovePet(pet, PET_SAVE_NOT_IN_SLOT);
                SQLTransaction trans = CharacterDatabase.BeginTransaction();
                CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_DECLINEDNAME);
                stmt->SetData(0, PGuid);
                trans->Append(stmt);
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_AURAS);
                stmt->SetData(0, PGuid);
                trans->Append(stmt);
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_SPELLS);
                stmt->SetData(0, PGuid);
                trans->Append(stmt);
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PET_SPELL_COOLDOWNS);
                stmt->SetData(0, PGuid);
                trans->Append(stmt);
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_BY_OWNER);
				stmt->SetData(1, player->GetGUID().GetCounter());
                trans->Append(stmt);
                CharacterDatabase.CommitTransaction(trans);
        }

        //移除雕文
        for (uint32 slot = 0; slot < MAX_GLYPH_SLOT_INDEX; ++slot)
        {
                if (slot >= MAX_GLYPH_SLOT_INDEX)
                        continue;

                if (uint32 glyph = player->GetGlyph(slot))
                {
                        if (GlyphPropertiesEntry const* gp = sGlyphPropertiesStore.LookupEntry(glyph))
                        {
                                player->RemoveAurasDueToSpell(gp->SpellId);
                                player->SetGlyph(slot, 0, true);
                                player->SendTalentsInfoData(false);
                        }
                }
        }

        //----------------------------------战士---骑士----猎人----盗贼---牧师----DK----萨满----法师----术士---------小德---------------------------------------------------//
        int const DBclass[MAX_CLASSES] = { 80001, 80002, 80003, 80004, 80005, 80006, 80007, 80008, 80009, NULL, 80010 };

        //遗忘旧职业技能 数组是技能训练师ID 技能自行补全 保证转职不会影响其他渠道获取的技能
        TrainerSpellData const* Spells = sObjectMgr->GetNpcTrainerSpells(DBclass[player->getClass() - 1]);
        if (Spells)
        {
                for (TrainerSpellMap::const_iterator its = Spells->spellList.begin(); its != Spells->spellList.end(); ++its)
                {
                        //保险防止作弊
                        if (!player->IsSpellFitByClassAndRace(its->second.spell))
                                continue;
                        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(its->second.spell);
                        if (!spellInfo)
                                continue;
                        if (!SpellMgr::IsSpellValid(spellInfo))
                                continue;
                        player->removeSpell(its->second.spell, SPEC_MASK_ALL, false);
                }
        }

        //武器技能ID-----------长柄/单手剑/双手剑/弓/匕首/投掷-----//
        int const Wpells[6] = { 200, 201, 202, 264, 1180, 2567 };

        //遗忘 不是角色出生默认的武器技能
        for (int w = 0; w < 6; ++w)
                player->removeSpell(Wpells[w], SPEC_MASK_ALL, false);

        //遗忘出生默认的技能 包含种族特长
        PlayerInfo const* info = sObjectMgr->GetPlayerInfo(player->getRace(true), player->getClass());
        for (PlayerCreateInfoSpells::const_iterator itc = info->castSpells.begin(); itc != info->castSpells.end(); ++itc)
                player->removeSpell(*itc, SPEC_MASK_ALL, false);

        //重置天赋
        player->resetTalents();
        player->InitTalentForLevel();
        player->SendTalentsInfoData(false);

        //执行转职
        player->SetByteValue(UNIT_FIELD_BYTES_0, 1, newclass);

        //更新角色新职业信息
        sCharacterCache->AddCharacterCacheEntry(
            player->GetGUID(),                      // 玩家的GUID
			player->GetSession()->GetAccountId(),   // 玩家的账户ID
            player->GetName(),                      // 玩家的姓名
            player->getGender(),                    // 玩家的性别
			player->getRace(),                      // 玩家的种族
            newclass,                               // 新职业
            player->GetLevel()                      // 玩家的等级
        );
		//sCharacterCache->AddCharacterCacheEntry(player->GetGUID(),player->GetName(), player->GetLevel(), player->getGender(), player->getRace(), newclass);
       // sCharacterCache->CharacterCacheEntry(player->GetGUID(), PLAYER_UPDATE_DATA_CLASS, player->GetName(), player->GetLevel(), player->getGender(), player->getRace(), newclass);

        //强制把身上不符合新职业的武器装备卸下 有位置就放 没位置自动发到邮箱里
        for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
        {
                if (Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                {
                        //判断不符合要求的
                        uint16 Cdest = 0;
                        ItemTemplate const* pProto = pItem->GetTemplate();
                        InventoryResult Check = player->CanEquipItem(NULL_SLOT, Cdest, pItem, false);
                        if ((pProto->AllowableClass & player->getClassMask()) == 0 || (pProto->RequiredSpell != 0 && !player->HasSpell(pProto->RequiredSpell)) || Check != EQUIP_ERR_OK)
                        {
                                ItemPosCountVec dest;
                                uint8 Msg = player->CanStoreItem(NULL_BAG, NULL_SLOT, dest, pItem, false);
                                if (Msg == EQUIP_ERR_OK)
                                {
                                        player->RemoveItem(INVENTORY_SLOT_BAG_0, pItem->GetSlot(), true);
                                        player->StoreItem(dest, pItem, true);
                                        //更新泰坦之握
                                        player->UpdateTitansGrip();
                                }
                                else
                                {
                                        player->MoveItemFromInventory(INVENTORY_SLOT_BAG_0, pItem->GetSlot(), true);
                                        SQLTransaction trans = CharacterDatabase.BeginTransaction();
                                        pItem->DeleteFromInventoryDB(trans);
                                        pItem->SaveToDB(trans);
                                        MailDraft("转职", "这些装备不支持新职业").AddItem(pItem).SendMailTo(trans, player, MailSender(player, MAIL_STATIONERY_GM), MAIL_CHECK_MASK_COPIED);
                                        CharacterDatabase.CommitTransaction(trans);
                                }
                        }
                }
        }

        //保存角色信息
        player->SaveToDB(false, false);
        //重新学习默认技能
        player->LearnDefaultSkills();
        //重置属性获取对应职业的Power(能量条/怒气条之类的)
        player->InitStatsForLevel(true);
        //如果新职业是DK就载入符文冷却
        player->InitRunes();
        //更新角色属性
        player->SetCanModifyStats(true);
        player->UpdateAllStats();

        //重新学习新职业技能。。。自行到训练师处重新学习。。。否则技能摆放很乱。。需小退
        /*
        TrainerSpellData const* NewSpells = sObjectMgr->GetNpcTrainerSpells(DBclass[newclass - 1]);
        if (NewSpells)
        {
                for (TrainerSpellMap::const_iterator its = NewSpells->spellList.begin(); its != NewSpells->spellList.end(); ++its)
                {
                    //保险防止作弊
                        if (!player->IsSpellFitByClassAndRace(its->second.spell))
                                continue;
                        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(its->second.spell);
                        if (!spellInfo)
                                continue;
                        if (!SpellMgr::IsSpellValid(spellInfo))
                                continue;
                        player->_addSpell(*its, SPEC_MASK_ALL, true);
                }
        }
        */

        ChatHandler(player->GetSession()).PSendSysMessage("|CFFFF0000恭喜你转职完成,请重新登录角色完成转职!|r");
        player->GetSession()->SendAreaTriggerMessage("|CFFFF0000恭喜你转职完成,请重新登录角色完成转职!|r");

        return true;
}

        bool OnGossipHello(Player* player, Creature* creature) override
        {
           uint32 Race = player->getRace();
            ClearGossipMenuFor(player);
            AddGossipItemFor(player, 10, "|CFFFF0000欢迎使用 转职 系统!|r", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

                        if (Race != RACE_BLOODELF && player->getClass() != CLASS_WARRIOR)
                            AddGossipItemFor(player, 10, "转职为战士", CLASS_WARRIOR, GOSSIP_ACTION_INFO_DEF + 999, "确定转职为战士吗?", 0, false);

                        if (Race != RACE_NIGHTELF && Race != RACE_GNOME && Race != RACE_ORC && Race != RACE_UNDEAD_PLAYER && Race != RACE_TAUREN && Race != RACE_TROLL && player->getClass() != CLASS_PALADIN)
                                AddGossipItemFor(player, 10, "转职为骑士", CLASS_PALADIN, GOSSIP_ACTION_INFO_DEF + 999, "确定转职为骑士吗?", 0, false);

                        if (Race != RACE_HUMAN && Race != RACE_GNOME && Race != RACE_UNDEAD_PLAYER && player->getClass() != CLASS_HUNTER)
                                AddGossipItemFor(player, 10, "转职为猎人", CLASS_HUNTER, GOSSIP_ACTION_INFO_DEF + 999, "确定转职为猎人吗?", 0, false);

                        if (Race != RACE_DRAENEI && Race != RACE_TAUREN && player->getClass() != CLASS_ROGUE)
                                AddGossipItemFor(player, 10, "转职为盗贼", CLASS_ROGUE, GOSSIP_ACTION_INFO_DEF + 999, "确定转职为盗贼吗?", 0, false);

                        if (Race != RACE_GNOME && Race != RACE_ORC && Race != RACE_TAUREN && player->getClass() != CLASS_PRIEST)
                                AddGossipItemFor(player, 10, "转职为牧师", CLASS_PRIEST, GOSSIP_ACTION_INFO_DEF + 999, "确定转职为牧师吗?", 0, false);

                        if (player->getClass() != CLASS_DEATH_KNIGHT)
                            AddGossipItemFor(player, 10, "转职为死骑", CLASS_DEATH_KNIGHT, GOSSIP_ACTION_INFO_DEF + 999, "确定转职为死骑吗?", 0, false);

                        if (Race == RACE_DRAENEI || Race == RACE_ORC || Race == RACE_TAUREN || Race == RACE_TROLL && player->getClass() != CLASS_SHAMAN)
                                AddGossipItemFor(player, 10, "转职为萨满", CLASS_SHAMAN, GOSSIP_ACTION_INFO_DEF + 999, "确定转职为萨满吗?", 0, false);

                        if (Race == RACE_HUMAN || Race == RACE_GNOME || Race == RACE_DRAENEI || Race == RACE_UNDEAD_PLAYER || Race == RACE_TROLL || Race == RACE_BLOODELF && player->getClass() != CLASS_MAGE)
                                AddGossipItemFor(player, 10, "转职为法师", CLASS_MAGE, GOSSIP_ACTION_INFO_DEF + 999, "确定转职为法师吗?", 0, false);

                        if (Race == RACE_HUMAN || Race == RACE_GNOME || Race == RACE_ORC || Race == RACE_UNDEAD_PLAYER || Race == RACE_BLOODELF && player->getClass() != CLASS_WARLOCK)
                                AddGossipItemFor(player, 10, "转职为术士", CLASS_WARLOCK, GOSSIP_ACTION_INFO_DEF + 999, "确定转职为术士吗?", 0, false);

                        if (Race == RACE_NIGHTELF || Race == RACE_TAUREN && player->getClass() != CLASS_DRUID)
                                AddGossipItemFor(player, 10, "转职为小德", CLASS_DRUID, GOSSIP_ACTION_INFO_DEF + 999, "确定转职为小德吗?", 0, false);

                        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
                        
            return true;
        }
        
        bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
        {
                ClearGossipMenuFor(player);

                if (sender == GOSSIP_SENDER_MAIN && action == GOSSIP_ACTION_INFO_DEF)
                {
                    OnGossipHello(player, creature);
                        return true;
                }
                
                if (action == GOSSIP_ACTION_INFO_DEF + 999 && sender)
                {
                        if (sender <= 0 || sender >= MAX_CLASSES)
                                return true;
                                
                        if (!SetClassToNew(player, (uint8)sender))
                                return true;
                                
                        //以下是扣材料
                        //----

                }

                CloseGossipMenuFor(player);

                return true;
        }
};


void AddSCnpc_zy()
{
    new Gossip_OnNpcZy();

}
