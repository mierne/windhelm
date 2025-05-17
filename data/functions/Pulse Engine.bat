REM Pulse Engine Version Pre-Alpha-1.0-250516

REM Determine the reason Pulse Engine was called
:CALL_REASON
IF %PE_CALL% == Exploration_Engine (
    GOTO :PE_EXPLORATION_ENGINE
) ELSE IF %PE_CALL% == Combat_Engine (
    GOTO :PE_COMBAT_ENGINE
) ELSE (
    ECHO Pulse Engine has encountered an error.
    ECHO ERROR: CALL_REASON is empty.
    PAUSE
)

:PE_EXPLORATION_ENGINE
TITLE WINDHELM - Exploration Engine ^| %player.name% the %player.race% %player.class%!
SET RETURN=PE_EXPLORATION_ENGINE
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\exploration.txt"
ECHO.
ECHO Where is it you wish to go, %player.name%?
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / IRIDESCENT FOREST ] ^| [2 / WINDHELM EXTERIOR ] ^| [3 / ROCKWINN PLAZA ] ^| [Q / BACK ]
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :VENTURE_IRIDESCENT_FOREST
IF /I "%CH%" == "2" GOTO :VENTURE_WINDHELM_EXTERIOR
IF /I "%CH%" == "3" GOTO :VENTURE_ROCKWINN_PLAZA
IF /I "%CH%" == "Q" GOTO :AUTOSAVE
GOTO :INVALID_INPUT

:VENTURE_IRIDESCENT_FOREST
MODE con: cols=105 lines=17
SET RETURN=VENTURE_IRIDESCENT_FOREST
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\venture.txt"
ECHO.
ECHO What is it you wish to do, %player.name%?
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / ADVENTURE ] ^| [2 / AREA BOSS ] ^| [Q / BACK ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :IFOR_ADVENTURE
IF /I "%CH%" == "2" GOTO :IFOR_CHALLENGE_AREA_BOSS
IF /I "%CH%" == "Q" GOTO :MAIN
GOTO :INVALID_INPUT

:IFOR_ADVENTURE
SET /A EE=%RANDOM% %%50
IF %EE% LEQ 50 (
    SET currentEnemy=Bandit
    CALL :PE_COMBAT_ENGINE
    GOTO :VENTURE_IRIDESCENT_FOREST
) ELSE (
    REM In the future, random items may be discovered.
    SET displayMessage=You didn't find anything of interest.
    GOTO :VENTURE_IRIDESCENT_FOREST
)

:IFOR_CHALLENGE_AREA_BOSS
IF %player.iridescent_ab_defeated% EQU 1 (
    SET displayMessage=You have already defeated this great foe.
    GOTO :VENTURE_IRIDESCENT_FOREST
) ELSE (
    IF %player.level% GEQ 5 (
        SET currentEnemy="Abyss Guardian"
        GOTO :PE_COMBAT_ENGINE
        GOTO :VENTURE_IRIDESCENT_FOREST
    ) ELSE (
        SET displayMessage=Your level is too low for this encounter.
        GOTO :VENTURE_IRIDESCENT_FOREST
    )
)

:VENTURE_WINDHELM_EXTERIOR
MODE con: cols=105 lines=17
SET RETURN=VENTURE_WINDHELM_EXTERIOR
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\exterior.txt"
ECHO.
ECHO.
ECHO What is it you wish to do, %player.name%?
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / WANDER ] ^| [2 / TRAVELING MERCHANT ] ^| [Q / BACK ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :WE_WANDER
IF /I "%CH%" == "2" GOTO :WE_TRAVELING_MERCHANT
IF /I "%CH%" == "Q" GOTO :MAIN
GOTO :INVALID_INPUT

:WE_TRAVELING_MERCHANT
MODE con: cols=100 lines=16
SET RETURN=WE_TRAVELING_MERCHANT
SET displayMessage=...
CLS
ECHO.
TYPE "%cd%\data\assets\npcs\merchant.txt"
ECHO.
ECHO You approach the merchant's wagon, which has been temporarily transformed into a market stall.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / VIEW WARES ] ^| [Q / BACK ] ^| %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :TM_VIEW_ITEMS
IF /I "%CH%" == "Q" GOTO :MAIN
GOTO :INVALID_INPUT

:TM_VIEW_ITEMS
TITLE (Rockwinn Plaza) - Alchemist ^| %player.name% the %player.race% %player.class%
MODE con: cols=100 lines=20
SET RETURN=VENDOR_ALCHEMIST
ECHO.
TYPE "%cd%\data\assets\npcs\merchant.txt"
ECHO.
ECHO.
ECHO What can I do for you, Shard?
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| XP TONIC: %vendor.travmerch_xp_tonic_stock% STOCKED, PRICE: %vendor.travmerch_xp_tonic_price% LUNIS
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + [1 / XP TONIC ] ^| [Q / GO BACK ]                                                                 +
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :TM_BUY_XP_TONIC
IF /I "%CH%" == "Q" GOTO :WE_TRAVELING_MERCHANT
GOTO :INVALID_INPUT

:TM_BUY_XP_TONIC
IF %vendor.travmerch_xp_tonic_stock% LSS 1 (
    SET displayMessage=Apologizes, I am sold out of that item..
    GOTO :TM_VIEW_ITEMS
) ELSE (
    IF %player.coins% LSS %vendor.travmerch_xp_tonic_price% (
        SET displayMessage=Sorry, you can't afford that item.
        GOTO :TM_VIEW_ITEMS
    ) ELSE (
        SET /A player.coins=!player.coins! -%vendor.travmerch_xp_tonic_price%
        SET /A player.item_tonic_xp_owned=!player.item_tonic_xp_owned! +1
        SET /A vendor.travmerch_xp_tonic_stock=!vendor.travmerch_xp_tonic_stock! -1
        SET displayMessage=Purchased 1 XP Tonic for %vendor.travmerch_xp_tonic_price%.
        GOTO :TM_VIEW_ITEMS
    )
)

MODE con: cols=105 lines=19
SET RETURN=TM_VIEW_ITEMS
SET displayMessage=...
CLS
ECHO.
REM TYPE "%winLoc%\PATH\TO\ASCII\ART"
ECHO.
ECHO The merchant greets you with a friendly smile.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / APPROACH ] ^| [Q / BACK ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :WE_WANDER_ENCOUNTER_1_INT1
IF /I "%CH%" == "Q" GOTO :WE_TRAVELING_MERCHANT
GOTO :INVALID_INPUT

:WE_WANDER
SET /A  WE=%RANDOM% %%50
IF %WE% LEQ 15 (
    REM ENCOUNTER PLACEHOLDER NPC (QUESTGIVER)
    GOTO :WE_WANDER_ENCOUNTER_1
) ELSE (
    SET displayMessage=You didn't find anything of interest.
    GOTO :VENTURE_WINDHELM_EXTERIOR
)

:VENTURE_ROCKWINN_PLAZA
CALL "%winLoc%\data\functions\Rockwinn Plaza.bat"
GOTO :MAIN

:WE_WANDER_ENCOUNTER_1
MODE con: cols=105 lines=19
SET RETURN=WE_WANDER_ENCOUNTER_1
SET displayMessage=...
CLS
ECHO.
REM TYPE "%winLoc%\PATH\TO\ASCII\ART"
ECHO.
ECHO You see someone with what appears to be a polearm closely following another.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / APPROACH ] ^| [Q / BACK ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :WE_WANDER_ENCOUNTER_1_INT1
IF /I "%CH%" == "Q" GOTO :MAIN
GOTO :INVALID_INPUT

:WE_WANDER_ENCOUNTER_1_INT1
MODE con: cols=105 lines=19
SET RETURN=WE_WANDER_ENCOUNTER_1_INT1
CLS
ECHO.
REM TYPE "%winLoc%\PATH\TO\ASCII\ART"
ECHO.
ECHO As you approach the set of guards, they turn and look to meet your gaze,
ECHO their eyes barely visible behind their visors.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / TELL ME ABOUT WINDHELM ] ^| [2 / EARNING LUNIS ] ^| [Q / BACK ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :WE_WANDER_ENCOUNTER_1_INT1_CH1
IF /I "%CH%" == "2" GOTO :WE_WANDER_ENCOUNTER_1_INT1_CH2
IF /I "%CH%" == "Q" GOTO :MAIN
GOTO :INVALID_INPUT

:WE_WANDER_ENCOUNTER_1_INT1_CH1
MODE con: cols=105 lines=22
SET RETURN=WE_WANDER_ENCOUNTER_1_INT1_CH1
CLS
ECHO.
REM TYPE "%winLoc%\PATH\TO\ASCII\ART"
ECHO.
ECHO The guard on your left speaks up, a rather low baritone voice comes from his helment.
ECHO "Bit of a vague question, no? Well regardless, I'm no historian so don't just run with what I tell you."
ECHO "There's plenty of rumors I'm sure you've heard but, if I'm being honest.."
ECHO.
ECHO The guard leans in as much as the plate armor they wore allowed.
ECHO "I'm pretty sure this castle was placed here by the Gods themselves. I mean, how could it not have been?"
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / CONTINUE ] ^| [Q / BACK ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :WE_WANDER_ENCOUNTER_1_INT1_CH1_SCH1
IF /I "%CH%" == "Q" GOTO :WE_WANDER_ENCOUNTER_1_INT1
GOTO :INVALID_INPUT

:WE_WANDER_ENCOUNTER_1_INT1_CH1_SCH1
MODE con: cols=105 lines=19
SET RETURN=WE_WANDER_ENCOUNTER_1_INT1_CH1_SCH1
CLS
ECHO.
REM TYPE "%winLoc%\PATH\TO\ASCII\ART"
ECHO.
ECHO The guard on your left straights up. You can't imagine that armor is very comfortable.
ECHO "It's in the perfect spot. Right in the middle of a strange, magical forest?"
ECHO "It's hard enough leaving the forest, imagine trying to get in! Not a chance man put this here."
ECHO "I mean, the records of this castle's builders are so scattered I'd be surprised if they were even real^!"
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / CONTINUE ] ^| [Q / BACK ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :WE_WANDER_ENCOUNTER_1_INT1_CH1_SCH2
IF /I "%CH%" == "Q" GOTO :WE_WANDER_ENCOUNTER_1_INT1
GOTO :INVALID_INPUT

:WE_WANDER_ENCOUNTER_1_INT1_CH1_SCH2
MODE con: cols=105 lines=19
SET RETURN=WE_WANDER_ENCOUNTER_1_INT1_CH1_SCH2
CLS
ECHO.
REM TYPE "%winLoc%\PATH\TO\ASCII\ART"
ECHO.
ECHO The guard on your right turns around, clearly ready to take their leave.
ECHO "Anyway, that's all I've to say about the matter at least. I would say visit the castle library"
ECHO "but the Lorekeeper hasn't been seen in.. I believe about five days^! Very unusual."
ECHO "You know, if you find the man and bring him back.. alive, the Lord may reward your efforts."
ECHO.
ECHO The guard on the left performs a small bow and turns about, following the other guard.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^|[Q / BACK ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "Q" GOTO :WE_WANDER_ENCOUNTER_1_INT1
GOTO :INVALID_INPUT

:INVALID_INPUT
ECHO "%CH%" is not a valid input.
PAUSE
GOTO :%RETURN%

REM Combat Engine
:PE_COMBAT_ENGINE
REM temp fix for empty variables (what's causing this?)
SET /A CR=%RANDOM% * 17 / 32768 + 8
SET player_levelup_notif=.
SET player.info=...
SET ce.boss_active=0

REM Global Variables
SET player.armor_calculated=0
SET enLooted=0
SET player.damage_base=%player.damage%

REM Iridescent Bandit Information
SET bandit.health=80
SET bandit.magicka=100
SET bandit.damage=14
SET bandit.damage_type_resistance=physical
SET bandit.damage_resisted=0

REM Abyss Guardian Information
SET abyss_guardian.health=200
SET abyss_guardian.magicka=400
SET abyss_guardian.damage=20
SET abyss_guardian.special_damage=45
SET abyss_guardian.damage_type_resistance=physical
SET abyss_guardian.damage_resisted=6
SET abyss_guardian.dialogue_title=Abyss Lurker L'yahn
REM Currently unsued data
SET abyss_guardian.faction=Abyss Lurkers

:PE_COMBAT_ENGINE_ENCOUNTER
IF "%currentEnemy%" == "Bandit" (
    SET enemy.health=%bandit.health%
    SET enemy.magicka=%bandit.magicka%
    SET enemy.damage=%bandit.damage%
    SET enemy.damage_type_resistance=%bandit.damage_type_resistance%
    SET enemy.damage_resisted=%bandit.damage_resisted%
    SET enemy.damage_base=%bandit.damage%
    SET ce.boss_active=0
    SET curEn=Bandit
    GOTO :PE_EBS
) ELSE IF "%currentEnemy%" == "Abyss Guardian" (
    SET enemy.health=%abyss_guardian.health%
    SET enemy.magicka=%abyss_guardian.magicka%
    SET enemy.damage=%abyss_guardian.damage%
    SET enemy.damage_base=%abyss_guardian.damage%
    SET enemy.special_damage=%abyss_guardian.special_damage%
    SET enemy.damage_type_resistance=%abyss_guardian.damage_type_resistance%
    SET enemy.damage_resisted=%abyss_guardian.damage_resisted%
    SET enemy.dialogue_title=%abyss_guardian.dialogue_title%
    SET ce.boss_active=1
    SET curEn=Abyss Guardian
    GOTO :PE_EBS
) ELSE (
    REM Error handling.
    ECHO Enemy type unavailable. >> EV-ERROR.log
    SET errorType=EnemyType
    CALL "%winLoc%\data\functions\Error Handler.bat"
    EXIT /B
)

:PE_EBS
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
    GOTO :PE_EBS_BOSS
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
    GOTO :PE_EBS
) ELSE IF %PA% GEQ 31 (
    REM Normal Attack 2
    SET displayMessage=PLAYER HIT - placeholder
    SET /A player.health=!player.health! -%enemy.damage%
    GOTO :PE_EBS
) ELSE IF %PA% LEQ 30 (
    REM Player attack misses.
    SET player.message=The %currentEnemy% tripped on a pebble and missed.
    GOTO :PE_EBS
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
    GOTO :PE_EBS
) ELSE IF %PA% GEQ 11 (
    REM Normal Attack 2
    SET displayMessage=ABYSS placeholder - norm
    SET /A player.health=!player.health! -%enemy.damage%
    GOTO :PE_EBS
) ELSE IF %PA% LEQ 10 (
    REM Player attack misses.
    SET player.message=The %currentEnemy% tripped on a pebble and missed.
    GOTO :PE_EBS
) ELSE (
    REM Error handling
)


:PLAYER_INVENTORY
REM REDESIGN PLAYER INVENTORY ACCESS

:PLAYER_ITEMS
SET windhelm.inventory_call=combat
CALL "%winLoc%\data\functions\Inventory Viewer.bat"
GOTO :PE_EBS

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
GOTO :PE_EBS

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
GOTO :PE_EXPLORATION_ENGINE

:AUTOSAVE
SET SLOPr=save
CALL "%winLoc%\data\functions\SLOP.bat"
GOTO :EOF