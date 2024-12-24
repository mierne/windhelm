MODE con: cols=120 lines=28
REM Combat Engine Pre-Alpha Version 0.8.0
REM Extra Build Information: wce-241223.PA8.GU0 - "Abyssal"

:EBS
MODE con: cols=120 lines=28
IF %enemy.health% LEQ 0 GOTO :VICTORY_STATS_TRACK
IF %player.health% LEQ 0 GOTO :DEFEAT_SCREEN
TITLE (WINDHELM) - COMBAT ENGINE ^| %player.name% the %player.class% vs %curEn% & SET enAT=%enATb%
CLS
ECHO.
ECHO "%winLoc%\data\assets\enemies\Iridescent Forest\%currentEnemy%.txt"
ECHO.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| %currentEnemy% HP: %enemy.health% ^| ATK %enemy.damage%
ECHO ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [A / ATTACK ] ^| [H / HEAVY ATTACK ] ^| [I / ITEMS ] ^| [R / RECOVER ] ^| [Q / FLEE ]
ECHO +-------------------------------------------------------------------------------------------------------+
CHOICE /C AHIRQ /N /M ">"
IF ERRORLEVEL 5 GOTO :PLAYER_FLEE
IF ERRORLEVEL 4 GOTO :PLAYER_RECOVER
IF ERRORLEVEL 3 GOTO :PLAYER_ITEMS
IF ERRORLEVEL 2 GOTO :PLAYER_HEAVY_ATTACK
IF ERRORLEVEL 1 GOTO :PLAYER_NORMAL_ATTACK

:PLAYER_ATTACK_CALCULATIONS
IF %player.stamina% LSS %player.stamina_equip% (
    SET player.message=You do not have enough stamina to attack.
    GOTO :EBS
) ELSE (
    GOTO :PLAYER_DAMAGE_CALCULATIONS
)

:PLAYER_DAMAGE_CALCULATIONS
SET /A PDC=%RANDOM% %%40
IF %PDC% GTR 32 (
    SET player.message=You got a critical hit^!
    SET /A enemy.health=!enemy.health! -%player.damage%*2
    GOTO :PLAYER_ARMOR_CALCULATIONS
) ELSE IF %PDC% GTR 10 (
    SET player.message=You lunge at the %curEn%^! Striking them with your weapon.
    SET /A enemy.health=!enemy.health! -%player.damage%
    SET /A player.damage_dealt=%player.damage%
    GOTO :PLAYER_ARMOR_CALCULATIONS
) ELSE (
    SET player.message=The %curEn% leaps out of the way just in time^!
    GOTO :PLAYER_ARMOR_CALCULATIONS
)

:PLAYER_ARMOR_CALCULATIONS
SET enemy.damage=%enemy.damage_base%
IF %player.armor_equip% LEQ 0 (
    GOTO :ENEMY_ATTACK_CALCULATIONS
) ELSE (
    SET /A enemy.damage=!enemy.damage! -%player.armor_equip%
    GOTO :ENEMY_ATTACK_CALCULATIONS
)

:ENEMY_ATTACK_CALCULATIONS
SET /A EAC=%RANDOM% %%40
IF %EAC% GTR 30 (
    SET displayMessage=The enemy got a critical hit^!
    SET /A player.health=!player.health! -%enemy.damage%*2
    GOTO :EBS
) ELSE IF %EAC% GTR 20 (
    SET displayMessage=You were unable to dodge the %curEn%'s swift attack^!
    SET /A player.health=!player.health! -%enemy.damage%
    GOTO :EBS
) ELSE IF %EAC% GTR 12 (
    SET displayMessage=The enemy lands a glancing blow, a weak hit^!
    SET /A player.health=!player.health! -%enemy.damage%
    SET /A player.health=!player.health! +8
    GOTO :EBS
) ELSE (
    SET displayMessage=You see the attack coming from miles away and move out of the way before it connects.
    GOTO :EBS
)

:PLAYER_INVENTORY
REM REDESIGN PLAYER INVENTORY ACCESS

:ERROR_HANDLER
CALL "%cd%\data\functions\Error Handler.bat"
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