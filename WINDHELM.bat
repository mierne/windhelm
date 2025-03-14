@ECHO OFF & SETLOCAL ENABLEDELAYEDEXPANSION
REM Copyright (C) 2025 Mierne <ahoy@mierne.net>
REM    This program is free software: you can redistribute it and/or modify
REM    it under the terms of the GNU General Public License as published by
REM    the Free Software Foundation, either version 3 of the License, or
REM    (at your option) any later version.
REM    This program is distributed in the hope that it will be useful,
REM    but WITHOUT ANY WARRANTY; without even the implied warranty of
REM    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM    GNU General Public License for more details.
REM    You should have received a copy of the GNU General Public License
REM    along with this program.  If not, see <https://www.gnu.org/licenses/>.

:WIN_INIT
SET winLoc=%~dp0
SET windhelm.ut=Interim
SET SLOPr=INIT
CALL "%winLoc%\data\functions\SLOP.bat"

:SETTINGS_LOADER
(
SET /P setColor=
)<"%winLoc%\data\settings.txt"
GOTO :setCheck

:setCheck
color %setColor%
SET displayMessage=...
GOTO :START

:START
TITLE (Windhelm - %windhelm.ut%) ^| Welcome to Windhelm.
MODE con: cols=120 lines=19
CLS
SET RETURN=START
ECHO.
TYPE "%winLoc%\data\assets\ui\main.txt"
ECHO.
ECHO.
ECHO Pre-Alpha Version %windhelm.vn% "Interim"
ECHO ========================================================================================================================
ECHO                   [1 / CONTINUE ] ^| [2 / NEW GAME ] ^| [3 / SETTINGS ] ^| [4 / ABOUT ] ^| [Q / QUIT ]
ECHO.
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :LOAD_SAVE
IF /I "%CH%" == "2" GOTO :NEW_GAME
IF /I "%CH%" == "3" GOTO :SETTINGS
IF /I "%CH%" == "4" GOTO :ABOUT
IF /I "%CH%" == "Q" GOTO :EOF
GOTO :INVALID_INPUT

:ABOUT
TITLE (Windhelm - %windhelm.ut%) ^| About Windhelm
MODE con: cols=120 lines=19
CLS
SET RETURN=ABOUT
ECHO.
REM TO DO: about.txt
TYPE "%winLoc%\data\assets\ui\about.txt"
ECHO.
ECHO.
ECHO Windhelm Version %windhelm.vn%
ECHO This is a STABLE build. Check the github page for more information.
ECHO.
ECHO Delve into the powerful, mysterious Iridescent Forest of the Kindgom of Fulkwinn and it's equally powerful castle,
ECHO Windhelm! Discover shards of your past and rebuild your identity, or forge a new one. Your destiny is yours to control
ECHO alone. Take on the threats of the Iridescent Forest, defending it from those that wish it harm.
ECHO Use soul memories to unlock special abilites and form strong bonds to other shards.
ECHO ========================================================================================================================
ECHO                   [Q / RETURN ]
ECHO.
SET /P CH=">"
IF /I "%CH%" == "Q" GOTO :START
GOTO :INVALID_INPUT

:SETTINGS
TITLE (Windhelm - %windhelm.ut%) ^| Settings Menu.
MODE con: cols=100 lines=14
CLS
SET RETURN=SETTINGS
ECHO.
TYPE "%cd%\data\assets\ui\settings.txt"
ECHO.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / CHANGE THEME ] ^| [Q / EXIT ]                                                                +
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :theme_select
IF /I "%CH%" == "Q" GOTO :START
GOTO :INVALID_INPUT

:theme_select
MODE con: cols=100 lines=15
CLS
SET RETURN=theme_select
ECHO.
TYPE "%cd%\data\assets\ui\color.txt"
ECHO.
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / 0E DEFAULT ] ^| [2 / 1F HIGH VIS ] ^| [C / CUSTOM ] ^| [Q / EXIT ]                             +
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :0E
IF /I "%CH%" == "2" GOTO :1F
IF /I "%CH%" == "C" GOTO :CUSTOM_COLOR
IF /I "%CH%" == "Q" GOTO :SETTINGS
GOTO :INVALID_INPUT

:CUSTOM_COLOR
MODE con: cols=100 lines=16
CLS
SET RETURN=CUSTOM_COLOR
ECHO.
TYPE "%cd%\data\assets\ui\color.txt"
ECHO.
ECHO ENTER A VALID BATCH SCRIPT COLOR CODE. (SEE COLOR /?)
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 HELP ] [Q / EXIT ]                                                                            +
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :THEME_CUSTOM_HELP
IF /I "%CH%" == "Q" GOTO :SETTINGS
COLOR %CH%
SET setColor=%CH%
GOTO :THEME_SAVE

:THEME_CUSTOM_HELP
ECHO Opening CMD with command COLOR /?
START COLOR /?
PAUSE
GOTO :CUSTOM_COLOR

:0E
set setColor=0E
color 0E
set displayMessage=Color 0E applied.
GOTO :THEME_SAVE

:1F
set setColor=1F
COLOR 1F
set displayMessage=Color 1F applied.
GOTO :THEME_SAVE

:THEME_SAVE
(
ECHO %setColor%
)>"%winLoc%\data\settings.txt"
SET displayMessage=Color %setColor% applied.
GOTO :%RETURN%

:NEW_GAME
CALL "%winLoc%\data\functions\ciac.bat"
IF %OSQ% EQU 1 (
    GOTO :START
) ELSE (
    GOTO :dashboard
)

:LOAD_SAVE
SET SLOPr=LOAD
IF NOT EXIST "%winLoc%\data\player\savedata.txt" (
    ECHO Player data not found - please make a new save.
    PAUSE
    GOTO :START
) ELSE (
    CALL "%winLoc%\data\functions\SLOP.bat"
    GOTO :dashboard
)

:dashboard
TITLE (Windhelm - %windhelm.ut%) Castle Gate ^| %player.name% the %player.race% %player.class%
MODE con: cols=101 lines=17
IF %player.xp% LSS 0 SET player.xp=0
IF %player.health% LSS 0 set player.health=0
CLS
SET RETURN=dashboard
ECHO.
TYPE "%winLoc%\data\assets\ui\Windhelm.txt"
ECHO.
ECHO %displayMessage%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| [1 / EXPLORE ] ^| [2 / INVENTORY ] ^| [C / VIEW CHARACTER ] ^| [S / SAVE ] ^| [Q / EXIT ]
ECHO +---------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :exploration_engine
IF /I "%CH%" == "2" GOTO :view_inventory
IF /I "%CH%" == "C" GOTO :character_view
IF /I "%CH%" == "S" GOTO :Save_Game
IF /I "%CH%" == "Q" GOTO :Exit_Without_Saving
GOTO :INVALID_INPUT

:Exit_Without_Saving
ECHO Exit now? All unsaved progress will be lost.
SET /P CH="Y/N"
IF /I "%CH%" == "Y" GOTO :START
IF /I "%CH%" == "N" GOTO :dashboard
GOTO :INVALID_INPUT

:Save_Game
SET SLOPr=SAVE
CALL "%winLoc%\data\functions\SLOP.bat"
SET displayMessage=Your game was saved.
GOTO :dashboard

:view_inventory
CALL "%winLoc%\data\functions\Inventory Viewer.bat"
GOTO :dashboard

:character_view
MODE con: cols=105 lines=21
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\character.txt"
ECHO.
ECHO %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO ^| NAME: %player.name% ^| RACE: %player.race% ^| CLASS: %player.class% ^| PRONOUNS: %player.personal_p_1%/%player.personal_p_2%/%player.possesive_1%/%player.reflexive_1%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE: %player.skill_damage% ^| MAGICKA: %player.skill_magicka% ^| ATHLETICS: %player.skill_athletics% ^| SPEECH: %player.skill_speech% ^| INTELLIGENCE: %player.skill_intelligence%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| BANDITS SLAIN: %player.bandits_slain%
ECHO ^| TOTAL DEATHS: %player.total_deaths%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / LEVEL UP ] ^| [2 / CHANGE NAME ] ^| [3 / CHANGE PRONOUNS ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :PLAYER_LEVEL_UP
IF /I "%CH%" == "2" GOTO :PLAYER_CHANGE_NAME
IF /I "%CH%" == "3" GOTO :PLAYER_CHANGE_PRONOUNS
IF /I "%CH%" == "Q" GOTO :dashboard
GOTO :INVALID_INPUT

:PLAYER_LEVEL_UP
CALL "%winLoc%\data\functions\leveler.bat"
GOTO :character_view

:PLAYER_CHANGE_NAME
SET player.name_old=%player.name%
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\name.txt"
ECHO.
ECHO Enter a new name.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| TYPE CANCEL TO CANCEL.
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P player.name=
IF /I "%player.name%" == "CANCEL" GOTO :PLAYER_NAME_CANCEL
GOTO :AUTOSAVE

:PLAYER_NAME_CANCEL
SET player.name=%player.name_old%
GOTO :character_view

:PLAYER_CHANGE_PRONOUNS
SET player.pronouns_change_req=1
CALL "%winLoc%\data\functions\ciac.bat"
GOTO :AUTOSAVE

:exploration_engine
CALL "%winLoc%\data\Exploration Engine\exploration_engine.bat"
GOTO :AUTOSAVE

:INVALID_INPUT
ECHO %CH% is not a valid choice.
PAUSE
GOTO :%RETURN%

:AUTOSAVE
SET SLOPr=SAVE
SET displayMessage=Game saved.
CALL "%cd%\data\functions\SLOP.bat"
GOTO :dashboard