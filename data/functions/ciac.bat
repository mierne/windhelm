TITLE (WINDHELM) Intro - Character Creator

REM Check for existing Player data.
:CFEPD
IF EXIST "%cd%\data\player\savedata.txt" (
    GOTO :overwrite_saveQ
) ELSE (
    GOTO :ENTER_NAME
)

REM Warns the Player that an existing save has been found and asks if they wish to overwrite it.
:overwrite_saveQ
MODE con: cols=97 lines=14
SET "RETURN=overwrite_saveQ"
CLS
ECHO.
TYPE "%cd%\data\assets\ui\overwrite_save.txt"
ECHO.
ECHO.
ECHO WARNING! An existing save has been detected. Do you wish to overwrite this existing save?
ECHO +-----------------------------------------------------------------------------------------------+
SET /P "CH=Y/N: "
IF /I "%CH%" == "Y" GOTO :ENTER_NAME
IF /I "%CH%" == "N" GOTO :NO_OVERWRITE
GOTO :INVALID_INPUT

REM Do not overwrite an existing save.
:NO_OVERWRITE
SET OSQ=1
GOTO :EOF

:ENTER_NAME
MODE con: cols=120 lines=13
SET OSQ=0
CLS
ECHO.
TYPE "%cd%\data\assets\ui\your_name.txt"
ECHO.
ECHO.
ECHO What do you wish to be called?
ECHO +----------------------------------------------------------------------------------------------------------------------+
SET /P "player.name="
GOTO :CHOOSE_RACE

:CHOOSE_RACE
MODE con: cols=120 lines=17
SET "SLOPr=INIT"
SET "RETURN=CHOOSE_RACE"
CLS
ECHO.
TYPE "%cd%\data\assets\ui\race.txt"
ECHO.
ECHO Choose a race for %player.name%. Select a race to learn more about it.
ECHO Specific races will be unable to access certain storylines or characters.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [1] Human  : Tall, fair skinned people native to the plains of Fulkwinn. Most common.
ECHO ^| [2] Alnfei : Shorter on average compared to humans, Alnfei are native to the dense forests of Fulkwinn.
ECHO +----------------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "1" GOTO :MORE_HUMAN
IF /I "%CH%" == "2" GOTO :MORE_ALNFEI
GOTO :INVALID_INPUT

:MORE_HUMAN
MODE con: cols=120 lines=20
SET "RETURN=MORE_HUMAN"
CLS
ECHO.
TYPE "%cd%\data\assets\ui\human.txt"
ECHO.
ECHO Choose the HUMAN race?
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| Humans are a race of tall, fair-skinned people that have settled in Fulkwinn for hundreds of years.
ECHO ^| Their origin has been lost to time and their true origin is unknown.
ECHO ^| Humans are particularly skilled in warfare, having been at war for almost their entire existence in some manner.
ECHO ^| As a result, they've grown particularly hardy.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| +50 to starting HEALTH.
ECHO ^| +2 to starting DAMAGE skill.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO [1 / CHOOSE ] ^| [Q / BACK ]
SET /P "CH=> "
IF /I "%CH%" == "1" GOTO :SELECT_HUMAN_RACE
IF /I "%CH%" == "E" GOTO :CHOOSE_RACE
GOTO :INVALID_INPUT

:SELECT_HUMAN_RACE
SET "player.race=Human"
GOTO :CHOOSE_CLASS

:MORE_ALNFEI
MODE con: cols=120 lines=18
SET "RETURN=MORE_ALNFEI"
CLS
ECHO.
TYPE "%cd%\data\assets\ui\frawen.txt"
ECHO.
ECHO Choose the FRAWEN race?
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| The Alnfei are the ancient natives of the Fulkwinn forests. How long they've been there is unknown.
ECHO ^| They're shorter on average compared with humans, have slightly pointed ears and vastly superior night vision.
ECHO ^| They have intimate knowledge of the forests and geography of Fulkwinn, using it to stay hidden.
ECHO ^| Alnfei are rarely seen in human settlements outside of the iridescent forest.
ECHO ^| As a result of their deep connection with nature, they are naturally very skilled with druidic magics.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| +2 to starting INTELLIGENCE skill.
echo ^| +100 to magicka.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO [1 / CHOOSE ] ^| [Q / BACK ]
SET /P "CH=> "
IF /I "%CH%" == "1" GOTO :SELECT_ALNFEI_RACE
IF /I "%CH%" == "E" GOTO :CHOOSE_RACE
GOTO :INVALID_INPUT

:SELECT_ALNFEI_RACE
SET "player.race=Alnfei"
GOTO :CHOOSE_CLASS

:CHOOSE_CLASS
MODE con: cols=120 lines=19
SET "RETURN=CHOOSE_CLASS"
CLS
ECHO.
TYPE "%cd%\data\assets\ui\your_class.txt"
ECHO.
ECHO Choose a class for %player.name%. Select a class to learn more.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [1] Sorcerer : Born to a wealthy family, a shard lost to the winds.
ECHO ^| [2] Warrior  : A shard formed in battle, many scars remain.
ECHO ^| [3] Druid    : A deep connection severed, shattered.
ECHO +----------------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "1" GOTO :SORCERER_CHOSEN_PREVIEW
IF /I "%CH%" == "2" GOTO :WARRIOR_CHOSEN_PREVIEW
IF /I "%CH%" == "3" GOTO :DRUID_CHOSEN_PREVIEW
GOTO :INVALID_INPUT

:DRUID_CHOSEN_PREVIEW
MODE con: cols=125 lines=20
SET "RETURN=DRUID_CHOSEN_PREVIEW"
CLS
ECHO.
TYPE "%cd%\data\assets\ui\druid.txt"
ECHO.
ECHO.
ECHO Choose the DRUID class?
ECHO +---------------------------------------------------------------------------------------------------------------------------+
ECHO ^| Druids are powerful mages who devote their life to nature. Due to their strong relationship with the Goddess of Nature,
ECHO ^| Druids are granted +100 MAGICKA, however the devotion costs them -30 HEALTH.
ECHO ^| Starting stats: HEALTH: 70 ^| MAGICKA: 200
ECHO ^| Starting skills: DAMAGE: 2 ^| SPEECH: 2 ^| ATHLETICS: 2 ^| INTELLIGENCE: 7
ECHO ^| Starting magic skills: ALTERATION: 4 ^| DESTRUCTION: 4 ^| RESTORATION: 4
ECHO +---------------------------------------------------------------------------------------------------------------------------+
ECHO [1 / CHOOSE ] ^| [Q / BACK]
SET /P "CH=> "
IF /I "%CH%" == "1" GOTO :DRUID_CHOSEN
IF /I "%CH%" == "E" GOTO :CHOOSE_CLASS
GOTO :INVALID_INPUT

:WARRIOR_CHOSEN_PREVIEW
MODE con: cols=120 lines=21
SET "RETURN=WARRIOR_CHOSEN_PREVIEW"
CLS
ECHO.
TYPE "%cd%\data\assets\ui\warrior.txt"
ECHO.
ECHO.
ECHO Choose the WARRIOR class?
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| Warriors have spent most of their lives training for combat and as a result start with increased HEALTH and DAMAGE.
ECHO ^| Warriors are granted +60 HEALTH. Warriors also start with a higher DAMAGE skill stat.
ECHO ^| Their strong devotion to their Gods lowers their MAGICKA by 70.
ECHO ^| Starting stats: HEALTH: 160 ^| MAGICKA: 30
ECHO ^| Starting skills: DAMAGE: 6 ^| SPEECH: 2 ^| ATHLETICS: 4 ^| INTELLIGENCE: 2
ECHO ^| Starting magic skills: ALTERATION: 2 ^| DESTRUCTION: 2 ^| RESTORATION: 2
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO [1 / CHOOSE ] ^| [Q / BACK]
SET /P "CH=> "
IF /I "%CH%" == "1" GOTO :WARRIOR_CHOSEN
IF /I "%CH%" == "E" GOTO :CHOOSE_CLASS
GOTO :INVALID_INPUT

:SORCERER_CHOSEN_PREVIEW
MODE con: cols=123 lines=21
SET "RETURN=SORCERER_CHOSEN_PREVIEW"
CLS
ECHO.
TYPE "%cd%\data\assets\ui\sorcerer.txt"
ECHO.
ECHO.
ECHO Choose the SORCERER class?
ECHO +-------------------------------------------------------------------------------------------------------------------------+
ECHO ^| Sorcerers are born with a strong connection to the magical world and as a result start with increased MAGICKA.
ECHO ^| Sorcerers are granted +100 MAGICKA. Their devotion has cost them 25 HEALTH. Sorcerer's start with slightly above average
ECHO ^| magicka.
ECHO ^| Starting stats: HEALTH: 100 ^| MAGICKA: 200
ECHO ^| Starting skills: DAMAGE: 2 ^| SPEECH: 5 ^| ATHLETICS: 2  ^| INTELLIGENCE: 5
ECHO ^| Starting magica skills: ALTERATION: 5 ^| DESTRUCTION: 5 ^| RESTORATION: 5
ECHO +-------------------------------------------------------------------------------------------------------------------------+
ECHO [1 / CHOOSE ] ^| [Q / BACK]
SET /P "CH=> "
IF /I "%CH%" == "1" GOTO :SORCERER_CHOSEN
IF /I "%CH%" == "E" GOTO :CHOOSE_CLASS
GOTO :INVALID_INPUT

:DRUID_CHOSEN
SET player.health=70
SET player.health_max=70
SET player.magicka=200
SET player.magicka_max=200
set player.skill_damage=2
set player.skill_speech=2
set player.skill_athletics=2
set player.skill_intelligence=7
set player.skill_destruction=4
set player.skill_restoration=4
SET "player.class=Druid"
SET "player.class_ability=precognition"
SET player.item_wooden_bow_owned=1
GOTO :APPLY_RACE_BONUSES

:WARRIOR_CHOSEN
SET player.health=160
SET player.health_max=160
SET player.magicka=30
SET player.magicka_max=30
set player.skill_damage=6
set player.skill_speech=2
set player.skill_athletics=4
set player.skill_intelligence=2
set player.skill_destruction=2
set player.skill_restoration=2
SET "player.class=Warrior"
SET "player.class_ability=rage"
SET player.item_short_sword_owned=1
GOTO :APPLY_RACE_BONUSES

:SORCERER_CHOSEN
SET player.health=100
SET player.health_max=100
SET player.magicka=200
SET player.magicka_max=200
set player.skill_damage=2
set player.skill_speech=5
set player.skill_athletics=2
set player.skill_intelligence=5
set player.skill_destruction=5
set player.skill_restoration=5
SET "player.class=Sorcerer"
SET "player.class_ability=sapping"
SET player.item_short_sword_owned=1
GOTO :APPLY_RACE_BONUSES

REM Applies health and other skill bonuses.
:APPLY_RACE_BONUSES
IF "%player.race%" == "Human" (
    GOTO :APPLY_RACE_BONUS_HUMAN
) else if "%player.race%" == "Alnfei" (
    goto :APPLY_RACE_BONUS_ALNFEI
) else (
    rem How'd you manage this?
    echo Windhelm has encountered an error.
    echo CIAC.bat: line 255
    echo %player.race% was unexpected.
    pause
    exit
)

:APPLY_RACE_BONUS_HUMAN
set /a player.health_max+=20
set player.health=%player.health_max%
set /a player.skill_damage+=2
GOTO :CHOOSE_ORIGIN

:APPLY_RACE_BONUS_ALNFEI
set /a player.health_max+=10
set player.health=%player.health_max%
set /a player.skill_intelligence+=2
set /a player.magicka_max+=100
set /a player.magicka=%player.magicka_max%
GOTO :CHOOSE_ORIGIN

REM Allows the Player to choose an origin for their character. In the future this will determine endings available to the Player.
:CHOOSE_ORIGIN
MODE con: cols=120 lines=16
SET "RETURN=CHOOSE_ORIGIN"
CLS
ECHO.
TYPE "%cd%\data\assets\ui\origin.txt"
ECHO.
ECHO Choose an origin for %player.name%. Select an origin to learn more about it.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [1] Forest Origin  : You've awoken in a forest clearing, head pounding and no memories.
ECHO ^| [2] Cabin Origin   : You're startled by a distant howl. Sitting up you find yourself alone in an abandoned cabin.
ECHO ^| [3] Inn Origin     : You've come to on a bed in a local inn. You're unsure of how you got here.
ECHO +----------------------------------------------------------------------------------------------------------------------+
SET /P "CH=> "
IF /I "%CH%" == "1" GOTO :VIEW_FOREST_ORIGIN
IF /I "%CH%" == "2" GOTO :VIEW_CABIN_ORIGIN
IF /I "%CH%" == "3" GOTO :VIEW_INN_ORIGIN
GOTO :INVALID_INPUT


:VIEW_FOREST_ORIGIN
MODE con: cols=120 lines=23
SET "RETURN=VIEW_FOREST_ORIGIN"
CLS
ECHO.
TYPE "%cd%\data\assets\ui\origin.txt"
ECHO.
ECHO.
ECHO Choose the FOREST origin? NOTE: Origins impact the starting max value of your skills and available endings.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| As you come to, your head pounding, you notice a strange ever present feeling. It was if a part of you was missing.
ECHO ^| You attempt to sit up, though your attempt was thwarted by the pain from your pounding head. You instead elect
ECHO ^| to take in your surroundings from where you lie. The soft warm glow of the sun, the gentle rays peering through
ECHO ^| the leaves told you that it must be sometime early in the morning. You lay there for what felt like hours until the
ECHO ^| pounding began to subside. This is when another realization hit you, you do not recall who you are. The only
ECHO ^| memories are fading, and quick. You grab onto one before it slips away. Your name. Your name is %player.name%.
ECHO ^|
ECHO ^| The 'Forest Origin' provides the Player with +2 to INTELLIGENCE.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO [1 / PROCEED TO WINDHELM... ] ^| [Q / BACK]
SET /P "CH=> "
IF /I "%CH%" == "1" GOTO :FOREST_ORIGIN_SELECTED
IF /I "%CH%" == "E" GOTO :CHOOSE_ORIGIN
GOTO :INVALID_INPUT

:VIEW_CABIN_ORIGIN
MODE con: cols=120 lines=22
SET "RETURN=VIEW_CABIN_ORIGIN"
CLS
ECHO.
TYPE "%cd%\data\assets\ui\origin.txt"
ECHO.
ECHO.
ECHO Choose the CABIN origin? NOTE: Origins impact the starting max value of your skills and available endings.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| You're awkoen by a distant, fading howl. You sit up in a hurry, wide awake now. You soon realize you're surrounded
ECHO ^| by the comforting walls of an old abandoned cabin. You're unsure of how you got here or even who you are.
ECHO ^| Your memories are vague, more feelings than actual memories. You try to hold on but they slip through your fingers.
ECHO ^| Only a faint, distant pain remains. Before it all slipped away, however, you managed to cling to one thing.
ECHO ^| Your name. Your name is %player.name%.
ECHO ^|
ECHO ^| The 'Cabin Origin' provides the Player with +2 to DAMAGE.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO [1 / PROCEED TO WINDHELM... ] ^| [Q / BACK]
SET /P "CH=> "
IF /I "%CH%" == "1" GOTO :CABIN_ORIGIN_SELECTED
IF /I "%CH%" == "E" GOTO :CHOOSE_ORIGIN
GOTO :INVALID_INPUT

:VIEW_INN_ORIGIN
MODE con: cols=120 lines=22
SET "RETURN=VIEW_INN_ORIGIN"
CLS
ECHO.
TYPE "%cd%\data\assets\ui\origin.txt"
ECHO.
ECHO.
ECHO Choose the INN origin? NOTE: Origins impact the starting max value of your skills and available endings.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| You awaken on an uncomfortable, hard surface. Sitting up and gathering your bearings you conlcude you find yourself
ECHO ^| in an Inn, though you are unsure of which or even where it is. Feeling the weightlessness of your pockets you
ECHO ^| assume your silver tongue landed you the miserable spot which you slept. You think to yourself you should leave
ECHO ^| sooner rather than later. Before you're able to take a single step you realize something. You have no idea who you
ECHO ^| are. The only thing that remains is.. Your name. Your name is %player.name%.
ECHO ^|
ECHO ^| The 'Inn Origin' provides the Player with +2 to SPEECH.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO [1 / PROCEED TO WINDHELM... ] ^| [Q / BACK]
SET /P "CH=> "
IF /I "%CH%" == "1" GOTO :INN_ORIGIN_SELECTED
IF /I "%CH%" == "E" GOTO :CHOOSE_ORIGIN
GOTO :INVALID_INPUT

:FOREST_ORIGIN_SELECTED
set /a player.skill_intelligence+=2
set "player.origin=Forest Origin"
goto :SAVE_DATA

:CABIN_ORIGIN_SELECTED
set /a player.skill_damage+=2
set "player.origin=Cabin Origin"
goto :SAVE_DATA

:INN_ORIGIN_SELECTED
set /a player.skill_speech+=2
set "player.origin=Inn Origin"
goto :SAVE_DATA

:INVALID_INPUT
ECHO "%CH%" is not a valid input.
PAUSE
GOTO :%RETURN%

REM Saves data and exits.
:SAVE_DATA
SET "displayMessage=..."
SET "SLOPr=SAVE"
CALL "%cd%\data\functions\SLOP.bat"
GOTO :EOF