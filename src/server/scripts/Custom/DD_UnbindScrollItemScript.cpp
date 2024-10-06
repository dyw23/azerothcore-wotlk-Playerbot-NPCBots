/*#####
# 副本重置卷轴
#####*/
#include "CreatureScript.h"
#include "ItemScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#pragma execution_character_set("UTF-8")
class DD_UnbindScrollItemScript : public ItemScript
{
public:
    DD_UnbindScrollItemScript() : ItemScript("DD_UnbindScrollItemScript") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/)
    {
        bool success = false;

        for (uint32 i = 0; i < MAX_DIFFICULTY; ++i)
        {
            BoundInstancesMap const& binds = sInstanceSaveMgr->PlayerGetBoundInstances(player->GetGUID(), Difficulty(i));
            for (BoundInstancesMap::const_iterator itr = binds.begin(); itr != binds.end(); ++itr)
            {
                if (player->GetLevel() >= 10) // 假设有副本需要重置
                {
                    sInstanceSaveMgr->PlayerUnbindInstance(player->GetGUID(), itr->first, Difficulty(i), true, player);
                    success = true;
                }
            }
        }

        if (success)
        {
            // 在重置成功时消耗物品
            player->DestroyItemCount(item->GetEntry(), 1, true, true);
            ChatHandler(player->GetSession()).PSendSysMessage("物品使用成功，所有副本重置完成！");
        }
        else
        {
            // 在重置失败时不消耗物品
            ChatHandler(player->GetSession()).PSendSysMessage("物品使用失败，没有副本需要重置！");
        }
        return success;
    }
};

/*#####
# 满级卷轴
#####*/

class MaxLevelItemScript : public ItemScript
{
public:
    MaxLevelItemScript() : ItemScript("MaxLevelItemScript") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/)
    {        
		uint32 MaxLevel = 80;
        uint32 CurrentLevel = player->GetLevel();
        if (CurrentLevel < MaxLevel)
        {
            // 在升级成功时消耗物品
            player->SetLevel(MaxLevel);
            player->DestroyItemCount(item->GetEntry(), 1, true, true);
            ChatHandler(player->GetSession()).PSendSysMessage("物品使用成功，你已经升到最高等级80级！");
        }
        else
        {
            // 在升级失败时不消耗物品
            ChatHandler(player->GetSession()).PSendSysMessage("你疯了吗？ 你已经满级了，不能再升级了！");
        }
		return true;
    }
};

/*#####
# 升级卷轴
#####*/

class Level_UpItemScript : public ItemScript
{
public:
    Level_UpItemScript() : ItemScript("Level_UpItemScript") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/)
    {        
		uint32 MaxLevel = 80;
        uint32 CurrentLevel = player->GetLevel();
        if (CurrentLevel < MaxLevel)
        {
            // 在升级成功时消耗物品
            player->SetLevel(CurrentLevel + 1);
            player->DestroyItemCount(item->GetEntry(), 1, true, true);
            ChatHandler(player->GetSession()).PSendSysMessage("物品使用成功，你的等级提高了1级！");
        }
        else
        {
            // 在升级失败时不消耗物品
            ChatHandler(player->GetSession()).PSendSysMessage("你疯了吗？ 你已经满级了，不能再升级了！");
        }
		return true;
    }
};
void AddSC_DD_UnbindScrollItemScript()
{
    new DD_UnbindScrollItemScript();
}

void AddSC_MaxLevelItemScript()
{
    new MaxLevelItemScript();
}

void AddSC_Level_UpItemScript()
{
    new Level_UpItemScript();
}
