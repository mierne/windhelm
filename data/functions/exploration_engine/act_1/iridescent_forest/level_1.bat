title Windhelm - %windhelm.ut% ^| Iridescent Forest: The Grove ^| %player.name% the %player.race% %player.class%
mode con: cols=125 lines=20
rem Check if this level has been cleared by the player.
if %player.iridescent_forest_level_1_enemy_remaining% LEQ 0 (
    set "displayMessage=You've already cleared this level!"
    goto :eof
)
rem Prevent the player from getting stuck
if "%rtm%" == "explore_iridescent_forest" (
    set "rtm=scene_1"
)

rem Resume from last known location
if not "%player.iridescent_forest_level_1_location%" == "NotStarted" (
    goto :%player.iridescent_forest_level_1_location%
) else (
    goto :scene_1
)

:scene_1
set "rtm=scene_1"
set "player.iridescent_forest_level_1_location=scene_1"
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage% ^| Enemies remaining in this area: %player.iridescent_forest_level_1_enemy_remaining%
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| As you make your way through the forest, you notice a clearing through some brush and decide to take a look.
echo ^| Emerging on the other side, you find yourself in a beautiful grove, lush with trees and other flora.
echo ^| There are several strange plants which you do not recognize. You also notice some abandoned baskets, barrels and crates.
echo ^| Further into the grove, you also see an abandoned wagon and several grazing horses.
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Examine the plants ] ^| [2 / Examine the barrels ] ^| [3 / Move to the wagon ] ^| [4 / Travel ]
set /p ch="> "
if /i "%ch%" == "1" goto :scene_1_examine_plants
if /i "%ch%" == "2" goto :scene_1_examine_barrels
if /i "%ch%" == "3" goto :scene_1_examine_wagon
if /i "%ch%" == "4" goto :scene_1_travel
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave
goto :unknown_input

:scene_1_travel
mode con: cols=125 lines=20
set "rtm=scene_1"
set "player.iridescent_forest_level_1_location=scene_1"
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage% ^| Enemies remaining in this area: %player.iridescent_forest_level_1_enemy_remaining%
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| Travel through the area? You may encounter an enemy. %PA%
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Travel ] ^| [2 / Think again...]
set /p ch="> "
if /i "%ch%" == "1" goto :scene_1_travel_roll
if /i "%ch%" == "2" goto :scene_1
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave
goto :unknown_input

:scene_1_travel_roll
call %waitani%
SET /A PA=%RANDOM% %%20
if %PA% GEQ 10 (
    goto :iridescent_forest_player_encounter_generic
) else (
    set "displayMessage=You didn't find anything..."
    goto :scene_1_travel
)

:scene_1_inti_roll_results
set "rtm=scene_1"
set "player.iridescent_forest_level_1_location=scene_1"
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage% ^| Enemies remaining in this area: %player.iridescent_forest_level_1_enemy_remaining%
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| You rolled: %dieroll%
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Continue ]
set /p ch="> "
if /i "%ch%" == "1" call :begin_combat_normal
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave
goto :unknown_input

:scene_1_examine_plants
if %player.scene_1_examine_plants% == complete (
    set displayMessage=You've already done this.
    goto :%rtm%
)
set "rtm=scene_1_examine_plants"
set "player.iridescent_forest_level_1_location=scene_1_examine_plants"
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| You move in closer to the plants, intent on studying them. However, as you approach you notice one of the plants emit
echo ^| a cloud of gas. You react by..
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Roll away (ATHLETICS) ] ^| [2 / Cover your face and back away (INTELLIGENCE) ] ^| [3 / Back up slowly ]
set /p ch="> "
if /i "%ch%" == "1" goto :scene_1_examine_plants_athletics_check
if /i "%ch%" == "2" goto :scene_1_examine_plants_intelligence_check
if /i "%ch%" == "3" goto :scene_1_examine_plants_back_up
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_plants_athletics_check
set "rtm=scene_1_examine_plants_athletics_check"
set "player.iridescent_forest_level_1_location=scene_1_examine_plants_athletics_check"
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| Roll with ATHLETICS? Your current athletics skill is: %player.skill_athletics%.
echo ^| You must roll a 15 or higher to succeed this check.
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Roll 1d20 +%player.skill_athletics%] ^| [2 / Think again... ]
set /p ch="> "
if /i "%ch%" == "1" call :roll scene_1_examine_plants_athletics_check_roll_success scene_1_examine_plants_athletics_check_roll_failure %player.skill_athletics% 15
if /i "%ch%" == "2" goto :scene_1_examine_plants
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_plants_athletics_check_roll_success
set "rtm=scene_1_examine_plants_athletics_check_roll_success"
set "player.iridescent_forest_level_1_location=scene_1_examine_plants_athletics_check_roll_success"
set player.scene_1_examine_plants=complete
set player.hazard_spotted_pod_known=1
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%^^!
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| You roll away from the noxious cloud just in time to avoid breathing any of it in. You safely observe the plant
echo ^| from a distance now. In the future, similar plants can be spotted by the name "spotted pod".
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Continue ]
set /p ch="> "
if /i "%ch%" == "1" goto :scene_1
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_plants_athletics_check_roll_failure
set "rtm=scene_1_examine_plants_athletics_check_roll_failure"
set "player.iridescent_forest_level_1_location=scene_1_examine_plants_athletics_check"
set player.scene_1_examine_plants=complete
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%^^!
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| Despite your best efforts to quickly roll away, you don't manage to escape the gaseous cloud in time.
echo ^| You manage to crawl away from the cloud before it kills you.
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Continue ]
set /p ch="> "
if /i "%ch%" == "1" goto :scene_1
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_plants_intelligence_check
set "rtm=scene_1_examine_plants_intelligence_check"
set "player.iridescent_forest_level_1_location=scene_1_examine_plants_intelligence_check"
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| Roll with INTELLIGENCE? Your current intelligence skill is: %player.skill_intelligence%.
echo ^| You must roll a 15 or higher to succeed this check.
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Roll ] ^| [2 / Think again... ]
set /p ch="> "
if /i "%ch%" == "1" call :roll scene_1_examine_plants_intellgience_check_roll_success scene_1_examine_plants_intelligence_check_roll_failure %player.skill_intelligence% 15
if /i "%ch%" == "2" goto :scene_1_examine_plants
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_plants_intellgience_check_roll_success
set "rtm=scene_1_examine_plants_intellgience_check_roll_success"
set "player.iridescent_forest_level_1_location=scene_1_examine_plants_intellgience_check_roll_success"
set player.scene_1_examine_plants=complete
set player.hazard_spotted_pod_known=1
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%^^!
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| You quickly cover your mouth and nose, and quickly back away before the noxious cloud can envelop you.
echo ^| In the future, similar plants can be spotted by the name "spotted pod".
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Continue ]
set /p ch="> "
if /i "%ch%" == "1" goto :scene_1
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_plants_intelligence_check_roll_failure
set "rtm=scene_1_examine_plants_intelligence_check_roll_failure"
set "player.iridescent_forest_level_1_location=scene_1_examine_plants_intelligence_check"
set player.scene_1_examine_plants=complete
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%^^!
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| You spend a moment too long thinking about the gas, and end up inhaling it. Your lungs feel as if they're on fire.
echo ^| You manage to crawl away from the cloud before it kills you.
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Continue ]
set /p ch="> "
if /i "%ch%" == "1" goto :scene_1
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_plants_back_up
set "rtm=scene_1_examine_plants_back_up"
set "player.iridescent_forest_level_1_location=scene_1_examine_plants_back_up"
set player.scene_1_examine_plants=complete
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| You back up slowly in an attempt to avoid the plant's defenses, but you're too slow. The noxious gas knocks you to your
echo ^| feet, but you managed to crawl away in time before it could do more damage.
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Continue ]
set /p ch="> "
if /i "%ch%" == "1" goto :scene_1
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_barrels
if %player.scene_1_examine_barrels% == complete (
    set displayMessage=You've already done this.
    goto :%rtm%
)
set "rtm=scene_1_examine_barrels"
set "player.iridescent_forest_level_1_location=scene_1_examine_barrels"
set player.scene_1_examine_barrels=complete
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| As you lift the lid from the barrels, you're greeted with... an empty barrel. There remains crumbs from a long gone food.
echo ^| You wonder if perhaps the wagon was carrying this barrel and if they had fallen off.
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Continue ]
set /p ch="> "
if /i "%ch%" == "1" goto :scene_1
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_wagon
if %player.scene_1_examine_wagon% == complete (
    set displayMessage=You've already done this.
    goto :%rtm%
)
set "rtm=scene_1"
set "player.iridescent_forest_level_1_location=scene_1"
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| As you inch closer to the horses and wagon, one of the horses notices you and spooks, bolting before you can get closer.
echo ^| You notice a chest in the back of the wagon, it might contain something useful...
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Inspect the area (INTELLIGENCE)] ^| [2 / Check the chest ]
set /p ch="> "
if /i "%ch%" == "1" goto :scene_1_examine_wagon_inspect_area
if /i "%ch%" == "2" goto :scene_1_examine_wagon_check_chest
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_wagon_inspect_area
if %player.s1_exwag_inspect_area% == complete (
    set displayMessage=You've already done this.
    goto :%rtm%
)
set "rtm=scene_1_examine_wagon_inspect_area"
set "player.iridescent_forest_level_1_location=scene_1_examine_wagon_inspect_area"
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| Roll with INTELLIGENCE? Your current intelligence skill is: %player.skill_intelligence%
echo ^| You must roll a 10 or higher to succeed this check.
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Roll 1d20 +%player.skill_intelligence%] ^| [2 / Think again... ]
set /p ch="> "
if /i "%ch%" == "1" call :roll scene_1_examine_wagon_inspect_area_roll_success scene_1_examine_wagon_inspect_area_roll_failure %player.skill_intelligence% 10
if /i "%ch%" == "2" goto :scene_1_examine_wagon
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_wagon_inspect_area_roll_success
set "rtm=scene_1_examine_wagon_inspect_area_roll_success"
set "player.iridescent_forest_level_1_location=scene_1_examine_wagon_inspect_area_roll_success"
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%^^!
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| You look closely at the surrounding area and notice a faint footprint in the dirt. You look further down the trail it
echo ^| created and notice a pool of blood next to some tall, thick grass.
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Continue ]
set /p ch="> "
if /i "%ch%" == "1" goto :scene_1_examine_wagon_inspect_area_roll_success_follow_trail
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_wagon_inspect_area_roll_success_follow_trail
set "rtm=scene_1_examine_wagon_inspect_area_roll_success_follow_trail"
set "player.iridescent_forest_level_1_location=scene_1_examine_wagon_inspect_area_roll_success_follow_trail"
set player.scene_1_examine_wagon=complete
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%^^!
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| You carefully follow the trail up to the grass. You hesitate a moment before pushing aside the grass to peer inside.
echo ^| Among the tall grass lay a corpse, filled with arrows. Whoever this was had been ambushed and attacked.
echo ^| Beside them lay a bloody note and a longsword.
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Collect items ] ^| [2 / Leave ]
set /p ch="> "
if /i "%ch%" == "1" goto :scene_1_examine_wagon_inspect_area_roll_success_follow_trail_collect_ambush
if /i "%ch%" == "2" goto :scene_1_examine_wagon_inspect_area_roll_success_follow_trail_collect_ambush_2
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_wagon_inspect_area_roll_success_follow_trail_collect_ambush
set /a player.item_long_sword_owned=!player.item_long_sword_owned! +1
set "rtm=scene_1_examine_wagon_inspect_area_roll_success_follow_trail_collect_ambush"
set "player.iridescent_forest_level_1_location=scene_1_examine_wagon_inspect_area_roll_success_follow_trail_collect_ambush"
set player.scene_1_examine_wagon=complete
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%^^!
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| As you kneel down to collect the bloody note, you hear footsteps running up behind you.
echo ^| You turn to face the one running you down and lock eyes with a bandit, their sword drawn and ready to strike.
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Battle ]
set /p ch="> "
if /i "%ch%" == "1" goto :begin_combat_normal
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_wagon_inspect_area_roll_success_follow_trail_collect_ambush_2
set "rtm=scene_1_examine_wagon_inspect_area_roll_success_follow_trail_collect_ambush_2"
set "player.iridescent_forest_level_1_location=scene_1_examine_wagon_inspect_area_roll_success_follow_trail_collect_ambush_2"
set player.scene_1_examine_wagon=complete
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%^^!
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| You turn around to leave the corpse and items behind when you notice a figure hiding in the grass.
echo ^| The bandit hiding there notices you, jumping out from the grass. You draw your weapon and prepare for a battle.
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Battle ]
set /p ch="> "
if /i "%ch%" == "1" goto :begin_combat_normal
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:scene_1_examine_wagon_inspect_area_roll_failure
set "rtm=scene_1_examine_wagon_inspect_area_roll_failure"
set "player.iridescent_forest_level_1_location=scene_1_examine_wagon_inspect_area"
set player.s1_exwag_inspect_area=complete
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%^^!
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| You look closely at the surrounding area but notice nothing out of the ordinary.
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Continue ]
set /p ch="> "
if /i "%ch%" == "1" goto :iridescent_forest_player_ambushed
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:iridescent_forest_player_ambushed
set "rtm=scene_1_examine_wagon_inspect_area_roll_failure"
set "player.iridescent_forest_level_1_location=scene_1_examine_wagon_inspect_area"
set player.s1_exwag_inspect_area=complete
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%^^!
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| Before you can look around more, a bandit rushes you from behind the wagon.
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Continue ]
set /p ch="> "
if /i "%ch%" == "1" goto :begin_combat_ambush
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:iridescent_forest_player_encounter_generic
mode con: cols=125 lines=20
set "rtm=scene_1_examine_wagon_inspect_area_roll_failure"
set "player.iridescent_forest_level_1_location=scene_1"
cls
echo.
type "%winLoc%\data\assets\ui\the_grove.txt"
echo.
echo %displayMessage%^^!
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| You rolled an enemy encounter!
echo +---------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / Continue ]
set /p ch="> "
if /i "%ch%" == "1" goto :begin_combat_normal
if /i "%ch%" == "S" goto :save_game
if /i "%ch%" == "E" goto :autosave

:begin_combat_ambush
call "%winLoc%\data\functions\combat_engine\combat_engine.bat" Bandit
goto :eof

:begin_combat_normal
call "%winLoc%\data\functions\combat_engine\combat_engine.bat" Bandit
goto :eof

:roll
call "%winLoc%\data\functions\roll.bat"
set /a dieroll=%dieroll% +%3
if %dieroll% geq %4 (
    set "displayMessage=You rolled a %dieroll%, success!"
    goto :%1
) else (
    set "displayMessage=You rolled a %dieroll%, failure!"
   goto :%2
)

:save_game
SET SLOPr=SAVE
CALL "%cd%\data\functions\SLOP.bat"
SET displayMessage=Game saved.
goto :%rtm%

:autosave
SET SLOPr=SAVE
CALL "%cd%\data\functions\SLOP.bat"
goto :eof

:unknown_input
echo Unknown option, please try again.
goto :%rtm%