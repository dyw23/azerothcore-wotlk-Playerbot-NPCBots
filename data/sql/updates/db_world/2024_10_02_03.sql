-- NPC脚本
UPDATE `creature_template` SET `ScriptName` = 'npc_Archmage_Timear' WHERE `entry` = 31439;

-- 任务修改
UPDATE `quest_template` SET `Flags` = 4232 WHERE `ID` = 13245;
UPDATE `quest_template` SET `Flags` = 4232 WHERE `ID` = 13246;
UPDATE `quest_template` SET `Flags` = 4232 WHERE `ID` = 13247;
UPDATE `quest_template` SET `Flags` = 4232 WHERE `ID` = 13248;
UPDATE `quest_template` SET `Flags` = 4232 WHERE `ID` = 13249;
UPDATE `quest_template` SET `Flags` = 4232 WHERE `ID` = 13250;
UPDATE `quest_template` SET `Flags` = 4232 WHERE `ID` = 13251;
UPDATE `quest_template` SET `Flags` = 4232 WHERE `ID` = 13252;
UPDATE `quest_template` SET `Flags` = 4232 WHERE `ID` = 13253;
UPDATE `quest_template` SET `Flags` = 4232 WHERE `ID` = 13254;
UPDATE `quest_template` SET `Flags` = 4232 WHERE `ID` = 13255;
UPDATE `quest_template` SET `Flags` = 4232 WHERE `ID` = 13256;
UPDATE `quest_template` SET `Flags` = 4232 WHERE `ID` = 14199;

-- 接任务
DELETE FROM `creature_queststarter` WHERE `id` = 31439;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (31439, 13245);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (31439, 13246);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (31439, 13247);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (31439, 13248);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (31439, 13249);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (31439, 13250);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (31439, 13251);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (31439, 13252);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (31439, 13253);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (31439, 13254);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (31439, 13255);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (31439, 13256);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (31439, 14199);

-- 交任务
DELETE FROM `creature_questender` WHERE `id` = 31439;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (31439, 13245);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (31439, 13246);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (31439, 13247);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (31439, 13248);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (31439, 13249);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (31439, 13250);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (31439, 13251);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (31439, 13252);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (31439, 13253);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (31439, 13254);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (31439, 13255);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (31439, 13256);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (31439, 14199);

-- 任务分组
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 31439, `SpecialFlags` = 1 WHERE `ID` = 13245;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 31439, `SpecialFlags` = 1 WHERE `ID` = 13246;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 31439, `SpecialFlags` = 1 WHERE `ID` = 13247;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 31439, `SpecialFlags` = 1 WHERE `ID` = 13248;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 31439, `SpecialFlags` = 1 WHERE `ID` = 13249;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 31439, `SpecialFlags` = 1 WHERE `ID` = 13250;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 31439, `SpecialFlags` = 1 WHERE `ID` = 13251;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 31439, `SpecialFlags` = 1 WHERE `ID` = 13252;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 31439, `SpecialFlags` = 1 WHERE `ID` = 13253;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 31439, `SpecialFlags` = 1 WHERE `ID` = 13254;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 31439, `SpecialFlags` = 1 WHERE `ID` = 13255;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 31439, `SpecialFlags` = 1 WHERE `ID` = 13256;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 31439, `SpecialFlags` = 1 WHERE `ID` = 14199;

-- 任务池建立
DELETE FROM `pool_template` WHERE `entry` = 86400;
DELETE FROM `pool_quest` WHERE `entry` BETWEEN 13245 AND 13256 OR `entry` = 14199;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (86400, 1, 'Dalaran Archmage Timear Daily Quest');

INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES (13245, 86400, 'Proof of Demise: Ingvar the Plunderer');
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES (13246, 86400, 'Proof of Demise: Keristrasza');
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES (13247, 86400, 'Proof of Demise: Ley-Guardian Eregos');
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES (13248, 86400, 'Proof of Demise: King Ymiron');
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES (13249, 86400, 'Proof of Demise: The Prophet Tharon\\\'ja');
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES (13250, 86400, 'Proof of Demise: Gal\\\'darah');
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES (13251, 86400, 'Proof of Demise: Mal\\\'Ganis');
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES (13252, 86400, 'Proof of Demise: Sjonnir The Ironshaper');
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES (13253, 86400, 'Proof of Demise: Loken');
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES (13254, 86400, 'Proof of Demise: Anub\\\'arak');
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES (13255, 86400, 'Proof of Demise: Herald Volazj');
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES (13256, 86400, 'Proof of Demise: Cyanigosa');
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES (14199, 86400, 'Proof of Demise: The Black Knight');

-- 镜像NPC
DELETE FROM `creature_template` WHERE `entry` BETWEEN 250001 AND 250012;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (250001, 0, 0, 0, 0, 0, '因格瓦尔的镜像', '', '', 0, 83, 83, 2, 35, 0, 1, 1.07143, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (250002, 0, 0, 0, 0, 0, '克莉斯塔萨的镜像', '', '', 0, 83, 83, 2, 35, 0, 1, 1.07143, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (250003, 0, 0, 0, 0, 0, '埃雷苟斯的镜像', '', '', 0, 83, 83, 2, 35, 0, 1, 1.07143, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (250004, 0, 0, 0, 0, 0, '伊米隆国王的镜像', '', '', 0, 83, 83, 2, 35, 0, 1, 1.07143, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (250005, 0, 0, 0, 0, 0, '先知萨隆亚的镜像', '', '', 0, 83, 83, 2, 35, 0, 1, 1.07143, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (250006, 0, 0, 0, 0, 0, '迦尔达拉的镜像', '', '', 0, 83, 83, 2, 35, 0, 1, 1.07143, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (250007, 0, 0, 0, 0, 0, '玛尔加尼斯的镜像', '', '', 0, 83, 83, 2, 35, 0, 1, 1.07143, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (250008, 0, 0, 0, 0, 0, '塑铁者斯约尼尔的镜像', '', '', 0, 83, 83, 2, 35, 0, 1, 1.07143, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (250009, 0, 0, 0, 0, 0, '洛肯的镜像', '', '', 0, 83, 83, 2, 35, 0, 1, 1.07143, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (250010, 0, 0, 0, 0, 0, '阿努巴拉克的镜像', '', '', 0, 83, 83, 2, 35, 0, 1, 1.07143, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (250011, 0, 0, 0, 0, 0, '传令官沃拉兹的镜像', '', '', 0, 83, 83, 2, 35, 0, 1, 1.07143, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (250012, 0, 0, 0, 0, 0, '塞安妮苟萨的镜像', '', '', 0, 83, 83, 2, 35, 0, 1, 1.07143, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);

-- 镜像NPC模型
DELETE FROM `creature_template_model` WHERE `CreatureID` BETWEEN 250001 AND 250012;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (250001, 0, 32201, 1, 1, 12340);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (250002, 0, 32202, 0.45, 1, 12340);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (250003, 0, 32203, 0.4, 1, 12340);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (250004, 0, 32204, 1, 1, 12340);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (250005, 0, 32205, 1, 1, 12340);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (250006, 0, 32206, 1.8, 1, 12340);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (250007, 0, 32207, 1.5, 1, 12340);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (250008, 0, 32208, 1, 1, 12340);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (250009, 0, 32209, 0.7, 1, 12340);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (250010, 0, 32210, 0.5, 1, 12340);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (250011, 0, 32211, 1.1, 1, 12340);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (250012, 0, 32212, 0.4, 1, 12340);

-- 镜像NPC模型信息
DELETE FROM `creature_model_info` WHERE `DisplayID` BETWEEN 32201 AND 32212;
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`) VALUES (32201, 1, 3.85, 2, 0);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`) VALUES (32202, 1, 3.85, 2, 0);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`) VALUES (32203, 1, 3.85, 2, 0);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`) VALUES (32204, 1, 3.85, 2, 0);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`) VALUES (32205, 1, 3.85, 2, 0);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`) VALUES (32206, 1, 3.85, 2, 0);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`) VALUES (32207, 1, 3.85, 2, 0);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`) VALUES (32208, 1, 3.85, 2, 0);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`) VALUES (32209, 1, 3.85, 2, 0);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`) VALUES (32210, 1, 3.85, 2, 0);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`) VALUES (32211, 1, 3.85, 2, 0);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`) VALUES (32212, 1, 3.85, 2, 0);