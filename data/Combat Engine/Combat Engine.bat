MODE con: cols=120 lines=28
REM wce-250118.PA8.GU0 - for "Abyssal"

:EBS
MODE con: cols=120 lines=28
IF %enemy.health% LEQ 0 GOTO :VICTORY_STATS_TRACK
IF %player.health% LEQ 0 GOTO :DEFEAT_SCREEN
TITLE (WINDHELM) - COMBAT ENGINE ^| %player.name% the %player.class% vs %curEn% & SET enAT=%enATb%
CLS
ECHO.
TYPE "%winLoc%\data\assets\enemies\Iridescent Forest\%currentEnemy%.txt"
ECHO.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| %currentEnemy% HP: %enemy.health% ^| ATK %enemy.damage%
ECHO ^| %displayMessage% ^| %player.message%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [A / ATTACK ] ^| [I / ITEMS ] ^| [R / RECOVER ] ^| [Q / FLEE ]
ECHO +-------------------------------------------------------------------------------------------------------+
CHOICE /C AIRQ /N /M ">"
IF ERRORLEVEL 4 GOTO :PLAYER_FLEE
IF ERRORLEVEL 3 GOTO :PLAYER_RECOVER
IF ERRORLEVEL 2 GOTO :PLAYER_ITEMS
IF ERRORLEVEL 1 GOTO :PLAYER_ATTACK_SC

:PLAYER_ATTACK_SC
IF %player.stamina% LSS %player.attack_stamina% (
    SET player.message=Not enough stamina^!
    GOTO :EBS
) ELSE (
    GOTO :PLAYER_ATTACK
)

:PLAYER_ATTACK
SET /A PA=%RANDOM% %%50
IF %PA% LEQ 15 (
    SET player.message=Critical hit^!
    SET /A enemy.health=!enemy.health! -%player.damage%*2
    GOTO  :PLAYER_ARMOR_CALCULATION
) ELSE IF %PA% GEQ 35 (
    SET player.message=Critical hit^!
    SET /A enemy.health=!enemy.health! -%player.damage*2
    GOTO :PLAYER_ARMOR_CALCULATION
) ELSE IF %PA% GEQ 20 (
    SET player.message=Normal attack placeholder
    SET /A enemy.health=!enemy.health! -%player.damage%
) ELSE (
    SET player.message=You missed^!
    GOTO :PLAYER_ARMOR_CALCULATION
)

:PLAYER_ARMOR_CALCULATION
SET enemy.damage=%enemy.damage_base%
IF %player.armor_prot% LEQ 0 ( 
    GOTO :CHECK_ACTIVE_BOSS
) ELSE (
    SET /A enemy.damage=!enemy.damage! -%player.armor_prot%
    GOTO :CHECK_ACTIVE_BOSS
)

:CHECK_ACTIVE_BOSS
IF %ce.boss_active% EQU 1 (
    GOTO :EAC_BOSS
) ELSE (
    GOTO :ENEMY_ATTACK_CALCULATION
)

:ENEMY_ATTACK_CALCULATION
pause
SET /A EA=%RANDOM% %%50
pause
pause
IF %EA% GTR 30 (
    ECHO GTR 30
    PAUSE
) ELSE IF %EA% GTR 20 (
    ECHO GTR 20
    PAUSE
) ELSE IF %EA% GTR 12 (
    ECHO GTR 12
    PAUSE
) ELSE (
    ECHO miss
    PAUSE
)


@REM SET /A EAC=!RANDOM! %%40
@REM IF %EAC% GTR 30 (
@REM     SET displayMessage=The enemy got a critical hit^!
@REM     SET /A player.health=!player.health! -%enemy.damage%*2
@REM     GOTO :EBS
@REM ) ELSE IF %EAC% GTR 20 (
@REM     SET displayMessage=You were unable to dodge the %curEn%'s swift attack^!
@REM     SET /A player.health=!player.health! -%enemy.damage%
@REM     GOTO :EBS
@REM ) ELSE IF %EAC% GTR 12 (
@REM     SET displayMessage=The enemy lands a glancing blow, a weak hit^!
@REM     SET /A player.health=!player.health! -%enemy.damage%
@REM     SET /A player.health=!player.health! +8
@REM     GOTO :EBS
@REM ) ELSE (
@REM     SET displayMessage=placeholder
@REM     GOTO :EBS
@REM )


:EAC_BOSS
REM BOSS FIGHT MECHANICS

:PLAYER_INVENTORY
REM REDESIGN PLAYER INVENTORY ACCESS

:ERROR_HANDLER
CALL "%cd%\data\functions\Error Handler.bat"
CLS
ECHO.
ECHO An error has occured in Combat Engine. It is not recommended that you continue.
ECHO Save your game and exit?
CHOICE /C YN /N /M "Y/N"
IF ERRORLEVEL 2 GOTO :EH_WARN
IF ERRORLEVEL 1 GOTO :EH_CS

:EH_WARN
ECHO You have been warned.
PAUSE
GOTO :EBS

:EH_CS
SET SLOPr=SAVE
CALL "%winLoc%\data\functions\SLOP.bat"
EXIT

:VICTORY_STATS_TRACK
IF %currentEnemy% == "Bandit" (
    SET /A player.bandits_slain=!player.bandits_slain! +1
    GOTO :VICTORY_REWARDS
) ELSE (
    GOTO :VICTORY_REWARDS
)

:VICTORY_REWARDS
REM REWORK VICTORY REWARDS

:VICTORY_SCREEN
REM REDESIGN VICTORY SCREEN

:LOOT
REM REWORK ceLOOT

:DEFEAT_SCREEN
SET /A player.total_deaths=!player.total_deaths! +1
REM REDESIGN DEFEAT SCREEN

:EXIT
SET player.armor_calculated=1
SET enemy.attack=%enemy.attack_normal%
GOTO :EOF