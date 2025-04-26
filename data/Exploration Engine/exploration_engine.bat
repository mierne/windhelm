@ECHO OFF
TITLE (WINDHELM) - EXPLORATION ENGINE ^| %player.name% the %player.race% %player.class%!

:MAIN
MODE con: cols=105 lines=17
SET RETURN=MAIN
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
    CALL "%winLoc%\data\Combat Engine\scripts\evie.bat"
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
        CALL "%winLoc%\data\Combat Engine\scripts\evie.bat"
    ) ELSE (
        SET displayMessage=Your level is too low for this encounter.
        GOTO :VENTURE_IRIDESCENT_FOREST
    )
)

:VENTURE_WINDHELM_EXTERIOR
MODE con: cols=105 lines=19
SET RETURN=VENTURE_WINDHELM_EXTERIOR
CLS
ECHO.
REM TYPE "%winLoc%\PATH\TO\ASCII\ART"
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
MODE con: cols=105 lines=19
SET RETURN=WE_TRAVELING_MERCHANT
SET displayMessage=...
CLS
ECHO.
REM TYPE "%winLoc%\PATH\TO\ASCII\ART"
ECHO.
ECHO You approach the merchant's wagon, which has been temporarily transformed into a market stall.
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player.health%/%player.health_max% ^| XP: %player.xp%/%player.xp_required% ^| LUNIS: %player.coins% ^| AT: %player.damage% ^| AM: %player.armor% ^| ST: %player.stamina% ^| MG: %player.magicka%
ECHO +-------------------------------------------------------------------------------------------------------+
ECHO ^| [1 / VIEW WARES ] ^| [Q / BACK ] ^| %displayMessage%
ECHO +-------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :TM_VIEW_ITEMS
IF /I "%CH%" == "Q" GOTO :MAIN
GOTO :INVALID_INPUT

:TM_VIEW_ITEMS
TITLE (Rockwinn Plaza) - Alchemist ^| %player.name% the %player.race% %player.class%
MODE con: cols=100 lines=22
SET RETURN=VENDOR_ALCHEMIST
ECHO.
TYPE "%cd%\data\assets\npcs\alchemist.txt"
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
        SET /A player.coins=!player.coins! -%vendor.travmrech_xp_tonic_price%
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

REM Save Player progress before quitting Exploration Engine.
:AUTOSAVE
SET SLOPr=save
CALL "%winLoc%\data\functions\SLOP.bat"
GOTO :EOF