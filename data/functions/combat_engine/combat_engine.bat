rem Intialize variables for combat engine logic
rem temp fix for empty variables (what's causing this?)
rem SET /A CR=%RANDOM% * 17 / 32768 + 8
SET "player_levelup_notif=."
SET "player.info=..."
set player.damage_base=%player.damage%
set player.magicka_base=%player.magicka%
set player.armor_class_base=%player.armor_class%
SET player.armor_calculated=0
set player.skip_turn=0
rem Not sure what this should scale with, but it needs to be SMALL. The scaling, that is.
rem For now, players will be favored in battles.
set player.roll_to_hit=8

REM Iridescent Bandit Information
SET bandit.health=100
SET bandit.magicka=100
SET bandit.damage=9
SET "bandit.damage_type_resistance=physical"
SET bandit.damage_resisted=0
rem The number a player must roll to hit this enemy
set bandit.roll_to_hit=6

REM Abyss Guardian Information
SET abyss_guardian.health=200
SET abyss_guardian.magicka=400
SET abyss_guardian.damage=20
SET abyss_guardian.special_damage=45
SET "abyss_guardian.damage_type_resistance=physical"
SET abyss_guardian.damage_resisted=4
SET "abyss_guardian.dialogue_title=Abyss Lurker L'yahn"

rem General enemy information
set CE_enemy_looted=0
set CE_boss_active=0

rem Begin the fight provided by Exploration Engine
goto :%1

:Bandit
set "currentEnemy=Bandit"
SET enemy.health=%bandit.health%
SET enemy.magicka=%bandit.magicka%
SET enemy.damage=%bandit.damage%
SET enemy.damage_base=%bandit.damage%
SET ce.boss_active=0
SET enemy.damage_resisted=%bandit.damage_resisted%
SET "enemy.damage_type_resistance=%bandit.damage_type_resistance%"
set enemy.roll_to_hit=%bandit.roll_to_hit%
IF %player.catalogue_bandit_encountered% EQU 0 (
    SET player.catalogue_bandit_encountered=1
    SET "player.catalogue_bandit=Bandit"
    set /a player.catalogue_unlocked+=1
    SET "displayMessage=..."
    GOTO :player_setup
) ELSE (
    SET "displayMessage=..."
    GOTO :player_setup
)

:AbyssalGuardian
set "currentEnemy=Abyssal Guardian"
SET enemy.health=%abyss_guardian.health%
SET enemy.magicka=%abyss_guardian.magicka%
SET enemy.damage=%abyss_guardian.damage%
SET enemy.damage_base=%abyss_guardian.damage%
SET enemy.special_damage=%abyss_guardian.special_damage%
SET "enemy.damage_type_resistance=%abyss_guardian.damage_type_resistance%"
SET enemy.damage_resisted=%abyss_guardian.damage_resisted%
SET enemy.dialogue_title=%abyss_guardian.dialogue_title%
SET ce.boss_active=1
IF %player.catalogue_abyss_guardian_encountered% EQU 0 (
    SET player.catalogue_abyss_guardian_encountered=1
    SET "player.catalogue_abyss_guardian=Abyss Guardian"
    set /a player.catalogue_unlocked+=1
    SET "displayMessage=..."
    GOTO :player_setup
) ELSE (
    SET "displayMessage=..."
    GOTO :player_setup
)

:combat_engine
MODE con: cols=120 lines=25
IF %enemy.health% LEQ 0 GOTO :VICTORY_STATS_TRACK
IF %player.health% LEQ 0 GOTO :DEFEAT_SCREEN
SET player.damage=%player.damage_base%
TITLE (WINDHELM) - Combat Engine ^| %player.name% the %player.race% %player.class% vs %currentEnemy% & SET enAT=%enATb%
set "rtm=combat_engine"
CLS
echo.
TYPE "%winLoc%\data\assets\enemies\Iridescent Forest\%currentEnemy%.txt"
echo.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| %currentEnemy% HP: %enemy.health% ^| ATK: %enemy.damage%
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| %displayMessage%
ECHO ^| %player.message%
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| ATK: %player.damage%/%player.spell_damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [A / ATTACK ] ^| [I / ITEMS ]
ECHO +----------------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "A" GOTO :PLAYER_ATTACK_OPTIONS
if /i "%CH%" == "AS" goto :player_use_spell
if /i "%CH%" == "AA" goto :PLAYER_ATTACK
IF /I "%CH%" == "I" GOTO :PLAYER_ITEMS
GOTO :INVALID_INPUT

:PLAYER_ATTACK_OPTIONS
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [A / USE WEAPON ] ^| [S / USE SPELL ] ^| [C / CANCEL ]
ECHO +----------------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
if /i "%CH%" == "A" goto :PLAYER_ATTACK
if /i "%CH%" == "S" goto :player_use_spell
if /i "%CH%" == "C" goto :combat_engine
GOTO :INVALID_INPUT

:player_use_spell
if "%player.spell_equipped_type%" == "damage" (
    goto :player_attack_spell
) else if "%player.spell_equipped_type%" == "restoration" (
    goto :player_use_restoration_spell
) else (
    set "displayMessage=You do not have a spell equipped!"
    goto :combat_engine
)

:player_use_restoration_spell
set player.healing_log=0
call "%winLoc%\data\functions\roll.bat"
set preroll=%dieroll%
set /a dieroll+=player.skill_intelligence
if %player.magicka% LSS %player.spell_cost% (
    set "player.message=You don't have enough magicka to cast this spell."
    goto :combat_engine
)
set /a player.magicka-=player.spell_cost
set /a player.health+=player.spell_healing+dieroll
set /a player.healing_log+=dieroll+player.skill_intelligence
set "player.message=Healed yourself for %player.healing_log%^!"
goto :PLAYER_ARMOR_CALCULATION

:player_attack_spell
rem INT boosts spell rolling by the level of the skill. This is a placeholder for school specific spells.
rem Use the new die roll system
call "%winLoc%\data\functions\roll.bat"
set preroll=%dieroll%
set /a dieroll+=player.skill_intelligence
if %player.magicka% LSS %player.spell_cost% (
    set "player.message=You don't have enough magicka to cast this spell."
    goto :combat_engine
)
if %dieroll% LSS %enemy.roll_to_hit% (
    set "player.message=You rolled a %dieroll%(%preroll%+%player.skill_intelligence%), but you needed a %enemy.roll_to_hit%^!"
    goto :PLAYER_ARMOR_CALCULATION
) else if %dieroll% GEQ 20 (
    set /a player.magicka-=player.spell_cost
    set /a enemy.health-=player.spell_damage
    set /a enemy.health-=dieroll
    goto :bug_workaround
) else (
    set /a player.magicka-=player.spell_cost
    set /a enemy.health-=player.spell_damage
    set /a enemy.health-=dieroll
    goto :bug_workaround
)

:bug_workaround
set player.damage_log=0
set /a player.damage_log+=dieroll+player.spell_damage
if %dieroll% geq 20 (
    set "player.message=You rolled a %dieroll%(%preroll%+%player.skill_intelligence%), hitting a critical, dealing %player.damage_log% damage to the %currentEnemy% with %player.spell_equipped%^!"
    goto :PLAYER_ARMOR_CALCULATION
) else (
    set "player.message=You rolled a %dieroll%(%preroll%+%player.skill_intelligence%), dealing %player.damage_log% damage to the %currentEnemy% with %player.spell_equipped%^!"
    goto :PLAYER_ARMOR_CALCULATION
)

:PLAYER_ATTACK
rem The skills to scale with weapon types do not exist yet, so it just uses damage for now.
rem Uses the new dieroll system to calculate damage.
call "%winLoc%\data\functions\roll.bat"
set preroll=%dieroll%
set /a dieroll+=player.skill_damage
if %dieroll% lss %enemy.roll_to_hit% (
    set "player.message=You rolled a %dieroll%(%preroll%+%player.skill_damage%), but you needed a %enemy.roll_to_hit%^!"
    goto :PLAYER_ARMOR_CALCULATION
) else if %dieroll% geq 20 (
    set /a enemy.health-=player.damage
    set /a enemy.health-=dieroll
    goto :bwa2
) else (
    set /a enemy.health-=player.damage
    set /a enemy.health-=dieroll
    goto :bwa2
)

:bwa2
set player.damage_log=0
set /a player.damage_log+=dieroll+player.damage
if %dieroll% geq 20 (
    set "player.message=You rolled a %dieroll%(%preroll%+%player.skill_damage%), hitting a critical, dealing %player.damage_log% damage to the %currentEnemy% with the %player.weapon_equipped%^!"
    goto :PLAYER_ARMOR_CALCULATION
) else (
    set "player.message=You rolled a %dieroll%(%preroll%+%player.skill_damage%), dealing %player.damage_log% damage to the %currentEnemy% with the %player.weapon_equipped%^!"
    goto :PLAYER_ARMOR_CALCULATION
)

:PLAYER_ARMOR_CALCULATION
REM Adjusts enemy attack damage based on Player armor value.
SET enemy.damage=%enemy.damage_base%
IF %player.armor_class% LEQ 0 (
    GOTO :CHECK_ACTIVE_BOSS
) ELSE (
    set /a enemy.damage-=player.armor_class
    GOTO :CHECK_ACTIVE_BOSS
)

:CHECK_ACTIVE_BOSS
REM Checks if the Player activated the area boss.
IF %ce.boss_active% EQU 1 (
    GOTO :combat_engine_BOSS
) ELSE (
    GOTO :ENEMY_ATTACK_CALCULATION
)

:ENEMY_ATTACK_CALCULATION
rem Enemies do not current have skills that can boost their attacks, so just use the player's damage skill for now.
rem Uses the new dieroll system to calculate damage.
call "%winLoc%\data\functions\roll.bat"
set preroll=%dieroll%
set /a dieroll+player.skill_damage
if %dieroll% lss %enemy.roll_to_hit% (
    set "displayMessage=The %currentEnemy% rolled a %dieroll%(%preroll%+%player.skill_damage%), but you needed %player.roll_to_hit%^!"
    goto :PLAYER_ARMOR_CALCULATION
) else if %dieroll% geq 20 (
    set /a player.health-=enemy.damage
    set /a player.health-=dieroll
    goto :bwa3
) else (
    set /a player.health-=enemy.damage
    set /a player.health-=dieroll
    goto :bwa3
)

:bwa3
set enemy.damage_log=0
set /a enemy.damage_log+=dieroll+enemy.damage
if %dieroll% geq 20 (
    set "displayMessage=The %currentEnemy% rolled a %dieroll%(%preroll%+%player.skill_damage%), hitting a critical, dealing %enemy.damage_log% damage to %player.name%^!"
    goto :combat_engine
) else (
    set "displayMessage=The %currentEnemy% rolled a %dieroll%(%preroll%+%player.skill_damage%), dealing %enemy.damage_log% damage to %player.name%^!"
    goto :combat_engine
)

:combat_engine_BOSS
SET /A PA=%RANDOM% %%100
IF %PA% GEQ 70 (
    SET "displayMessage=Abyssal Guardian got a critical hit on %player.name%."
    set /a player.health-=enemy.damage*2
    GOTO :combat_engine
) ELSE IF %PA% GEQ 15 (
    SET displayMessage=Abyssal Guardian managed a strike on %player.name%.
    set /a player.health-=enemy.damage
    GOTO :combat_engine
) ELSE (
    SET "displayMessage=Abyssal Guardian missed %player.name% by mere inches."
    GOTO :combat_engine
)

:PLAYER_ITEMS
SET "windhelm.inventory_call=combat"
CALL "%winLoc%\data\functions\Inventory Viewer.bat"
GOTO :combat_engine

:VICTORY_STATS_TRACK
IF "%currentEnemy%" == "Bandit" (
    set /a player.bandits_slain+=1
    GOTO :VICTORY_TRACK_CLEARED
) ELSE IF "%currentEnemy%" == "Abyssal Guardian" (
    set /a player.iridescent_ab_defeated+=1
    SET player.pe_abgu_cleared=1
    GOTO :BOSS_DEFEAT_REWARDS
) ELSE (
    echo PULSE ENGINE: error on line 744
    pause
    exit /b
)

:VICTORY_TRACK_CLEARED
if %player.iridescent_forest_level% EQU 1 (
    set /a player.iridescent_forest_level_1_enemy_remaining-=1
    goto :VICTORY_REWARDS
) else if %player.iridescent_forest_level% EQU 2 (
    set /a player.iridescent_forest_level_2_enemy_remaining-=1
    goto :VICTORY_REWARDS
) else if %player.iridescent_forest_level% EQU 3 (
    set /a player.iridescent_forest_level_3_enemy_remaining-=1
    goto :VICTORY_REWARDS
) else (
    echo Combat Engine: error on line 215.
    pause
    exit /b
)


:BOSS_DEFEAT_REWARDS
SET "displayMessage=You defeated the Abyssal Guardian terrorizing the Iridescent Forest."
set /a player.coins+=2500
set /a player.xp+=10000
GOTO :VICTORY_REWARDS

:VICTORY_REWARDS
SET player.health=%player.health_max%
SET player.magicka=%player.magicka_max%
SET /A XPE=%RANDOM% %%80
IF %XPE% LEQ 30 (
    set /a player.xp+=30
    SET "displayMessage=Earned 30 XP"
    GOTO :VICTORY_REWARDS_LUNIS
) ELSE IF %XPE% LEQ 60 (
    set /a player.xp+=70
    SET "displayMessage=Earned 70 XP"
    GOTO :VICTORY_REWARDS_LUNIS
) ELSE (
    set /a player.xp+=100
    SET "displayMessage=Earned 100 XP"
    GOTO :VICTORY_REWARDS_LUNIS
)

:VICTORY_REWARDS_LUNIS
IF %player.level% LSS 10 (
    set /a player.coins+=5
    SET "player.message=You earned 5 LUNIS"
    GOTO :VICTORY_SCREEN
) ELSE IF %player.level% LSS 20 (
    set /a player.coins+=10
    SET "player.message=You earned 10 LUNIS"
    GOTO :VICTORY_SCREEN
) ELSE IF %player.level% LSS 30 (
    set /a player.coins+=20
    SET "player.message=You earned 20 LUNIS"
    GOTO :VICTORY_SCREEN
) ELSE IF %player.level% LSS 40 (
    set /a player.coins+=30
    SET "player.message=You earned 40 LUNIS"
    GOTO :VICTORY_SCREEN
) ELSE (
    set /a player.coins+=50
    SET "player.message=You earned 50 LUNIS"
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
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| ATK: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO [1 / LOOT ] ^| [E LEAVE ]
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :LOOT
IF /I "%CH%" == "E" GOTO :CLEANUP

:LOOT
IF %enLooted% EQU 1 (
    set "displayMessage=Already looted this enemy."
    goto :VICTORY_SCREEN
) else (
    call "%winLoc%\data\functions\combat_engine\loot.bat"
)

:DEFEAT_SCREEN
set /a player.total_deaths+=1
@REM SET /A player.total_deaths=!player.total_deaths! +1
SET player.health=%player.health_max%
SET player.magicka=%player.magicka_max%
SET "player.message=..."
SET "displayMessage=..."
MODE con: cols=105 lines=18
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\defeat.txt"
ECHO.
ECHO You were defeated by the %currentEnemy%. Your health and magicka has been restored.
ECHO %player.message% ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| ATK: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [E LEAVE ]
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "E" GOTO :CLEANUP

:INVALID_INPUT
set "displayMessage="%CH%" is not a valid input."
GOTO :%RETURN%

:error_CFSL
set "displayMessage=Error encountered. Cannot find selected level."
GOTO :%RETURN%

:CLEANUP
rem Reset the area the player was last in when the battle started.
set "player.iridescent_forest_level_1_location=NotStarted"
SET enLooted=0
SET enemy.damage=%enemy.damage_base%
GOTO :AUTOSAVE

:AUTOSAVE
SET "SLOPr=SAVE"
CALL "%winLoc%\data\functions\SLOP.bat"
GOTO :EOF