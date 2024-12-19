@ECHO OFF & SETLOCAL ENABLEDELAYEDEXPANSION
REM Windhelm Pre-Alpha Version 0.3.0.
REM Extra Build Information: 241219.PA3
REM Copyright (C) 2024  Mierne <ahoy@mierne.net>
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
REM Some things
SET winLoc=%~dp0
SET windhelm.tu=Unknown

REM Reads the settings.txt file.
:SETTINGS_LOADER
(
SET /P setColor=
)<"%winLoc%\data\settings.txt"
GOTO :setCheck

REM Applies the settings from settings.txt and prevents "ECHO IS OFF..." messages.
:setCheck
color %setColor%
SET displayMessage=...
GOTO :START

REM Main Menu, previously called the "Splashscreen". Used to access New Games, Existing Games or the Settings.
:START
TITLE (Windhelm - %windhelm.tu%) ^| Welcome to Windhelm.
MODE con: cols=120 lines=19
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\main.txt"
ECHO.
ECHO.
ECHO Pre-Alpha Version 0.3.0 (241207.PA3) "Unknown"
ECHO ========================================================================================================================
ECHO                   [1 / CONTINUE ] ^| [2 / NEW GAME ] ^| [3 / SETTINGS ] ^| [4 / ABOUT ] ^| [Q / QUIT ]
ECHO.
CHOICE /C 1234Q /N /M ">"
IF ERRORLEVEL 5 GOTO :EOF
IF ERRORLEVEl 4 GOTO :ABOUT_WINDHELM
IF ERRORLEVEL 3 GOTO :settings
IF ERRORLEVEL 2 GOTO :NEW_GAME
IF ERRORLEVEL 1 GOTO :LOAD_SAVE

REM Brief description of the game, along with credits and attributions.
:ABOUT_WINDHELM
TITLE (Windhelm - %windhelm.tu%) ^| About Windhelm
MODE con: cols=120 lines=19
CLS
ECHO.
REM TO DO: about.txt
TYPE "%winLoc%\data\assets\ui\about.txt"
ECHO.
ECHO.
ECHO Delve into the powerful, mysterious Iridescent Forest of the Kindgom of Fulkwinn and it's equally powerful castle,
ECHO Windhelm! Discover shards of your past and rebuild your identity, or forge a new one. Your destiny is yours to control
ECHO alone. Take on the threats of the Iridescent Forest, defending it from those that wish it harm.
ECHO Use soul memories to unlock special abilites and form strong bonds to other shards.
ECHO ========================================================================================================================
ECHO                   [E / RETURN ]
ECHO.
CHOICE /C E /N /M ">"
IF ERRORLEVEL 1 GOTO :START

REM Launch the settings menu.
:settings
TITLE (Windhelm - %windhelm.tu%) ^| Settings Menu.
MODE con: cols=100 lines=19
CLS
ECHO.
TYPE "%cd%\data\assets\ui\settings.txt"
ECHO.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / CHANGE THEME ] ^| [E / EXIT ]                                                                +
ECHO +--------------------------------------------------------------------------------------------------+
CHOICE /C 1E /N /M ">"
IF ERRORLEVEL 2 GOTO :save_choice
IF ERRORLEVEL 1 GOTO :theme_select

REM CHANGE BACKGROUND & TEXT COLOR.
:theme_select
MODE con: cols=105 lines=19
CLS
ECHO.
TYPE "%cd%\data\assets\ui\settings.txt"
ECHO.
ECHO %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / 0E DEFAULT ] ^| [2 / 1F HIGH VIS ] [3 / 09 ] ^| [4 / 0A ] ^| [5 / 0F ] ^| [C / CUSTOM ]              +
ECHO ^| [E / EXIT ]                                                                                           +
ECHO +-------------------------------------------------------------------------------------------------------+
CHOICE /C 12345CE /N /M ">"
IF ERRORLEVEl 7 GOTO :settings
IF ERRORLEVEL 6 GOTO :custom_color
IF ERRORLEVEL 5 GOTO :0F
IF ERRORLEVEL 4 GOTO :0A
IF ERRORLEVEL 3 GOTO :09
IF ERRORLEVEL 2 GOTO :1F
IF ERRORLEVEL 1 GOTO :0E

:custom_color
CLS
ECHO.
TYPE "%cd%\data\assets\ui\color.txt"
ECHO.
ECHO ENTER A VALID BATCH SCRIPT COLOR CODE. (SEE COLOR /?)
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]                                                                                       +
ECHO +--------------------------------------------------------------------------------------------------+
SET /P custom=^>
COLOR %custom%
SET setColor=%custom%
SET displayMessage=%custom% applied - exit this script to save.
IF /I "%custom%" == "E" GOTO :save_choice
GOTO :theme_select

:0E
set setColor=0E
color 0E
set displayMessage=Color 0E applied; exit to save this choice.
GOTO :theme_select

:0F
set setColor=0F
color 0F
set displayMessage=Color 0F applied; exit to save this choice.
GOTO :theme_select

:09
set setColor=09
color 09
set displayMessage=Color 09 applied; exit to save this choice.
GOTO :theme_select

:0A
set setColor=0A
color 0A
set displayMessage=Color 0A applied; exit to save this choice.
GOTO :theme_select

:1F
set setColor=1F
COLOR 1F
set displayMessage=Color 1F applied; exit to save this choice.
GOTO :theme_select

:save_choice
(
ECHO %setColor%
)>"%winLoc%\data\settings.txt"
GOTO :START
REM CALL "%winLoc%\data\functions\Settings.bat"
REM GOTO :START

REM Launch player creator - creates stats and inventory.
:NEW_GAME
CALL "%winLoc%\data\functions\ciac.bat"
IF %OSQ% EQU 1 (
    GOTO :START
) ELSE (
    GOTO :dashboard
)

REM Check if a save exists, and if it does, load it. Otherwise, prompt the Player to create a new save.
:LOAD_SAVE
SET SLOPr=LOAD
IF NOT EXIST "%winLoc%\data\player\savedata.txt" (
    ECHO Player data not found - please make a new save.
    PAUSE
    GOTO :START
) ELSE (
    REM If the above check passes, call SLOP to load data.
    CALL "%winLoc%\data\functions\SLOP.bat"
    GOTO :dashboard
)

:dashboard
TITLE (Windhelm - %windhelm.tu%) Castle Gate ^| %player.name% the %player.class%
MODE con: cols=101 lines=21
IF %player.xp% LSS 0 SET player.xp=0
IF %player.health% LSS 0 set player.health=0
CLS
REM Write the data from the text file to the CLI.
ECHO.
TYPE "%winLoc%\data\assets\ui\Windhelm.txt"
ECHO.
ECHO %displayMessage%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +---------------------------------------------------------------------------------------------------+
ECHO ^| [1 / EXPLORE ] ^| [2 / INVENTORY ] ^| [C / VIEW CHARACTER ] ^| [S / SAVE ] ^| [Q / EXIT ]
ECHO +---------------------------------------------------------------------------------------------------+
CHOICE /C 12CSQ /N /M ">"
IF ERRORLEVEL 5 GOTO :Exit_Without_Saving
IF ERRORLEVEL 4 GOTO :Save_Game
IF ERRORLEVEL 3 GOTO :character_view
IF ERRORLEVEL 2 GOTO :view_inventory
IF ERRORLEVEL 1 GOTO :EXPLORATION_HUB

REM "Exit without saving" screen.
:Exit_Without_Saving
ECHO Exit now? All unsaved progress will be lost.
CHOICE /C YN
IF ERRORLEVEL 2 GOTO :dashboard
IF ERRORLEVEL 1 GOTO :START

REM Call SLOP with a "SLOPr" of "SAVE".
:Save_Game
SET SLOPr=SAVE
CALL "%winLoc%\data\functions\SLOP.bat"
SET displayMessage=Your game was saved.
GOTO :dashboard

REM Call the Inventory Viewer script.
:view_inventory
CALL "%winLoc%\data\functions\Inventory Viewer.bat"
GOTO :dashboard

REM Displays a status page for the Player's character.
:character_view
MODE con: cols=105 lines=21
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\character.txt"
ECHO.
ECHO %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO ^| NAME: %player.name% ^| RACE: %player.race% ^| CLASS: %player.class% ^| PRONOUNS: %player.personal_p_1%/%player.personal_p_2%/%player.possesive_1%/%player.reflexive_1%
ECHO ^| GOBLINS SLAIN: %player.goblins.slain% ^|
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / LEVEL UP ] ^| [2 / CHANGE NAME ] ^| [3 / CHANGE PRONOUNS ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------+
CHOICE /C 123Q /N /M ">"
IF ERRORLEVEL 4 GOTO :dashboard
IF ERRORLEVEL 3 GOTO :PLAYER_CHANGE_PRONOUNS
IF ERRORLEVEL 2 GOTO :PLAYER_CHANGE_NAME
IF ERRORLEVEL 1 GOTO :PLAYER_LEVEL_UP

REM Call leveler.bat to perform level up logic.
:PLAYER_LEVEL_UP
CALL "%winLoc%\data\functions\leveler.bat"
GOTO :character_view

REM Allow the Player to change their name.
:PLAYER_CHANGE_NAME
SET player.name_old=%player.name%
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\name.txt"
ECHO.
ECHO Enter a new name.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| TYPE CANCEL TO CANCEL.
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P player.name=
IF /I "%player.name%" == "CANCEL" GOTO :PLAYER_NAME_CANCEL
GOTO :AUTOSAVE

:PLAYER_NAME_CANCEL
SET player.name=%player.name_old%
GOTO :character_view

REM Allow the Player to change their pronouns.
:PLAYER_CHANGE_PRONOUNS
SET player.pronouns_change_req=1
CALL "%winLoc%\data\functions\ciac.bat"
GOTO :AUTOSAVE

REM Main exploration tab.
:EXPLORATION_HUB
TITLE (WINDHELM) Exploration Engine ^| %player.name% the %player.class%
MODE con: cols=105 lines=19
CLS
ECHO.
TYPE "%cd%\data\assets\ui\exp.txt"
ECHO.
ECHO %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / IRIDESCENT FOREST ] ^| [2 / RUINS ] ^| [3 / ROCKWINN PLAZA ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------+
CHOICE /C 123Q /N /M ">"
IF ERRORLEVEL 4 GOTO :AUTOSAVE
IF ERRORLEVEL 3 GOTO :ROCKWINN_PLAZA
IF ERRORLEVEL 2 GOTO :CHECK_RUINS_UNLOCKED
IF ERRORLEVEL 1 GOTO :ROLL_ENEMY

:ROLL_ENEMY
SET currentEnemy=iBandit
CALL "%cd%\data\Combat Engine\scripts\evie.bat"
GOTO :EXPLORATION_HUB

:DISABLED_TEMP
SET /A A=%RANDOM% %%100
IF %A% GEQ 80 (
    SET currentEnemy=iHunter
    CALL "%cd%\data\Combat Engine\scripts\evie.bat"
    GOTO :EXPLORATION_HUB
) ELSE IF %A% GEQ 60 (
    SET currentEnemy=iJester
    CALL "%cd%\data\Combat Engine\scripts\evie.bat"
    GOTO :EXPLORATION_HUB
) ELSE IF %A% GEQ 55 (
    SET currentEnemy=iGnome
    CALL "%cd%\data\Combat Engine\scripts\evie.bat"
    GOTO :EXPLORATION_HUB
) ELSE (
    SET currentEnemy=iGoblin
    CALL "%cd%\data\Combat Engine\scripts\evie.bat"
    GOTO :EXPLORATION_HUB
)

REM Unfinished, do NOT allow the Player to access this menu.
:CHECK_RUINS_UNLOCKED
GOTO :EXPLORATION_HUB

REM Enters the Rockwinn Plaza.
:ROCKWINN_PLAZA
CALL "%cd%\data\functions\Rockwinn Plaza.bat"
GOTO :EXPLORATION_HUB

REM Saves the game before returning to WINDHELM.
:AUTOSAVE
SET SLOPr=SAVE
SET displayMessage=Game saved.
CALL "%cd%\data\functions\SLOP.bat"
GOTO :dashboard