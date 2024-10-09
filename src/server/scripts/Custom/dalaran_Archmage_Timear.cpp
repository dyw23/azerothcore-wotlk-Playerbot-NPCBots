/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "MoveSplineInit.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "TaskScheduler.h"
#include "World.h"

enum ArchmageLandalockQuests
{
    QUEST_INGVAR_THE_PLUNDERER      = 13245,
    QUEST_KERISTRAZA                = 13246,
    QUEST_LEY_GUARDIAN_EREGOS       = 13247,
    QUEST_KING_YMIRON               = 13248,
    QUEST_THE_PROPHET_THARON_JA     = 13249,
    QUEST_GAL_DARAH                 = 13250,
    QUEST_MAL_GANIS                 = 13251,
    QUEST_SJONNIR_THE_IRONSHAPER    = 13252,
    QUEST_LOKEN                     = 13253,
    QUEST_ANUB_ARAK                 = 13254,
    QUEST_HERALD_VOLAZJ             = 13255,
	QUEST_CYANIGOSA                 = 13256,
    QUEST_THE_BLACK_KNIGHT          = 14199
};

enum ArchmageLandalockImages
{
    NPC_INGVAR_THE_PLUNDERER_IMAGE      = 250001,
    NPC_KERISTRAZA_IMAGE                = 250002,
    NPC_LEY_GUARDIAN_EREGOS_IMAGE       = 250003,
    NPC_KING_YMIRON_IMAGE               = 250004,
    NPC_THE_PROPHET_THARON_JA_IMAGE     = 250005,
    NPC_GAL_DARAH_IMAGE                 = 250006,
    NPC_MAL_GANIS_IMAGE                 = 250007,
    NPC_SJONNIR_THE_IRONSHAPER_IMAGE    = 250008,
    NPC_LOKEN_IMAGE                     = 250009,
    NPC_ANUB_ARAK_IMAGE                 = 250010,
    NPC_HERALD_VOLAZJ_IMAGE             = 250011,
    NPC_CYANIGOSA_IMAGE                 = 250012,
	NPC_THE_BLACK_KNIGHT_IMAGE          = 35461
};

 // 达拉然日常任务
class npc_Archmage_Timear : public CreatureScript
{
public:
    npc_Archmage_Timear() : CreatureScript("npc_Archmage_Timear")
    {
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_Archmage_TimearAI(creature);
    }

    struct npc_Archmage_TimearAI : public ScriptedAI
    {
        npc_Archmage_TimearAI(Creature* creature) : ScriptedAI(creature)
        {
            _switchImageTimer = MINUTE * IN_MILLISECONDS;
            _summonGUID.Clear();
        }

        uint32 GetImageEntry(uint32 QuestId)
        {
            switch (QuestId)
            {
                case QUEST_INGVAR_THE_PLUNDERER:
                    return NPC_INGVAR_THE_PLUNDERER_IMAGE;
                case QUEST_KERISTRAZA:
                    return NPC_KERISTRAZA_IMAGE;
                case QUEST_LEY_GUARDIAN_EREGOS:
                    return NPC_LEY_GUARDIAN_EREGOS_IMAGE;
                case QUEST_KING_YMIRON:
                    return NPC_KING_YMIRON_IMAGE;
                case QUEST_THE_PROPHET_THARON_JA:
                    return NPC_THE_PROPHET_THARON_JA_IMAGE;
                case QUEST_GAL_DARAH:
                    return NPC_GAL_DARAH_IMAGE;
                case QUEST_MAL_GANIS:
                    return NPC_MAL_GANIS_IMAGE;
                case QUEST_SJONNIR_THE_IRONSHAPER:
                    return NPC_SJONNIR_THE_IRONSHAPER_IMAGE;
                case QUEST_LOKEN:
                    return NPC_LOKEN_IMAGE;
                case QUEST_ANUB_ARAK:
                    return NPC_ANUB_ARAK_IMAGE;
                case QUEST_HERALD_VOLAZJ:
                    return NPC_HERALD_VOLAZJ_IMAGE;
				case QUEST_CYANIGOSA:
					return NPC_CYANIGOSA_IMAGE;
                default: //case QUEST_THE_BLACK_KNIGHT:
                    return NPC_THE_BLACK_KNIGHT_IMAGE;
            }
        }

        void JustSummoned(Creature* image) override
        {
            // xinef: screams like a baby
            if (image->GetEntry() != NPC_ANUB_ARAK_IMAGE)
                image->SetUnitMovementFlags(MOVEMENTFLAG_RIGHT);
            _summonGUID = image->GetGUID();
        }

        void UpdateAI(uint32 diff) override
        {
            ScriptedAI::UpdateAI(diff);

            _switchImageTimer += diff;
            if (_switchImageTimer > MINUTE * IN_MILLISECONDS)
            {
                _switchImageTimer = 0;
                QuestRelationBounds objectQR = sObjectMgr->GetCreatureQuestRelationBounds(me->GetEntry());
                for (QuestRelations::const_iterator i = objectQR.first; i != objectQR.second; ++i)
                {
                    uint32 questId = i->second;
                    Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
                    if (!quest || !quest->IsDaily())
                        continue;

                    uint32 newEntry = GetImageEntry(questId);
                    if (_summonGUID.GetEntry() != newEntry)
                    {
                        if (Creature* image = ObjectAccessor::GetCreature(*me, _summonGUID))
                            image->DespawnOrUnsummon();

                        float z = 652.630f;
                        if (newEntry == NPC_LEY_GUARDIAN_EREGOS_IMAGE)
                            z += 3.0f;
                        me->SummonCreature(newEntry, 5771.102f, 529.867f, z, 4.02828f);
                    }
                }
            }
        }
    private:
        uint32 _switchImageTimer;
        ObjectGuid _summonGUID;
    };
};

void AddSC_dalaran_npc_quest()
{   
    new npc_Archmage_Timear();
}
