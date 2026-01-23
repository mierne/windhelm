if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

:BATTLE_GLOBAL_RESET
REM Level selection indicator
SET IFOR.LEVEL1_SELECTED=1
SET IFOR.LEVEL2_SELECTED=0
SET IFOR.LEVEL3_SELECTED=0
SET IFOR.LEVEL4_SELECTED=0
SET IFOR.SELECTED_LEVEL=Level 1
SET IFOR.ECOUNT=%pulse.ifor_level_1_ecount%
SET "IFOR.PLAYER_CLEARED=False"
SET "IFOR.FINAL_LEVEL=False"
REM Hacky. There's a better way.
IF %pulse.ifor_level_1_ecount% EQU 0 (
    SET player.ifor_cleared_level1=1
    SET "IFOR.PLAYER_CLEARED=True"
    IF %pulse.ifor_level_2_ecount% EQU 0 (
        SET player.ifor_cleared_level2=1
        IF %pulse.ifor_level_3_ecount% EQU 0 (
            SET player.ifor_cleared_level3=1
            IF %pulse.ifor_level_4_ecount% EQU 0 (
                SET player.ifor_cleared_level4=1
            ) ELSE (
                GOTO :CALL_REASON
            )
        ) ELSE (
            GOTO :CALL_REASON
        )
    ) ELSE (
        GOTO :CALL_REASON
    )
) ELSE (
    GOTO :CALL_REASON
)

:CALL_REASON
IF "%PE_CALL%" == "Exploration_Engine" (
    GOTO :PE_EXPLORATION_ENGINE
) ELSE IF "%PE_CALL%" == "Combat_Engine" (
    GOTO :PE_COMBAT_ENGINE
) ELSE (
    ECHO Pulse Engine has encountered an error.
    ECHO ERROR: CALL_REASON is empty.
    PAUSE
)

:PE_EXPLORATION_ENGINE
MODE con: cols=105 lines=17
TITLE WINDHELM - Exploration Engine ^| %player.name% the %player.race% %player.class%!
SET RETURN=PE_EXPLORATION_ENGINE
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\exploration.txt"
ECHO.
ECHO Where is it you wish to go, %player.name%?
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| ATK: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / IRIDESCENT FOREST ] ^| [2 / WINDHELM EXTERIOR ] ^| [3 / ROCKWINN PLAZA ]
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :VENTURE_IRIDESCENT_FOREST
IF /I "%CH%" == "2" GOTO :VENTURE_WINDHELM_EXTERIOR
IF /I "%CH%" == "3" GOTO :VENTURE_ROCKWINN_PLAZA
IF /I "%CH%" == "E" GOTO :AUTOSAVE
GOTO :INVALID_INPUT

REM Iridscent Forest Level 1 - Sublevels 1-4
:VENTURE_IRIDESCENT_FOREST
MODE con: cols=140 lines=27
TITLE (Windhelm - %windhelm.ut%) Iridescent Forest ^| %player.name% the %player.race% %player.class%
SET "RETURN=VENTURE_IRIDESCENT_FOREST"
SET "PE.ZONE_ACTIVE=VENTURE_IRIDESCENT_FOREST"
CLS
ECHO                                    /                 \
ECHO ----------------------------------/ IRIDESCENT FOREST \-------------------------------------------------------------------------------------
ECHO                                   \-------------------/
ECHO -----------------------------------\     %IFOR.SELECTED_LEVEL%     /
ECHO                                     \               /
IF %IFOR.LEVEL1_SELECTED% EQU 1 (
    ECHO         ^>^| 1 ^|^<                      \             /
) ELSE (
    ECHO              1                       \             /
)
ECHO                                       ^|--------------------------\ AREA BOSS DEFEATED: %pulse.ifor_area_boss_defeated%
ECHO                                                                   \ ENEMIES: %IFOR.ECOUNT% ^| CLEARED: %IFOR.player_cleared%
IF %IFOR.LEVEL3_SELECTED% EQU 1 (
    ECHO                                                                    ^|------------------------------------------------------------------------
    ECHO -----------\
    ECHO             \                                                                            
    ECHO              ^|---------------\                                                                ^>^| 3 ^|^<
) ELSE (
    ECHO                                                                    ^|------------------------------------------------------------------------
    ECHO -----------\
    ECHO             \                                                                            
    ECHO              ^|---------------\                                                                   3
)
IF %IFOR.LEVEL4_SELECTED% EQU 1 (
    ECHO                               \                                                                                            ^>^| 4 ^|^<
) ELSE (
    ECHO                               \                                                                                                4
)
IF %IFOR.LEVEL2_SELECTED% EQU 1 (
    ECHO                                \
    ECHO                                 \            ^>^| 2 ^|^<                          ^|-------------------------------------------------------------
    ECHO                                  \                                           /
    ) ELSE (
    ECHO                                \
    ECHO                                 \               2                             ^|-------------------------------------------------------------
    ECHO                                  \                                           /
    
)
ECHO                                   ^|-----------------------------------------/ ^> %displayMessage% ^<
ECHO.
ECHO Where do you wish to go, %player.name%?
ECHO +------------------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| ATK: %player.damage% ^| DEF: %player.armor_class% ^| MGK: %player.magicka% ^| LUNIS: %player.coins%
ECHO +------------------------------------------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / NEXT LEVEL ] ^| [2 / PREVIOUS LEVEL ] ^| ^| [3 / ENTER LEVEL ] ^| [4 / SEARCH ] ^| [5 / USE ITEM ] ^| [6 / NEXT ZONE ]
ECHO +------------------------------------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :ZONE_SELECT_NEXT
IF /I "%CH%" == "2" GOTO :ZONE_SELECT_LAST
IF /I "%CH%" == "3" GOTO :IFOR_ADVENTURE
IF /I "%CH%" == "4" GOTO :IFOR_SEARCH_CURRENT
IF /I "%CH%" == "5" GOTO :IFOR_USE_ITEM_CURRENT
IF /I "%CH%" == "6" GOTO :IFOR_CHECK_AREA_BOSS
IF /I "%CH%" == "E" GOTO :PE_EXPLORATION_ENGINE
GOTO :INVALID_INPUT

:IFOR_ADVENTURE
REM Check if any foes remain and if the previous level has been cleared.
IF %IFOR.LEVEL1_SELECTED% EQU 1 (
    IF %pulse.ifor_level_1_ecount% EQU 0 (
        SET "displayMessage=No enemies remain here, move forward."
        GOTO :VENTURE_IRIDESCENT_FOREST
    ) ELSE (
        REM No previous level, so we continue
    )
) ELSE IF %IFOR.LEVEL2_SELECTED% EQU 1 (
    IF %player.ifor_cleared_level1% EQU 0 (
        GOTO :IFOR_CLEAR_PREVIOUS
    ) ELSE (
        IF %pulse.ifor_level_2_ecount% EQU 0 (
            SET "displayMessage=No enemies remain here, move forward."
            GOTO :VENTURE_IRIDESCENT_FOREST
        ) ELSE (
            GOTO :IFOR_AB_CHECK
        )
    )
) ELSE IF %IFOR.LEVEL3_SELECTED% EQU 1 (
    IF %player.ifor_cleared_level2% EQU 0 (
        GOTO :IFOR_CLEAR_PREVIOUS
    ) ELSE (
        IF %pulse.ifor_level_3_ecount% EQU 0 (
            SET "displayMessage=No enemies remain here, move forward."
            GOTO :VENTURE_IRIDESCENT_FOREST
        ) ELSE (
            GOTO :IFOR_AB_CHECK
        )
    )
) ELSE IF %IFOR.LEVEL4_SELECTED% EQU 1 (
    IF %player.ifor_cleared_level3% EQU 0 (
        @REM GOTO :IFOR_CLEAR_PREVIOUS TEMPORARY FOR DEBUGGING
        GOTO :IFOR_AB_CHECK
    ) ELSE (
        IF %pulse.ifor_level_4_ecount% EQU 0 (
            SET "displayMessage=No enemies remain here, move forward."
            GOTO :VENTURE_IRIDESCENT_FOREST
        ) ELSE (
            GOTO :IFOR_AB_CHECK
        )
    )
) ELSE (
    REM Error handling
)

REM Needs to check if selected level contains a boss foe.
:IFOR_AB_CHECK
IF %IFOR.LEVEL4_SELECTED% EQU 1 (
    SET "currentEnemy=AbyssalGuardian"
    ECHO %currentEnemy%
    PAUSE
    GOTO :PE_COMBAT_ENGINE
) ELSE (
    GOTO :IFOR_FOE_ENCOUNTER
)

:IFOR_FOE_ENCOUNTER
SET /A EE=%RANDOM% %%50
IF %EE% LEQ 50 (
    SET "currentEnemy=Bandit"
    GOTO :PE_COMBAT_ENGINE
) ELSE (
    REM Do nothing, more foes to come in the future.
    GOTO :VENTURE_IRIDESCENT_FOREST
)

:IFOR_SEARCH_CURRENT
rem Check if this level has been cleared.
IF %IFOR.LEVEL1_SELECTED% EQU 1 (
    IF %player.ifor_cleared_level1% EQU 1 (
        GOTO :IFOR_CLEARED_LEVEL
    ) ELSE (
        CALL "%winLoc%\data\functions\sublevel\IFOR\sublevel_1.bat"
        GOTO :VENTURE_IRIDESCENT_FOREST
    )
) ELSE IF %IFOR.LEVEL2_SELECTED% EQU 1 (
    IF %player.ifor_cleared_level2% EQU 1 (
        GOTO :IFOR_CLEARED_LEVEL
    ) ELSE (
        CALL "%winLoc%\data\functions\sublevel\IFOR\sublevel_2.bat"
        GOTO :VENTURE_IRIDESCENT_FOREST
    )
) ELSE IF %IFOR.LEVEL3_SELECTED% EQU 1 (
    IF %player.ifor_cleared_level3% EQU 1 (
        GOTO :IFOR_CLEARED_LEVEL
    ) ELSE (
        CALL "%winLoc%\data\functions\sublevel\IFOR\sublevel_3.bat"
        GOTO :VENTURE_IRIDESCENT_FOREST
    )
) ELSE IF %IFOR.LEVEL4_SELECTED% EQU 1 (
    IF %player.ifor_cleared_level4% EQU 1 (
        GOTO :IFOR_CLEARED_LEVEL
    ) ELSE (
        CALL "%winLoc%\data\functions\sublevel\IFOR\sublevel_4.bat"
        GOTO :VENTURE_IRIDESCENT_FOREST
    )
) ELSE (
    GOTO :error_CFSL
)

:IFOR_CLEARED_LEVEL
SET "displayMessage=You've cleared this level and cannot explore it any further."
GOTO :VENTURE_IRIDESCENT_FOREST

:IFORSC_EC
SET /A ER=%RANDOM% %%40
IF %IFOR.ECOUNT% GTR 0 (
    REM Enemies have NOT been cleared from this room. Encounter risk
    IF %ER% GEQ 20 (
        REM Check level for enemy type
        SET displayMessage=You encountered an enemy while exploring this level.
        GOTO :IFOR_AB_CHECK
    ) ELSE (
        REM No encounter
    )
    GOTO :IFORSC_LOGIC
) ELSE (
    GOTO :IFORSC_LOGIC
)

:IFOR_CLEAR_PREVIOUS
SET "displayMessage=The way is blocked... You must clear the previous level."
GOTO :VENTURE_IRIDESCENT_FOREST

:IFOR_CHECK_AREA_BOSS
IF %player.pe_abgu_cleared% EQU 0 (
    ECHO BOO! Content dead end. Check back in the future.
    PAUSE
    GOTO :%RETURN%
) ELSE (
    SET "displayMessage=Cannot pass. You must first defeat the boss here."
    GOTO :VENTURE_IRIDESCENT_FOREST
)

REM Unified Zone Exploration - UZE
:ZONE_SELECT_NEXT
IF "%PE.ZONE_ACTIVE%" == "VENTURE_IRIDESCENT_FOREST" (
    REM Sublevel selection for the Iridescent Forest
    IF %IFOR.LEVEL1_SELECTED% EQU 1 (
        SET IFOR.LEVEL1_SELECTED=0
        SET IFOR.LEVEL2_SELECTED=1
        SET "IFOR.SELECTED_LEVEL=Level 2"
        SET IFOR.ECOUNT=%pulse.ifor_level_2_ecount%
        SET "IFOR.FINAL_LEVEL=False"
        IF %player.ifor_cleared_level2% EQU 1 (
            SET "IFOR.player_cleared=True"
            GOTO :VENTURE_IRIDESCENT_FOREST
        ) ELSE (
            SET "IFOR.player_cleared=False"
            GOTO :VENTURE_IRIDESCENT_FOREST
        )
    ) ELSE IF %IFOR.LEVEL2_SELECTED% EQU 1 (
        SET IFOR.LEVEL2_SELECTED=0
        SET IFOR.LEVEL3_SELECTED=1
        SET "IFOR.SELECTED_LEVEL=Level 3"
        SET IFOR.ECOUNT=%pulse.ifor_level_3_ecount%
        SET "IFOR.FINAL_LEVEL=False"
        IF %player.ifor_cleared_level3% EQU 1 (
            SET "IFOR.PLAYER_CLEARED=True"
            GOTO :VENTURE_IRIDESCENT_FOREST
        ) ELSE (
            SET "IFOR.PLAYER_CLEARED=False"
            GOTO :VENTURE_IRIDESCENT_FOREST
        )
    ) ELSE IF %IFOR.LEVEL3_SELECTED% EQU 1 (
        SET IFOR.LEVEL3_SELECTED=0
        SET IFOR.LEVEL4_SELECTED=1
        SET "IFOR.SELECTED_LEVEL=Level 4"
        SET IFOR.ECOUNT=%pulse.ifor_level_4_ecount%
        SET "IFOR.FINAL_LEVEL=True"
        IF %player.ifor_cleared_level4% EQU 1 (
            SET "IFOR.PLAYER_CLEARED=True"
            GOTO :VENTURE_IRIDESCENT_FOREST
        ) ELSE (
            SET "IFOR.PLAYER_CLEARED=False"
            GOTO :VENTURE_IRIDESCENT_FOREST
        )
    ) ELSE IF %IFOR.LEVEL4_SELECTED% EQU 1 (
        SET "displayMessage=Cannot go any further forward."
        GOTO :VENTURE_IRIDESCENT_FOREST
    ) ELSE (
        echo PULSE ENGINE: error on line 272
        pause
        exit /b
    )
) ELSE (
        echo PULSE ENGINE: error on line 272
        pause
        exit /b
)

:ZONE_SELECT_LAST
IF "%PE.ZONE_ACTIVE%" == "VENTURE_IRIDESCENT_FOREST" (
        IF %IFOR.LEVEL4_SELECTED% EQU 1 (
        SET IFOR.LEVEL4_SELECTED=0
        SET IFOR.LEVEL3_SELECTED=1
        SET "IFOR.SELECTED_LEVEL=Level 3"
        SET IFOR.ECOUNT=%pulse.ifor_level_3_ecount%
        SET "IFOR.FINAL_LEVEL=False"
        IF %player.ifor_cleared_level3% == 1 (
            SET "IFOR.PLAYER_CLEARED=True"
            GOTO :VENTURE_IRIDESCENT_FOREST
        ) ELSE (
            SET "IFOR.PLAYER_CLEARED=False"
            GOTO :VENTURE_IRIDESCENT_FOREST
        )
    ) ELSE IF %IFOR.LEVEL3_SELECTED% EQU 1 (
        SET IFOR.LEVEL3_SELECTED=0
        SET IFOR.LEVEL2_SELECTED=1
        SET "IFOR.SELECTED_LEVEL=Level 2"
        SET IFOR.ECOUNT=%pulse.ifor_level_2_ecount%
        SET "IFOR.FINAL_LEVEL=False"
        IF %player.ifor_cleared_level2% == 1 (
            SET "IFOR.PLAYER_CLEARED=True"
            GOTO :VENTURE_IRIDESCENT_FOREST
        ) ELSE (
            SET "IFOR.PLAYER_CLEARED=False"
            GOTO :VENTURE_IRIDESCENT_FOREST
        )
    ) ELSE IF %IFOR.LEVEL2_SELECTED% EQU 1 (
        SET IFOR.LEVEL2_SELECTED=0
        SET IFOR.LEVEL1_SELECTED=1
        SET "IFOR.SELECTED_LEVEL=Level 1"
        SET IFOR.ECOUNT=%pulse.ifor_level_1_ecount%
        SET "IFOR.FINAL_LEVEL=False"
        IF %player.ifor_cleared_level1% EQU 1 (
            SET "IFOR.PLAYER_CLEARED=True"
            GOTO :VENTURE_IRIDESCENT_FOREST
        ) ELSE (
            SET "IFOR.PLAYER_CLEARED=False"
            GOTO :VENTURE_IRIDESCENT_FOREST
        )
    ) ELSE (
        SET "displayMessage=Cannot go back any further."
        GOTO :VENTURE_IRIDESCENT_FOREST
    )
) ELSE (
    echo PULSE ENGINE: error on line 328
    pause
    exit /b
)

:VENTURE_WINDHELM_EXTERIOR
MODE con: cols=105 lines=17
SET "RETURN=VENTURE_WINDHELM_EXTERIOR"
CLS
ECHO.
TYPE "%winLoc%\data\assets\ui\exterior.txt"
ECHO.
ECHO.
ECHO What is it you wish to do, %player.name%?
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| ATK: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / WANDER ] ^| [2 / TRAVELING MERCHANT ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :WE_WANDER
IF /I "%CH%" == "2" GOTO :WE_TRAVELING_MERCHANT
IF /I "%CH%" == "E" GOTO :PE_EXPLORATION_ENGINE
GOTO :INVALID_INPUT

:WE_TRAVELING_MERCHANT
MODE con: cols=100 lines=16
SET "RETURN=WE_TRAVELING_MERCHANT"
CLS
ECHO.
TYPE "%cd%\data\assets\npcs\merchant.txt"
ECHO.
ECHO You approach the merchant's wagon, which has been temporarily transformed into a market stall.
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| ATK: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| [1 / VIEW WARES ] ^| %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :TM_VIEW_ITEMS
IF /I "%CH%" == "E" GOTO :PE_EXPLORATION_ENGINE
GOTO :INVALID_INPUT

:TM_VIEW_ITEMS
TITLE (Rockwinn Plaza) - Alchemist ^| %player.name% the %player.race% %player.class%
MODE con: cols=100 lines=20
SET "RETURN=VENDOR_ALCHEMIST"
ECHO.
TYPE "%cd%\data\assets\npcs\merchant.txt"
ECHO.
ECHO.
ECHO What can I do for you, Shard?
ECHO %displayMessage%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| ATK: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +--------------------------------------------------------------------------------------------------+
ECHO ^| XP TONIC: %vendor.travmerch_xp_tonic_stock% STOCKED, PRICE: %vendor.travmerch_xp_tonic_price% LUNIS
ECHO +--------------------------------------------------------------------------------------------------+
ECHO + [E / LEAVE ]                                                                +
ECHO +--------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "E" GOTO :WE_TRAVELING_MERCHANT
GOTO :INVALID_INPUT

:WE_WANDER
SET /A  WE=%RANDOM% %%50
IF %WE% LEQ 15 (
    GOTO :WE_WANDER_ENCOUNTER_1
) ELSE (
    SET "displayMessage=You didn't find anything of interest."
    GOTO :VENTURE_WINDHELM_EXTERIOR
)

:VENTURE_ROCKWINN_PLAZA
CALL "%winLoc%\data\functions\Rockwinn Plaza.bat"
GOTO :PE_EXPLORATION_ENGINE

:WE_WANDER_ENCOUNTER_1
MODE con: cols=105 lines=19
SET "RETURN=WE_WANDER_ENCOUNTER_1"
CLS
ECHO.
REM TYPE "%winLoc%\PATH\TO\ASCII\ART"
ECHO.
ECHO You see someone with what appears to be a polearm closely following another.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| ATK: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / APPROACH ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :WE_WANDER_ENCOUNTER_1_INT1
IF /I "%CH%" == "E" GOTO :PE_EXPLORATION_ENGINE
GOTO :INVALID_INPUT

:WE_WANDER_ENCOUNTER_1_INT1
MODE con: cols=105 lines=19
SET "RETURN=WE_WANDER_ENCOUNTER_1_INT1"
CLS
ECHO.
REM TYPE "%winLoc%\PATH\TO\ASCII\ART"
ECHO.
ECHO As you approach the set of guards, they turn and look to meet your gaze,
ECHO their eyes barely visible behind their visors.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| ATK: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / TELL ME ABOUT WINDHELM ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :WE_WANDER_ENCOUNTER_1_INT1_CH1
IF /I "%CH%" == "E" GOTO :PE_EXPLORATION_ENGINE
GOTO :INVALID_INPUT

:WE_WANDER_ENCOUNTER_1_INT1_CH1
MODE con: cols=105 lines=22
SET "RETURN=WE_WANDER_ENCOUNTER_1_INT1_CH1"
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
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| ATK: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / CONTINUE ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :WE_WANDER_ENCOUNTER_1_INT1_CH1_SCH1
IF /I "%CH%" == "E" GOTO :WE_WANDER_ENCOUNTER_1_INT1
GOTO :INVALID_INPUT

:WE_WANDER_ENCOUNTER_1_INT1_CH1_SCH1
MODE con: cols=105 lines=19
SET "RETURN=WE_WANDER_ENCOUNTER_1_INT1_CH1_SCH1"
CLS
ECHO.
REM TYPE "%winLoc%\PATH\TO\ASCII\ART"
ECHO.
ECHO The guard on your left straights up. You can't imagine that armor is very comfortable.
ECHO "It's in the perfect spot. Right in the middle of a strange, magical forest?"
ECHO "It's hard enough leaving the forest, imagine trying to get in! Not a chance man put this here."
ECHO "I mean, the records of this castle's builders are so scattered I'd be surprised if they were even real^!"
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| ATK: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / CONTINUE ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :WE_WANDER_ENCOUNTER_1_INT1_CH1_SCH2
IF /I "%CH%" == "E" GOTO :WE_WANDER_ENCOUNTER_1_INT1
GOTO :INVALID_INPUT

:WE_WANDER_ENCOUNTER_1_INT1_CH1_SCH2
MODE con: cols=105 lines=19
SET "RETURN=WE_WANDER_ENCOUNTER_1_INT1_CH1_SCH2"
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
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| ATK: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^|[E / BACK ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "E" GOTO :WE_WANDER_ENCOUNTER_1_INT1
GOTO :INVALID_INPUT

:INVALID_INPUT
set "displayMessage="%CH%" is not a valid input."
GOTO :%RETURN%

REM Combat Engine
:PE_COMBAT_ENGINE
REM temp fix for empty variables (what's causing this?)
SET /A CR=%RANDOM% * 17 / 32768 + 8
SET "player_levelup_notif=."
SET "player.info=..."
SET ce.boss_active=0

REM Global Variables
SET player.armor_calculated=0
SET enLooted=0
SET player.damage_base=%player.damage%

REM Iridescent Bandit Information
SET bandit.health=70
SET bandit.magicka=100
SET bandit.damage=10
SET "bandit.damage_type_resistance=physical"
SET bandit.damage_resisted=0

REM Abyss Guardian Information
SET abyss_guardian.health=200
SET abyss_guardian.magicka=400
SET abyss_guardian.damage=20
SET abyss_guardian.special_damage=45
SET "abyss_guardian.damage_type_resistance=physical"
SET abyss_guardian.damage_resisted=4
SET "abyss_guardian.dialogue_title=Abyss Lurker L'yahn"
REM Currently unsued data
SET "abyss_guardian.faction=Abyss Lurkers"

:PE_COMBAT_ENGINE_ENCOUNTER
IF "%currentEnemy%" == "Bandit" (
    SET enemy.health=%bandit.health%
    SET enemy.magicka=%bandit.magicka%
    SET enemy.damage=%bandit.damage%
    SET "enemy.damage_type_resistance=%bandit.damage_type_resistance%"
    SET enemy.damage_resisted=%bandit.damage_resisted%
    SET enemy.damage_base=%bandit.damage%
    SET ce.boss_active=0
    SET "curEn=Bandit"
    IF %player.catalogue_bandit_encountered% EQU 0 (
        SET player.catalogue_bandit_encountered=1
        SET "player.catalogue_bandit=Bandit"
        set /a player.catalogue_unlocked+=1
        SET "displayMessage=..."
        GOTO :PE_EBS
    ) ELSE (
        SET "displayMessage=..."
        GOTO :PE_EBS
    )
) ELSE IF "%currentEnemy%" == "AbyssalGuardian" (
    SET enemy.health=%abyss_guardian.health%
    SET enemy.magicka=%abyss_guardian.magicka%
    SET enemy.damage=%abyss_guardian.damage%
    SET enemy.damage_base=%abyss_guardian.damage%
    SET enemy.special_damage=%abyss_guardian.special_damage%
    SET "enemy.damage_type_resistance=%abyss_guardian.damage_type_resistance%"
    SET enemy.damage_resisted=%abyss_guardian.damage_resisted%
    SET enemy.dialogue_title=%abyss_guardian.dialogue_title%
    SET ce.boss_active=1
    SET "curEn=Abyss Guardian"
    IF %player.catalogue_abyss_guardian_encountered% EQU 0 (
        SET player.catalogue_abyss_guardian_encountered=1
        SET "player.catalogue_abyss_guardian=Abyss Guardian"
        set /a player.catalogue_unlocked+=1
        SET "displayMessage=..."
        GOTO :PE_EBS
    ) ELSE (
        SET "displayMessage=..."
        GOTO :PE_EBS
    )
) ELSE (
    echo PULSE ENGINE: error on line 591
    pause
    exit /b
)

:PE_EBS
MODE con: cols=120 lines=21
IF %enemy.health% LEQ 0 GOTO :VICTORY_STATS_TRACK
IF %player.health% LEQ 0 GOTO :DEFEAT_SCREEN
SET player.damage=%player.damage_base%
TITLE (WINDHELM) - COMBAT ENGINE ^| %player.name% the %player.race% %player.class% vs %curEn% & SET enAT=%enATb%
CLS
ECHO.
TYPE "%winLoc%\data\assets\enemies\Iridescent Forest\%currentEnemy%.txt"
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| %currentEnemy% HP: %enemy.health% ^| ATK: %enemy.damage%
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| %displayMessage%
ECHO ^| %player.message%
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| ATK: %player.damage% ^| AC: %player.armor_class% ^| MG: %player.magicka%
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [A / ATTACK ] ^| [I / ITEMS ]
ECHO +----------------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "A" GOTO :PLAYER_ATTACK
IF /I "%CH%" == "I" GOTO :PLAYER_ITEMS
GOTO :INVALID_INPUT

:PLAYER_ATTACK
REM a number between 0 and 100 can be split 4 ways, two hits, a crit and a miss. Descending chance in that order.
SET /A PA=%RANDOM% %%100
IF %PA% GEQ 80 (
    REM Critical hit
    SET "player.message=%player.name% got a critical hit on %curEn%^!"
    set /a enemy.health-=player.damage*2
    @REM SET /A enemy.health=!enemy.health! -%player.damage%*2
    GOTO :PLAYER_ARMOR_CALCULATION
) ELSE IF %PA% GEQ 16 (
    REM Normal Attack 2
    SET "player.message=%player.name% landed a solid hit on %curEn%."
    set /a enemy.health-=player.damage
    GOTO :PLAYER_ARMOR_CALCULATION
) ELSE IF %PA% LEQ 15 (
    REM Player attack misses.
    SET "player.message=You forgot to tie your laces and fall flat on your face."
    GOTO :PLAYER_ARMOR_CALCULATION
) ELSE (
    REM Error handling
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
    GOTO :PE_EBS_BOSS
) ELSE (
    GOTO :ENEMY_ATTACK_CALCULATION
)

:ENEMY_ATTACK_CALCULATION
REM a number between 0 and 100 can be split 4 ways, two hits, a crit and a miss. Descending chance in that order. Slightly favored to miss compared to the Player.
SET /A PA=%RANDOM% %%100
IF %PA% GEQ 84 (
    REM Critical hit
    SET "displayMessage=%currentEnemy% got a critical hit."
    set /a player.health-=enemy.damage*2
    @REM SET /A player.health=!player.health! -%enemy.damage%*2
    GOTO :PE_EBS
) ELSE IF %PA% GEQ 31 (
    REM Normal Attack 2
    SET "displayMessage=The %currentEnemy% lands a solid strike on %player.name%."
    set /a player.health-=enemy.damage
    GOTO :PE_EBS
) ELSE IF %PA% LEQ 30 (
    REM Player attack misses.
    SET "displayMessage=The %currentEnemy% tripped on a pebble and missed."
    GOTO :PE_EBS
) ELSE (
    REM Error handling
)

:PE_EBS_BOSS
SET /A PA=%RANDOM% %%100
IF %PA% GEQ 70 (
    SET "displayMessage=Abyssal Guardian got a critical hit on %player.name%."
    set /a player.health-=enemy.damage*2
    GOTO :PE_EBS
) ELSE IF %PA% GEQ 15 (
    SET displayMessage=Abyssal Guardian managed a strike on %player.name%.
    set /a player.health-=enemy.damage
    GOTO :PE_EBS
) ELSE (
    SET "displayMessage=Abyssal Guardian missed %player.name% by mere inches."
    GOTO :PE_EBS
)

:PLAYER_ITEMS
SET "windhelm.inventory_call=combat"
CALL "%winLoc%\data\functions\Inventory Viewer.bat"
GOTO :PE_EBS

:VICTORY_STATS_TRACK
IF "%currentEnemy%" == "Bandit" (
    set /a player.bandits_slain+=1
    GOTO :VICTORY_TRACK_CLEARED
) ELSE IF "%currentEnemy%" == "AbyssalGuardian" (
    set /a player.iridescent_ab_defeated+=1
    SET player.pe_abgu_cleared=1
    GOTO :BOSS_DEFEAT_REWARDS
) ELSE (
    echo PULSE ENGINE: error on line 744
    pause
    exit /b
)

:VICTORY_TRACK_CLEARED
IF %IFOR.LEVEL1_SELECTED% EQU 1 (
    SET /A pulse.ifor_level_1_ecount=!pulse.ifor_level_1_ecount! -1
    GOTO :VICTORY_REWARDS
) ELSE IF %IFOR.LEVEL2_SELECTED% EQU 1 (
    SET /A pulse.ifor_level_1_ecount=!pulse.ifor_level_2_ecount! -1
    GOTO :VICTORY_REWARDS
) ELSE IF %IFOR.LEVEL3_SELECTED% EQU 1 (
    SET /A pulse.ifor_level_1_ecount=!pulse.ifor_level_3_ecount! -1
    GOTO :VICTORY_REWARDS
) ELSE IF %IFOR.LEVEL4_SELECTED% EQU 1 (
    SET /A pulse.ifor_level_1_ecount=!pulse.ifor_level_4_ecount! -1
    GOTO :VICTORY_REWARDS
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
    SET "player.message=This enemy was looted already."
    GOTO :VICTORY_SCREEN
) ELSE (
    IF %player.iridescent_ab_defeated% EQU 1 (
        SET "displayMessage=The great foe vanished upon defeat, nothing remains to pilfer."
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
    set /a player.coins+=CR
    @REM SET /A player.coins=!player.coins! +%CR%
    SET "player.message=You found %CR% LUNIS"
    GOTO :VICTORY_SCREEN
) ELSE IF %LT% LEQ 20 (
    SET enLooted=1
    SET /A CR=%RANDOM% * 32 / 32768 + 12
    set /a player.coins+=CR
    SET "player.message=You found %CR% LUNIS"
    GOTO :VICTORY_SCREEN
) ELSE IF %LT% LEQ 30 (
    SET enLooted=1
    set /a player.item_long_sword_owned+=1
    @REM SET /A player.item_long_sword_owned=!player.item_long_sword_owned! +1
    SET "player.message=You found a Long Sword."
    GOTO :VICTORY_SCREEN
) ELSE IF %LT% LEQ 40 (
    SET enLooted=1
    SET /A CR=%RANDOM% * 48 / 32768 + 21
    set /a player.coins+=CR
    set /a player.item_cactus_armor_owned+=1
    @REM SET /A player.item_cactus_armor_owned=!player.item_cactus_armor_owned! +1
    SET "player.message=You found %CR% LUNIS and 1 CACTUS ARMOR"
    GOTO :VICTORY_SCREEN
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

:error_CFSL
set "displayMessage=Error encountered. Cannot find selected level."
GOTO :%RETURN%

:CLEANUP
SET enLooted=0
SET enemy.damage=%enemy.damage_base%
GOTO :BATTLE_GLOBAL_RESET

:AUTOSAVE
SET "SLOPr=SAVE"
CALL "%winLoc%\data\functions\SLOP.bat"
GOTO :EOF