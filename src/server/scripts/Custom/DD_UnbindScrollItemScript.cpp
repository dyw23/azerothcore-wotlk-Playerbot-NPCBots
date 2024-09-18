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
void AddSC_DD_UnbindScrollItemScript()
{
    new DD_UnbindScrollItemScript();
}