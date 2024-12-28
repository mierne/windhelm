@ECHO OFF
TITLE (WINDHELM) - EXPLORATION ENGINE ^| %player.name% the %player.class%!
REM Exploration Engine Pre-Alpha wee-0.1.0-241223-PA1-GU0

:MAIN
MODE con: cols=105 lines=19
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\exploration.txt"
ECHO.
ECHO Where is it you wish to go, %player.name%?
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / IRIDESCENT FOREST ] ^| [2 / WINDHELM EXTERIOR ] ^| [3 / ROCKWINN PLAZA ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------+
CHOICE /C 123Q /N /M ">"
IF ERRORLEVEL 4 GOTO :AUTOSAVE
IF ERRORLEVEL 3 GOTO :VENTURE_ROCKWINN_PLAZA
IF ERRORLEVEL 2 GOTO :VENTURE_WINDHELM_EXTERIOR
IF ERRORLEVEL 1 GOTO :VENTURE_IRIDESCENT_FOREST

:VENTURE_IRIDESCENT_FOREST
MODE con: cols=105 lines=19
CLS
ECHO.
REM TYPE "%winLoc%\PATH\TO\ASCII\ART"
ECHO.
ECHO What is it you wish to do, %player.name%?
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / ADVENTURE ] ^| [2 / AREA BOSS ] ^| [Q / BACK ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
CHOICE /C 12Q /N /M ">"
IF ERRORLEVEL 3 GOTO :MAIN
IF ERRORLEVEl 2 GOTO :IFOR_CHALLENGE_AREA_BOSS
IF ERRORLEVEL 1 GOTO :IFOR_ADVENTURE

:IFOR_ADVENTURE
SET /A EE=%RANDOM% %%50
IF %EE% LEQ 50 (
    SET currentEnemy=Bandit
    CALL "%winLoc%\data\Combat Engine\scripts\evie.bat"
) ELSE (
    REM In the future, random items may be discovered.
    SET displayMessage=You didn't find anything of interest.
    GOTO :VENTURE_IRIDESCENT_FOREST
)
:IFOR_CHALLENGE_AREA_BOSS
IF %player.level% GEQ 20 (
    SET currentEnemy="Abyssal Guardian"
    CALL "%winLoc%\data\Combat Engine\scripts\evie.bat"
) ELSE (
    SET displayMessage=Your level is too low for this encounter.
    GOTO :VENTURE_IRIDESCENT_FOREST
)

:VENTURE_WINDHELM_EXTERIOR
MODE con: cols=105 lines=19
CLS
ECHO.
REM TYPE "%winLoc%\PATH\TO\ASCII\ART"
ECHO.
ECHO What is it you wish to do, %player.name%?
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / WANDER ] ^| [2 / TRAVELING MERCHANT ] ^| [Q / BACK ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
CHOICE /C 12Q /N /M ">"
IF ERRORLEVEL 3 GOTO :MAIN
IF ERRORLEVEl 2 GOTO :WE_TRAVELING_MERCHANT
IF ERRORLEVEL 1 GOTO :WE_WANDER

:WE_WANDER
SET /A  WE=%RANDOM% %%50
IF %WE% LEQ 15 (
    REM ENCOUNTER PLACEHOLDER NPC (QUESTGIVER)
    GOTO :WE_WANDER_ENCOUNTER_1
) ELSE (
    SET displayMessage=You didn't find anything of interest.
    GOTO :VENTURE_WINDHELM_EXTERIOR
)

:WE_WANDER_ENCOUNTER_1
MODE con: cols=105 lines=19
CLS
ECHO.
REM TYPE "%winLoc%\PATH\TO\ASCII\ART"
ECHO.
ECHO You see someone with what appears to be a polearm closely following another.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / APPROACH ] ^| [Q / BACK ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
CHOICE /C 1Q /N /M ">"
IF ERRORLEVEL 3 GOTO :MAIN
IF ERRORLEVEL 1 GOTO :WEWE1_APPROACH_INTERACTION

:WEWE1_APPROACH_INTERACTION
SET displayMessage=NOT IMPLEMENTED.
GOTO :MAIN

REM Save Player progress before quitting Exploration Engine.
:AUTOSAVE
SET SLOPr=save
CALL "%winLoc%\data\functions\SLOP.bat"
GOTO :EOF