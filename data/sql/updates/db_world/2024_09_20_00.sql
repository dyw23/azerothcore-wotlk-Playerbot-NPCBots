-- DB update 2024_09_16_00 -> 2024_09_20_00
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 134217728 WHERE `entry` = 23403;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23403) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23403, 0, 2, 0, 0, 0, 100, 0, 0, 15000, 30000, 40000, 0, 0, 11, 41392, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Illidari Assassin - In Combat - Cast Riposte');
