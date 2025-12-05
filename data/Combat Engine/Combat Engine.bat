REM temp fix for empty variables (what's causing this?)
SET /A CR=%RANDOM% * 17 / 32768 + 8

:EBS
MODE con: cols=105 lines=20
IF %enemy.health% LEQ 0 GOTO :VICTORY_STATS_TRACK
IF %player.health% LEQ 0 GOTO :DEFEAT_SCREEN
SET player.damage=%player.damage_base%
TITLE (WINDHELM) - COMBAT ENGINE ^| %player.name% the %player.race% %player.class% vs %curEn% & SET enAT=%enATb%
CLS
ECHO.
TYPE "%winLoc%\data\assets\enemies\Iridescent Forest\%currentEnemy%.txt"
ECHO.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| %currentEnemy% HP: %enemy.health% ^| ATK: %enemy.damage%
ECHO ^| %displayMessage%
ECHO ^| %player.message%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [A / ATTACK ] ^| [I / ITEMS ] ^| [Q / FLEE ]
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "A" GOTO :PLAYER_ATTACK
IF /I "%CH%" == "I" GOTO :PLAYER_ITEMS
IF /I "%CH%" == "Q" GOTO :PLAYER_FLEE

:PLAYER_ATTACK
REM a number between 0 and 100 can be split 4 ways, two hits, a crit and a miss. Descending chance in that order.
SET /A PA=%RANDOM% %%100
IF %PA% GEQ 80 (
    REM Critical hit
    SET player.message=That REALLY hurt.
    SET /A enemy.health=!enemy.health! -%player.damage%*2
    GOTO :PLAYER_ARMOR_CALCULATION
) ELSE IF %PA% GEQ 27 (
    REM Normal Attack 2
    SET player.message=You managed a hit, mother would be proud.
    SET /A enemy.health=!enemy.health! -%player.damage%
    GOTO :PLAYER_ARMOR_CALCULATION
) ELSE IF %PA% LEQ 26 (
    REM Player attack misses.
    SET player.message=You forgot to tie your laces and fall flat on your face.
    GOTO :PLAYER_ARMOR_CALCULATION
) ELSE (
    REM Error handling
)

:PLAYER_ARMOR_CALCULATION
REM Adjusts enemy attack damage based on Player armor value.
SET enemy.damage=%enemy.damage_base%
IF %player.armor_prot% LEQ 0 (
    GOTO :CHECK_ACTIVE_BOSS
) ELSE (
    SET /A enemy.damage=!enemy.damage! -%player.armor_prot%
    GOTO :CHECK_ACTIVE_BOSS
)

:CHECK_ACTIVE_BOSS
REM Checks if the Player activated the area boss.
IF %ce.boss_active% EQU 1 (
    GOTO :EBS_BOSS
) ELSE (
    GOTO :ENEMY_ATTACK_CALCULATION
)

:CHECK_ACTIVE_BOSS
IF %ce.boss_active% EQU 1 (
    GOTO :EAC_BOSS
) ELSE (
    GOTO :ENEMY_ATTACK_CALCULATION
)

:ENEMY_ATTACK_CALCULATION
REM a number between 0 and 100 can be split 4 ways, two hits, a crit and a miss. Descending chance in that order. Slightly favored to miss compared to the Player.
SET /A PA=%RANDOM% %%100
IF %PA% GEQ 84 (
    REM Critical hit
    SET displayMessage=PLAYER HIT - placeholder
    SET /A player.health=!player.health! -%enemy.damage%*2
    GOTO :EBS
) ELSE IF %PA% GEQ 31 (
    REM Normal Attack 2
    SET displayMessage=PLAYER HIT - placeholder
    SET /A player.health=!player.health! -%enemy.damage%
    GOTO :EBS
) ELSE IF %PA% LEQ 30 (
    REM Player attack misses.
    SET player.message=The %currentEnemy% tripped on a pebble and missed.
    GOTO :EBS
) ELSE (
    REM Error handling
)

:EAC_BOSS
REM Much like the enemy attack phase, just stronger.
REM a number between 0 and 100 can be split 4 ways, two hits, a crit and a miss. Descending chance in that order. Favored to crit the Player.
SET /A PA=%RANDOM% %%100
IF %PA% GEQ 70 (
    REM Critical hit
    SET displayMessage=ABYSS placeholder - crit
    SET /A player.health=!player.health! -%enemy.damage%*2
    GOTO :EBS
) ELSE IF %PA% GEQ 11 (
    REM Normal Attack 2
    SET displayMessage=ABYSS placeholder - norm
    SET /A player.health=!player.health! -%enemy.damage%
    GOTO :EBS
) ELSE IF %PA% LEQ 10 (
    REM Player attack misses.
    SET player.message=The %currentEnemy% tripped on a pebble and missed.
    GOTO :EBS
) ELSE (
    REM Error handling
)


:PLAYER_INVENTORY
REM REDESIGN PLAYER INVENTORY ACCESS

:PLAYER_ITEMS
SET windhelm.inventory_call=combat
CALL "%winLoc%\data\functions\Inventory Viewer.bat"
GOTO :EBS

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
    GOTO :BOSS_DEFEAT_REWARDS
    REM GOTO :VICTORY_REWARDS
) ELSE (
    REM Enemy doesn't exist? How'd you get here?
    GOTO :ERROR_HANDLER
)

:BOSS_DEFEAT_REWARDS
SET displayMessage=You defeated the Abyssal Guardian terrorizing the Iridescent Forest.
SET /A player.coins=!player.coins! +2500
SET /A player.xp=!player.xp! +10000
GOTO :VICTORY_REWARDS

:VICTORY_REWARDS
SET player.health=%player.health_max%
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
ECHO The %currentEnemy% was defeated. Your health and magicka has been refilled!
ECHO %player.message% ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO [1 / LOOT ] ^| [Q LEAVE ]
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :LOOT
IF /I "%CH%" == "Q" GOTO :CLEANUP

:LOOT
IF %enLooted% EQU 1 (
    SET player.message=This enemy was looted already.
    GOTO :VICTORY_SCREEN
) ELSE (
    IF %player.iridescent_ab_defeated% EQU 1 (
        SET displayMessage=The great foe vanished upon defeat, nothing remains to pilfer.
        GOTO :VICTORY_SCREEN
    ) ELSE (
        GOTO :VICTORY_LOOT
    )
)

:VICTORY_LOOT
ECHO NOT IMPLEMENTED
PAUSE
GOTO :VICTORY_SCREEN

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
SET /A player.health=!player.health_max!
SET /A player.magicka=!player.magicka_max!
SET player.message=...
SET displayMessage=...
MODE con: cols=105 lines=18
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\defeat.txt"
ECHO.
ECHO You were defeated by the %currentEnemy%. Your health and magicka has been restored.
ECHO %player.message% ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [Q LEAVE ]
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "Q" GOTO :CLEANUP

:CLEANUP
SET enLooted=0
SET enemy.damage=%enemy.damage_base%
GOTO :AUTOSAVE

:AUTOSAVE
SET displayMessage=...
SET SLOPr=SAVE
CALL "%winLoc%\data\functions\SLOP.bat"
GOTO :EOF