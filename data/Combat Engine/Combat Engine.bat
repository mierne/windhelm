REM temp fix for empty variables (what's causing this?)
SET /A CR=%RANDOM% * 17 / 32768 + 8

:EBS
MODE con: cols=120 lines=20
IF %enemy.health% LEQ 0 GOTO :VICTORY_STATS_TRACK
IF %player.health% LEQ 0 GOTO :DEFEAT_SCREEN
SET player.damage=%player.damage_base%
TITLE (WINDHELM) - COMBAT ENGINE ^| %player.name% the %player.race% %player.class% vs %curEn% & SET enAT=%enATb%
CLS
ECHO.
TYPE "%winLoc%\data\assets\enemies\Iridescent Forest\%currentEnemy%.txt"
ECHO.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| %currentEnemy% HP: %enemy.health% ^| ATK: %enemy.damage% ^| STM: %enemy.stamina%
ECHO ^| %displayMessage%
ECHO ^| %player.message%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina%/%player.stamina_max% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [A / ATTACK ] ^| [I / ITEMS ] ^| [R / RECOVER ] ^| [Q / FLEE ]
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :PLAYER_ATTACK_SC
IF /I "%CH%" == "2" GOTO :PLAYER_ITEMS
IF /I "%CH%" == "3" GOTO :PLAYER_RECOVER
IF /I "%CH%" == "Q" GOTO :PLAYER_FLEE

:PLAYER_ATTACK_SC
IF %player.stamina% LSS %player.attack_stamina_usage% (
    SET player.message=You try to swing but find your weak noodles too exhausted.
    GOTO :EBS
) ELSE (
    REM Try to account for enemy damage resistance
    SET player.damage=%player.damage_base%
    IF "%enemy.damage_type_resistance%" == "%player.weapon_damage_type%" (
        SET /A player.damage=!player.damage! -%enemy.damage_resisted%
        REM Add another display message variable? player.message and displayMessage will be overwritten if done here.
        GOTO :PLAYER_ATTACK
    ) ELSE (
        REM No other attack type currently working.
        GOTO :PLAYER_ATTACK
    )
)

:PLAYER_RECOVER
SET /A RSR=%RANDOM% %%30
IF %player.stamina% EQU %player.stamina_max% (
    SET player.message=You do not need to rest.
    GOTO :EBS
) ELSE (
    IF %RSR% GEQ 29 (
        REM Full recovery
        SET player.stamina=100
        SET displayMessage=You rest for a moment, recovering your stamina
        GOTO :OVERFLOW_CHECK
    ) ELSE IF %RSR% GEQ 19 (
        SET /A player.stamina=!player.stamina! +30
        SET displayMessage=You rest for a moment, recovering some stamina
        GOTO :OVERFLOW_CHECK
    ) ELSE IF %RSR% GEQ 9 (
        SET /A player.stamina=!player.stamina! +20
        SET displayMessage=You rest for a moment, recovering some stamina
        GOTO :OVERFLOW_CHECK
    ) ELSE (
        SET /A player.stamina=!player.stamina! +10
        SET displayMessage=You rest for a moment, recovering some stamina
        GOTO :OVERFLOW_CHECK
    )
)

:OVERFLOW_CHECK
IF %player.stamina% GTR %player.stamina_max% (
    SET player.stamina=%player.stamina_max%
    GOTO :PLAYER_ARMOR_CALCULATION
) ELSE (
    GOTO :PLAYER_ARMOR_CALCULATION
)

:PLAYER_ATTACK
SET /A PA=%RANDOM% %%70
IF %PA% LEQ 25 (
    SET player.message=Critical hit^!
    SET /A enemy.health=!enemy.health! -%player.damage%*2
    SET /A player.stamina=!player.stamina! -%player.attack_stamina_usage%
    GOTO  :PLAYER_ARMOR_CALCULATION
) ELSE IF %PA% GEQ 50 (
    REM Athletics check! If Player athletics is below a certain level, they will miss this attack. A proper way to scale in the future will be nice.
    IF %player.skill_athletics% LSS 10 (
        SET player.message=You left your laces united. You fall flat on your face, missing entirely.
        GOTO :PLAYER_ARMOR_CALCULATION
    ) ELSE (
        REM Just perform a normal attack.
        SET player.message=You nearly trip in the process, but you manage to hit a solid blow
        SET /A enemy.health=!enemy.health! -%player.damage%
        GOTO :PLAYER_ARMOR_CALCULATION
    )
) ELSE IF %PA% GEQ 25 (
    SET player.message=You manage a decent hit on the %currentEnemy%
    SET /A enemy.health=!enemy.health! -%player.damage%
    SET /A player.stamina=!player.stamina! -%player.attack_stamina_usage%
    GOTO :PLAYER_ARMOR_CALCULATION
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
    GOTO :ENEMY_SC
)

:ENEMY_SC
IF %enemy.stamina% LSS 10 (
    GOTO :ENEMY_STAMINA_RECOVERY
) ELSE (
    GOTO :ENEMY_ATTACK_CALCULATION
)

:ENEMY_ATTACK_CALCULATION
SET /A EA=%RANDOM% %%50
IF %EA% GEQ 45 (
    SET displayMessage=The %currentEnemy% scored a critical hit
    SET /A player.health=!player.health! -%enemy.damage%*2
    SET /A enemy.stamina=!enemy.stamina! -13
    GOTO :EBS
) ELSE IF %EA% GEQ 15 (
    SET displayMessage=The %currentEnemy% scored a hit
    SET /A player.health=!player.health! -%enemy.damage%
    SET /A enemy.stamina=!enemy.stamina! -13
    GOTO :EBS
) ELSE (
    SET displayMessage=The %currentEnemy% attempted a far too obvious attack and missed.
    GOTO :EBS
)

:ENEMY_STAMINA_RECOVERY
SET /A RSR=%RANDOM% %%30
IF %RSR% GEQ 29 (
    REM Full recovery
    SET enemy.stamina=100
    SET displayMessage=The %currentEnemy% rests for a brief moment, recovering their stamina
    GOTO :EBS
) ELSE IF %RSR% GEQ 19 (
    SET /A enemy.stamina=!enemy.stamina! +30
    SET displayMessage=The %currentEnemy% rests for a brief moment, recovering some stamina
    GOTO :EBS
) ELSE IF %RSR% GEQ 9 (
    SET /A enemy.stamina=!enemy.stamina! +20
    SET displayMessage=The %currentEnemy% rests for a brief moment, recovering some stamina
    GOTO :EBS
) ELSE (
    SET /A enemy.stamina=!enemy.stamina! +10
    SET displayMessage=The %currentEnemy% rests for a brief moment, recovering some stamina
    GOTO :EBS
)

REM What is this doing here?
SET /A enemy.stamina=!enemy.stamina! +35

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
IF "%currentEnemy%" == "Bandit" (
    SET /A player.bandits_slain=!player.bandits_slain! +1
    GOTO :VICTORY_REWARDS
) ELSE IF "%currentEnemy%" == "Abyssal Guardian" (
    SET /A player.iridescent_ab_defeated=1
    GOTO :VICTORY_REWARDS
) ELSE (
    REM Enemy doesn't exist? How'd you get here?
    GOTO :ERROR_HANDLER
)

:VICTORY_REWARDS
SET player.health=%player.health_max%
SET player.stamina=%player.stamina_max%
SET player.magicka=%player.magicka_max%
SET /A XPE=%RANDOM% %%80
IF %XPE% LEQ 30 (
    SET /A player.xp=!player.xp! +30
    SET displayMessage=Earned 30 XP
    GOTO :VICTORY_REWARDS_LUNIS
) ELSE IF %XPE% LEQ 60 (
    SET /A player.xp=!player.xp! +70
    SET displayMessage=Earned 70 XP
    GOTO :VICTORY_REWARDS_LUNIS
) ELSE (
    SET /A player.xp=!player.xp! +100
    SET displayMessage=Earned 100 XP
    GOTO :VICTORY_REWARDS_LUNIS
)

:VICTORY_REWARDS_LUNIS
IF %player.level% LSS 10 (
    SET /A player.coins=!player.coins! +5
    SET player.message=You earned 5 LUNIS
    GOTO :VICTORY_SCREEN
) ELSE IF %player.level% LSS 20 (
    SET /A player.coins=!player.coins! +10
    SET player.message=You earned 10 LUNIS
    GOTO :VICTORY_SCREEN
) ELSE IF %player.level% LSS 30 (
    SET /A player.coins=!player.coins! +20
    SET player.message=You earned 20 LUNIS
    GOTO :VICTORY_SCREEN
) ELSE IF %player.level% LSS 40 (
    SET /A player.coins=!player.coins! +30
    SET player.message=You earned 40 LUNIS
    GOTO :VICTORY_SCREEN
) ELSE (
    SET /A player.coins=!player.coins! +50
    SET player.message=You earned 50 LUNIS
    GOTO :VICTORY_SCREEN
)

:VICTORY_SCREEN
MODE con: cols=105 lines=18
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\victory.txt"
ECHO.
ECHO The %currentEnemy% was defeated. Your health, stamina and magicka has been refilled!
ECHO %player.message% ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina%/%player.stamina_max% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO [1 / LOOT ] ^| [Q LEAVE ]
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :LOOT
IF /I "%CH%" == "Q" GOTO :EXIT

:LOOT
IF %enLooted% EQU 1 (
    SET player.message=This enemy was looted already.
    GOTO :VICTORY_SCREEN
) ELSE (
    GOTO :VICTORY_LOOT
)

:VICTORY_LOOT
IF %player.level% LEQ 10 (
    GOTO :PLAYER_LEVEL_10_LOWER
) ELSE (
    echo NOT IMPLEMENTED
    GOTO :VICTORY_SCREEN
)

:PLAYER_LEVEL_10_LOWER
SET /A LT=%RANDOM% %%40
IF %LT% LEQ 10 (
    SET enLooted=1
    SET /A CR=%RANDOM% * 17 / 32768 + 8
    SET /A player.coins=!player.coins! +%CR%
    SET player.message=You found %CR% LUNIS
    GOTO :VICTORY_SCREEN
) ELSE IF %LT% LEQ 20 (
    SET enLooted=1
    SET /A CR=%RANDOM% * 32 / 32768 + 12
    SET /A player.coins=!player.coins! +%CR%
    SET player.message=You found %CR% LUNIS
    GOTO :VICTORY_SCREEN
) ELSE IF %LT% LEQ 30 (
    SET enLooted=1
    SET /A player.item_long_sword_owned=!player.item_long_sword_owned! +1
    SET player.message=You found a Long Sword.
    GOTO :VICTORY_SCREEN
) ELSE IF %LT% LEQ 40 (
    SET enLooted=1
    SET /A CR=%RANDOM% * 48 / 32768 + 21
    SET /A player.coins=!player.coins! +%CR%
    SET /A player.item_cactus_armor_owned=!player.item_cactus_armor_owned! +1
    SET player.message=You found %CR% LUNIS and 1 CACTUS ARMOR
    GOTO :VICTORY_SCREEN
)

:DEFEAT_SCREEN
SET /A player.total_deaths=!player.total_deaths! +1
SET /A player.health=!player.health! +25
SET /A player.stamina=!player.stamina! +25
SET /A player.magicka=!player.magicka! +25
SET player.message=...
SET displayMessage=...
MODE con: cols=105 lines=18
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\defeat.txt"
ECHO.
ECHO You were defeated by the %currentEnemy%. Your health, stamina and magicka has been partially refilled.
ECHO %player.message% ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina%/%player.stamina_max% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [Q LEAVE ]
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "Q" GOTO :EXIT

:EXIT
SET enLooted=0
SET enemy.damage=%enemy.damage_base%
GOTO :EOF