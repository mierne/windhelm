if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
@ECHO OFF & SETLOCAL ENABLEDELAYEDEXPANSION
REM Copyright (C) 2021-2025 Mierne <ahoy@mierne.net>
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
SET windhelm.ut=Nightfall
SET SLOPr=INIT
SET asint=0
CALL "%winLoc%\data\functions\SLOP.bat"

:windhelm_game_configurer
color %windhelm.theme_color%
SET displayMessage=...
GOTO :START

:START
TITLE (Windhelm - %windhelm.ut%) ^| Welcome to Windhelm.
MODE con: cols=120 lines=15
CLS
SET RETURN=START
ECHO.
TYPE "%winLoc%\data\assets\ui\main.txt"
ECHO.
ECHO.
ECHO Pre-Alpha Version %windhelm.vn% "Nightfall"
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
MODE con: cols=120 lines=21
CLS
SET RETURN=ABOUT
ECHO.
TYPE "%winLoc%\data\assets\ui\about.txt"
ECHO     Version %windhelm.vn%
ECHO ========================================================================================================================
IF %windhelm.enable_stability_warning% EQU 1 ECHO This is an UNSTABLE build. Check the github page for more information.
ECHO.
ECHO Delve into the powerful, mysterious Iridescent Forest of the Kindgom of Fulkwinn and it's equally powerful castle,
ECHO Windhelm^^! Discover shards of your past and rebuild your identity, or forge a new one. Your destiny is yours to control
ECHO alone. Take on the threats of the Iridescent Forest, defending it from those that wish it harm.
ECHO Use soul memories to unlock special abilites and form strong bonds to other shards.
ECHO ========================================================================================================================
ECHO [1 / GITHUB PAGE ] ^| [2 / WEB PAGE ] ^| [Q / RETURN ]
ECHO.
ECHO Copyright (C) 2021-2025 Mierne ^<ahoy@mierne.net^> licensed under GNU GPLv3
SET /P CH=">"
IF /I "%CH%" == "1" START https://www.github.com/mierne/windhelm && GOTO :ABOUT
IF /I "%CH%" == "2" START https://mierne.net/windhelm && GOTO :ABOUT
IF /I "%CH%" == "Q" GOTO :START

:SETTINGS
TITLE (Windhelm - %windhelm.ut%) ^| Settings Menu.
MODE con: cols=100 lines=14
CLS
SET RETURN=SETTINGS
ECHO.
TYPE "%cd%\data\assets\ui\settings.txt"
ECHO.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / CHANGE THEME ] ^| [2 / TRANSITION CONFIGURATION ] ^| [Q / EXIT ]                              +
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :theme_select
IF /I "%CH%" == "2" GOTO :TRANS_CONFIG
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
SET windhelm.theme_color=%CH%
GOTO :SAVE_SETTINGS

:THEME_CUSTOM_HELP
ECHO Opening CMD with command COLOR /?
START COLOR /?
PAUSE
GOTO :CUSTOM_COLOR

:0E
set windhelm.theme_color=0E
color 0E
set displayMessage=Color 0E applied.
GOTO :SAVE_SETTINGS

:1F
set windhelm.theme_color=1F
COLOR 1F
set displayMessage=Color 1F applied.
GOTO :SAVE_SETTINGS

:TRANS_CONFIG
MODE con: cols=100 lines=15
CLS
SET RETURN=TRANS_CONFIG
ECHO.
TYPE "%cd%\data\assets\ui\delay_config.txt"
ECHO.
ECHO %displayMessage% ^| The current delay is: %windhelm.transition_delay%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / DEFAULT (300MS) ] ^| [C / CUSTOM ] ^| [Q / EXIT ]                                             +
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :TC_DEFAULT
IF /I "%CH%" == "C" GOTO :TC_CUSTOM
IF /I "%CH%" == "Q" GOTO :SETTINGS
GOTO :INVALID_INPUT

:TC_DEFAULT
SET windhelm.transition_delay=300
GOTO :SAVE_SETTINGS

:TC_CUSTOM
SET /P TCT="Set a custom transition animation delay (in ms): "
SET windhelm.transition_delay=%TCT%
GOTO :SAVE_SETTINGS

:SAVE_SETTINGS
(
ECHO %windhelm.theme_color%
ECHO %windhelm.transition_delay%
)>"%winLoc%\data\settings.txt"
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
MODE con: cols=101 lines=18
IF %player.xp% LSS 0 SET player.xp=0
IF %player.health% LSS 0 set player.health=0
SET /A asint=!asint! +1
IF %asint% GEQ 10 GOTO :AUTOSAVE
CLS
SET RETURN=dashboard
ECHO.
TYPE "%winLoc%\data\assets\ui\Windhelm.txt"
ECHO.
ECHO %displayMessage% %player.ifor_level_1_searched%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| [1 / EXPLORE ] ^| [2 / INVENTORY ] ^| [V / VIEW CHARACTER ] ^| [C / HANDBOOK ]
ECHO ^| [S / SAVE ]    ^| [Q / EXIT ]
ECHO +---------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :exploration_engine
IF /I "%CH%" == "2" GOTO :view_inventory
IF /I "%CH%" == "V" GOTO :character_view
IF /I "%CH%" == "S" GOTO :Save_Game
IF /I "%CH%" == "Q" GOTO :Exit_Without_Saving
IF /I "%CH%" == "C" GOTO :catalogue
GOTO :INVALID_INPUT

:Exit_Without_Saving
SET CH=Y
ECHO Exit now? All unsaved progress will be lost.
SET /P CH="Y/n "
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
MODE con: cols=113 lines=22
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\character.txt"
ECHO.
ECHO %displayMessage%
ECHO +---------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO ^| NAME: %player.name% ^| RACE: %player.race% ^| CLASS: %player.class% ^| PRONOUNS: %player.personal_p_1%/%player.personal_p_2%/%player.possesive_1%/%player.reflexive_1% ^| ORIGIN: %player.origin%
ECHO +---------------------------------------------------------------------------------------------------------------+
ECHO ^| WEAPON: %player.weapon_equipped% ^| DAMAGE: %player.skill_damage% ^| MAGICKA: %player.skill_magicka% ^| ATHLETICS: %player.skill_athletics% ^| SPEECH: %player.skill_speech% ^| INTELLIGENCE: %player.skill_intelligence%
ECHO +---------------------------------------------------------------------------------------------------------------+
ECHO ^| BANDITS SLAIN: %player.bandits_slain%
ECHO ^| TOTAL DEATHS: %player.total_deaths%
ECHO +---------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / LEVEL UP ] ^| [2 / CHANGE NAME ] ^| [3 / CHANGE PRONOUNS ] ^| [Q / BACK ]
ECHO +---------------------------------------------------------------------------------------------------------------+
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
MODE con: cols=113 lines=16
SET player.name_old=%player.name%
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\your_name.txt"
ECHO.
ECHO Enter a new name.
ECHO +---------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +---------------------------------------------------------------------------------------------------------------+
ECHO ^| TYPE CANCEL TO CANCEL.
ECHO +---------------------------------------------------------------------------------------------------------------+
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
SET PE_CALL=Exploration_Engine
CALL "%winLoc%\data\functions\Pulse Engine.bat"
GOTO :AUTOSAVE

:catalogue
TITLE (Windhelm - %windhelm.ut%) Player Handbook ^| %player.name% the %player.race% %player.class%
CLS
SET RETURN=catalogue
ECHO.
TYPE "%winLoc%\data\assets\ui\Windhelm.txt"
ECHO.
ECHO %displayMessage% ^| Total discovered: %player.catalogue_unlocked%/%player.catalogue_locked%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| [1 / HUMANOIDS ]
ECHO ^| [Q / EXIT ]
ECHO +---------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :catalogue_category_humanoids
IF /I "%CH%" == "Q" GOTO :dashboard
GOTO :INVALID_INPUT

:catalogue_category_humanoids
TITLE (Windhelm - %windhelm.ut%) Player Handbook - Humanoids ^| %player.name% the %player.race% %player.class%
MODE con: cols=101 lines=18
CLS
SET RETURN=catalogue_category_humanoids
ECHO.
TYPE "%winLoc%\data\assets\ui\Windhelm.txt"
ECHO.
ECHO %displayMessage% ^| Total discovered: %player.catalogue_unlocked%/%player.catalogue_locked%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| [1 / %player.catalogue_bandit% ] ^| [2 / %player.catalogue_abyss_guardian% ] ^| [ 3 / %player.catalogue_wandering_trader% ]
ECHO ^| [Q / EXIT ]
ECHO +---------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :catalogue_check_bandit
IF /I "%CH%" == "2" GOTO :catalogue_check_abgu
IF /I "%CH%" == "3" GOTO :catalogue_check_wantra
IF /I "%CH%" == "Q" GOTO :catalogue
GOTO :INVALID_INPUT

:catalogue_check_bandit
REM Check if the Player has this entry unlocked.
IF %player.catalogue_bandit_encountered% EQU 0 (
    SET displayMessage=You haven't encountered this yet.
    GOTO :catalogue_category_humanoids
) ELSE (
    GOTO :catalogue_view_bandit
)

:catalogue_check_abgu
REM Check if the Player has this entry unlocked.
IF %player.catalogue_abyss_guardian_encountered% EQU 0 (
    SET displayMessage=You haven't encountered this yet.
    GOTO :catalogue_category_humanoids
) ELSE (
    GOTO :catalogue_view_abgu
)

:catalogue_check_wantra
REM Check if the Player has this entry unlocked.
IF %player.catalogue_wandering_trader_encountered% EQU 0 (
    SET displayMessage=You haven't encountered this yet.
    GOTO :catalogue_category_humanoids
) ELSE (
    GOTO :catalogue_view_wantra
)

:catalogue_view_bandit
MODE con: cols=120 lines=24
SET RETURN=catalogue_view_bandit
CLS
ECHO.
TYPE "%cd%\data\assets\enemies\Iridescent Forest\bandit.txt"
ECHO.
ECHO.
ECHO Viewing the BANDIT Handbook entry.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| Your average no good thief. Bandits are a common sight on the roads outside of Windhelm.
ECHO ^| They might not be very strong, but they are crafty and there are a LOT of them.
ECHO ^| BANDIT stats:
ECHO ^|----------------------------------------------------------------------------------------------------------------------+
ECHO ^| Health: 80 ^| Magicka: 100
ECHO ^| Damage: 14 ^| Resistance Type: Physical ^| Total Resistance: 0
ECHO ^| Faction: Non-Aligned
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [Q / BACK]
SET /P CH=">"
IF /I "%CH%" == "Q" GOTO :catalogue_category_humanoids
GOTO :INVALID_INPUT

:catalogue_view_abgu
MODE con: cols=120 lines=24
SET RETURN=catalogue_view_abgu
CLS
ECHO.
TYPE "%cd%\data\assets\enemies\Iridescent Forest\abyss guardian.txt"
ECHO.
ECHO.
ECHO Viewing the ABYSS GUARDIAN Handbook entry.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| An unknown entity which has been found across Laera, it appears hostile to all who have encountered it.
ECHO ^| It's purpose remains unknown, but they have been most commonly spotted guarding shatter-points.
ECHO ^| Attempts at communicating with this entity has resulted in nothing but death. Do not attempt to make contact. 
ECHO ^| ABYSS GUARDIAN stats:
ECHO ^|----------------------------------------------------------------------------------------------------------------------+
ECHO ^| Health: 250 ^| Magicka: 400
ECHO ^| Damage: 20/45 ^| Resistance Type: Physical ^| Total Resistance: 12
ECHO ^| Faction: Abyss Lurkers
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [Q / BACK]
SET /P CH=">"
IF /I "%CH%" == "Q" GOTO :catalogue_category_humanoids
GOTO :INVALID_INPUT

:catalogue_view_wantra
MODE con: cols=120 lines=24
SET RETURN=catalogue_view_wantra
CLS
ECHO.
TYPE "%cd%\data\assets\enemies\Iridescent Forest\Wandering Trader.txt"
ECHO.
ECHO.
ECHO Viewing the TRAVELING MERCHANT Handbook entry.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| A trader of the Fa'Rel Union who wanders the territory surrounding Windhelm selling their goods to those who
ECHO ^| would be interested.
ECHO ^| 
ECHO ^| TRAVELING MERCHANT stats:
ECHO ^|----------------------------------------------------------------------------------------------------------------------+
ECHO ^| Health: 100 ^| Magicka: 100
ECHO ^| Damage: 0 ^| Resistance Type: Physical ^| Total Resistance: 0
ECHO ^| Faction: Fa'rel Trading Union
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [Q / BACK]
SET /P CH=">"
IF /I "%CH%" == "Q" GOTO :catalogue_category_humanoids
GOTO :INVALID_INPUT

:INVALID_INPUT
ECHO %CH% is not a valid choice.
PAUSE
GOTO :%RETURN%

:AUTOSAVE
SET SLOPr=SAVE
SET displayMessage=Game saved.
SET asint=0
CALL "%cd%\data\functions\SLOP.bat"
GOTO :dashboard