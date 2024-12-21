MODE con: cols=120 lines=28
REM Combat Engine Pre-Alpha Version 0.8.0
REM Extra Build Information: wce-241221.PA8.GU0 - "Abyssal"

:EBS
MODE con: cols=120 lines=28
TITLE (WINDHELM) - COMBAT ENGINE ^| %player.name% the %player.class% vs %curEn% & SET enAT=%enATb%
CLS
IF %enemy.health% LEQ 0 GOTO :VICTORY_REWARDS
IF %player.health% LEQ 0 GOTO :DEFEAT_SCREEN
ECHO.
TYPE "%cd%\data\assets\enemies\Iridescent Forest\%curEn%.txt"
ECHO.
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^|                                               HP: %enemy.health% ^| ATK: %enemy.damage%
ECHO ^| %displayMessage%
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| STM: %player.stamina% ^| ATK: %player.damage% ^| AMR: %player.armor_equip% ^| MGK: %player.magicka%
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [I] ITEMS  ^| [E] END     ^| %player.message%
ECHO ^|            ^| [R] RECOVER ^|
ECHO ^| [A] ATTACK ^|             ^| [F] FLEE
ECHO +----------------------------------------------------------------------------------------------------------------------+
CHOICE /C IAERF /N /M ">"
IF ERRORLEVEL 5 GOTO :PLAYER_ATTEMPTS_FLEE
IF ERRORLEVEL 4 GOTO :PLAYER_RECOVERY
IF ERRORLEVEL 3 GOTO :PLAYER_ENDED_TURN
IF ERRORLEVEL 2 GOTO :PLAYER_ATTACK_CALCULATIONS
IF ERRORLEVEL 1 GOTO :PLAYER_INVENTORY

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
ECHO disabled
PAUSE
GOTO :EBS

:ERROR_HANDLER
CALL "%cd%\data\functions\Error Handler.bat"
EXIT

:VICTORY_REWARDS
CALL "%cd%\data\functions\leveler.bat"
SET player.health=%player.health_max%
SET player.stamina=%player.stamina_max%
SET player.magicka=%player.magicka_max%
SET /A RR=%RANDOM% %%20
IF %RR% GEQ 15 (
    SET goldGained=60
    SET xpGained=25
    GOTO :VICTORY_SCREEN
) ELSE IF %RR% LEQ 8 (
    SET goldGained=20
    SET xpGained=10
    GOTO :VICTORY_SCREEN
) ELSE (
    SET goldGained=10
    SET xpGained=5
    GOTO :VICTORY_SCREEN
)

:VICTORY_SCREEN
SET /A player.coins=!player.coins! +%goldGained%
SET /A player.xp=!player.xp! +%xpGained%
TITLE (WINDHELM) - COMBAT ENGINE ^| %player.name% the %player.class% is victorious!
CLS
ECHO.
TYPE "%cd%\data\assets\ui\victory.txt"
ECHO.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| %lootFound% ^| %player.levelup_notif%
ECHO ^| You defeated the %curEn%, congratulations^! You've been rewarded with %goldGained% Gold and %xpGained% xp.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| STM: %player.stamina% ^| ATK: %player.damage% ^| AMR: %player.armor% ^| MGK: %player.magicka%
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| ACTION 1: %q_action_1% ^| ACTION 2: %q_action_2% ^| ACTION 3: %q_action_3%
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / LOOT %curEn% ] ^| [E / EXIT ]  ^| %player.message%                                                      +
ECHO +----------------------------------------------------------------------------------------------------------------------+
CHOICE /C 1E /N /M ">"
IF ERRORLEVEL 2 GOTO :EXIT
IF ERRORLEVEL 1 GOTO :LOOT

:LOOT
CALL "%cd%\data\Combat Engine\scripts\ceLoot.bat"
SET enLooted=1
GOTO :VICTORY_SCREEN

:DEFEAT_SCREEN
SET /A player.xp=!player.xp! +10
SET player.health=%player.health_max%
TITLE (WINDHELM) - COMBAT ENGINE ^| %player.name% the %player.class% is victorious!
CLS
ECHO.
TYPE "%cd%\data\assets\ui\defeat.txt"
ECHO.
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| %lootFound%
ECHO ^| You were defeated ny the %curEn%! You've been rewarded with 10 xp.
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health% ^| STM: %player.stamina% ^| ATK: %player.damage% ^| AMR: %player.armor% ^| MGK: %player.magicka%
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| ACTION 1: %q_action_1% ^| ACTION 2: %q_action_2% ^| ACTION 3: %q_action_3%
ECHO +---------------------------------------------------------------------------------------------------------------------+
ECHO ^| [E / EXIT ]  ^| %player.message%                                                                            +
ECHO +---------------------------------------------------------------------------------------------------------------------+
CHOICE /C E /N /M ">"
IF ERRORLEVEL 1 GOTO :EXIT

:EXIT
SET player.armor_calculated=1
SET enemy.attack=%enemy.attack_normal%
GOTO :EOF