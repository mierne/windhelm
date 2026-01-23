rem Go to where the Player was last located
goto :%player.explore_last_location%

:explore
cls
mode con: cols=113 lines=18
title (Windhelm - %windhelm.ut%) Iridescent Forest ^| %player.name% the %player.race% %player.class%
set "rtm=explore"
echo.
type "%winLoc%\data\assets\ui\explore.txt"
echo.
echo Selected Act: %player.current_act% ^| %displayMessage%
echo Select an area to explore.
echo +---------------------------------------------------------------------------------------------------------------+
echo ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| ATK: %player.damage% ^| DEF: %player.armor_class% ^| MGK: %player.magicka% ^| LUNIS: %player.coins%
echo +---------------------------------------------------------------------------------------------------------------+
echo ^| [1 / IRIDESCENT FOREST ] ^| [2 / WINDHELM CASTLE ] ^| [3 / %player.act_1_next_act_unlocked% ]
echo +---------------------------------------------------------------------------------------------------------------+
set /p "CH=> "
if /i "%CH%" == "1" goto :explore_iridescent_forest
if /i "%CH%" == "2" goto :explore_windhelm_castle
if /i "%CH%" == "3" call :explore_check_status %player.act_1_next_act_unlocked% explore_act_2
if /i "%CH%" == "4" goto :autosave
goto :invalid_input

:explore_iridescent_forest
mode con: cols=140 lines=27
cls
title (Windhelm - %windhelm.ut%) Iridescent Forest ^| %player.name% the %player.race% %player.class%
set "rtm=explore_iridescent_forest"
echo.
type "%winLoc%\data\assets\ui\iridescent_forest.txt"
echo.
echo Enemies remaining: %player.iridescent_forest_level_1_enemy_remaining%
echo Current Level: %player.iridescent_forest_level%/%player.iridescent_forest_level_total% ^| %displayMessage%
echo +------------------------------------------------------------------------------------------------------------------------------------------+
echo ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| ATK: %player.damage% ^| DEF: %player.armor_class% ^| MGK: %player.magicka% ^| LUNIS: %player.coins%
echo +------------------------------------------------------------------------------------------------------------------------------------------+
echo ^| [1 / EXPLORE LEVEL ] ^| [2 / NEXT LEVEL ] ^| [3 / PREVIOUS LEVEL ]
echo +------------------------------------------------------------------------------------------------------------------------------------------+
set /p "CH=> "
if /i "%CH%" == "1" goto :explore_iridescent_forest_scene
if /i "%CH%" == "2" goto :explore_iridescent_forest_next
if /i "%CH%" == "3" GOTO :explore_iridescent_forest_previous
if /i "%CH%" == "E" goto :explore

:explore_iridescent_forest_scene
if %player.iridescent_forest_level% EQU 1 (
    call "%winLoc%\data\functions\exploration_engine\act_1\iridescent_forest\level_1.bat"
    goto :autosave
)

:explore_check_status
if "%1" == "???" (
    set "displayMessage=You haven't unlocked this yet!"
    goto :%rtm%
) else (
    goto :%2
)

:explore_iridescent_forest_next
set "displayMessage=Not implemented!"
goto :%rtm%

:explore_iridescent_forest_previous
set "displayMessage=Not implemented!"
goto :%rtm%

:explore_windhelm_castle
MODE con: cols=105 lines=17
cls
title (Windhelm - %windhelm.ut%) Windhelm Castle ^| %player.name% the %player.race% %player.class%
set "rtm=explore_windhelm_castle"
echo.
type "%winLoc%\data\assets\ui\Windhelm.txt"
echo.
echo.
echo %displayMessage%
echo +-------------------------------------------------------------------------------------------------------+
echo ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| ATK: %player.damage% ^| DEF: %player.armor_class% ^| MGK: %player.magicka% ^| LUNIS: %player.coins%
echo +-------------------------------------------------------------------------------------------------------+
echo ^| [1 / ROCKWINN PLAZA ] ^| [2 / MISSIVES BOARD ]
echo +-------------------------------------------------------------------------------------------------------+
set /p "CH=> "
if /i "%CH%" == "1" goto :explore_windhelm_castle_rockwinn_plaza
if /i "%CH%" == "2" goto :explore_windhelm_castle_missives_board
if /i "%CH%" == "E" goto :explore

:explore_windhelm_castle_rockwinn_plaza
call "%winLoc%\data\functions\Rockwinn Plaza.bat"
goto :explore_windhelm_castle

:explore_windhelm_castle_missives_board
set "displayMessage=Not added."
goto :explore_windhelm_castle

:explore_act_1_cave
echo Unfinished.
pause
goto :%rtm%

:explore_act_2
echo Unfinished.
pause
goto :%rtm%

:invalid_input
set "displayMessage="%CH%" was not a valid option."
goto :eof

:autosave
SET "SLOPr=SAVE"
CALL "%cd%\data\functions\SLOP.bat"
goto :eof