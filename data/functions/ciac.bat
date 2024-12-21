TITLE (WINDHELM) - CHOMP Character Creator
REM CHOMP - Character Hatching Origin Making Program

REM COMPAT FOR PRONOUN CHANGE FEATURE.
IF %player.pronouns_change_req% == 1 (
    GOTO :CHOOSE_PRONOUN
) ELSE (
    GOTO :CFEPD
)

@REM :SELF_INIT
@REM SET SLOPr=INIT
@REM CALL "%cd%\data\functions\SLOP.bat"
@REM GOTO :CFEPD

REM Check for existing Player data.
:CFEPD
IF EXIST "%cd%\data\player\savedata.txt" (
    GOTO :overwrite_saveQ
) ELSE (
    GOTO :ENTER_NAME
)

REM Warns the Player that an existing save has been found and asks if they wish to overwrite it.
:overwrite_saveQ
MODE con: cols=95 lines=20
CLS
ECHO.
TYPE "%cd%\data\assets\ui\overwrite_save.txt"
ECHO.
ECHO.
ECHO WARNING! An existing save has been detected. Do you wish to overwrite this existing save?
ECHO +---------------------------------------------------------------------------------------------+
CHOICE /C YN /N /M "Y/N"
IF ERRORLEVEL 2 GOTO :NO_OVERWRITE
IF ERRORLEVEL 1 GOTO :ENTER_NAME

REM Do not overwrite an existing save.
:NO_OVERWRITE
SET OSQ=1
GOTO :EOF

:ENTER_NAME
MODE con: cols=120 lines=22
SET OSQ=0
CLS
ECHO.
TYPE "%cd%\data\assets\ui\your_name.txt"
ECHO.
ECHO.
ECHO What do you wish to be called?
ECHO +----------------------------------------------------------------------------------------------------------------------+
SET /P player.name=
GOTO :CHOOSE_PRONOUN

:CHOOSE_PRONOUN
MODE con: cols=120 lines=20
CLS
ECHO.
TYPE "%cd%\data\assets\ui\pronouns.txt"
ECHO.
ECHO.
ECHO How do you wish others to refer to you?
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [T] THEY/THEM/THEIRS
ECHO ^| [S] SHE/HER/HERS
ECHO ^| [H] HE/HIM/HIS
ECHO ^| [C] CUSTOM SELECTION
ECHO +----------------------------------------------------------------------------------------------------------------------+
CHOICE /C CHST /N /M ">"
IF ERRORLEVEL 4 GOTO :THT
IF ERRORLEVEL 3 GOTO :SHH
IF ERRORLEVEL 2 GOTO :HHH
IF ERRORLEVEL 1 GOTO :CUSTOM_P_PERSONAL

:THT
SET player.personal_p_1=they
SET player.personal_p_2=them
SET player.possesive_1=theirs
SET player.reflexive_1=themself
set player.intensive_1=themself
IF %player.pronouns_change_req% == 1 GOTO :EOF
GOTO :CHOOSE_RACE

:SHH
SET player.personal_p_1=she
SET player.personal_p_2=her
SET player.possesive_1=hers
SET player.reflexive_1=herself
set player.intensive_1=herself
IF %player.pronouns_change_req% == 1 GOTO :EOF
GOTO :CHOOSE_RACE

:HHH
SET player.personal_p_1=he
SET player.personal_p_2=him
SET player.possesive_1=his
SET player.reflexive_1=himself
set player.intensive_1=himself
IF %player.pronouns_change_req% == 1 GOTO :EOF
GOTO :CHOOSE_RACE

REM Custom Pronoun selection
:CUSTOM_P_PERSONAL
CLS
ECHO.
TYPE "%cd%\data\assets\ui\pronouns.txt"
ECHO.
ECHO.
ECHO Custom Pronouns
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| Enter a PERSONAL pronoun. EXAMPLE: SHE/HER, HE/HIM, THEY/THEM, IT/ITS
ECHO ^| Please enter one half of your desired set, you will be asked for the second half next.
ECHO +----------------------------------------------------------------------------------------------------------------------+
SET /P player.personal_p_1=
GOTO :CHOOSE_P_PERSONAL_2

:CHOOSE_P_PERSONAL_2
CLS
ECHO.
TYPE "%cd%\data\assets\ui\pronouns.txt"
ECHO.
ECHO.
ECHO Custom Pronouns / 2
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| Enter a PERSONAL pronoun. EXAMPLE: SHE/HER, HE/HIM, THEY/THEM, IT/ITS
ECHO +----------------------------------------------------------------------------------------------------------------------+
SET /P player.personal_p_2=
GOTO :CHOOSE_P_POSSESIVE

:CHOOSE_P_POSSESIVE
CLS
ECHO.
TYPE "%cd%\data\assets\ui\pronouns.txt"
ECHO.
ECHO.
ECHO Custom Pronouns
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| Enter a POSSESIVE pronoun. EXAMPLE: HERS, HIS, THEIRS, ITS
ECHO +----------------------------------------------------------------------------------------------------------------------+
SET /P player.possesive_1=
GOTO :CHOOSE_P_REFLEXIVE_1

:CHOOSE_P_REFLEXIVE_1
CLS
ECHO.
TYPE "%cd%\data\assets\ui\pronouns.txt"
ECHO.
ECHO.
ECHO Custom Pronouns
ECHO This set covers Reflexive and Intensive pronouns.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| Enter a REFLEXIVE and INTENSIVE pronoun. EXAMPLE: HERSELF, HIMSELF, THEMSELF, ITSELF
ECHO +----------------------------------------------------------------------------------------------------------------------+
SET /P player.reflexive_1=
IF %player.pronouns_change_req% EQU 1 GOTO :EOF
GOTO :CHOOSE_RACE

:CHOOSE_RACE
MODE con: cols=120 lines=20
SET SLOPr=INIT
CLS
ECHO.
TYPE "%cd%\data\assets\ui\your_race.txt"
ECHO.
ECHO Choose a race for %player.name%. Select a race to learn more.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [1] Human  : Tall, fair skinned people native to the plains of Fulkwinn.
ECHO ^| [2] Fael   : Short, stalky people native to the Dredge.
ECHO ^| [3] Frawen : Tall with sharp, pointy ears, these people are native to the forests of Fulkwinn.
ECHO ^| [4] Nemmar : Cat-like people, native to the warm climates of Valar.
ECHO +----------------------------------------------------------------------------------------------------------------------+
CHOICE /C 1234 /N /M ">"
IF ERRORLEVEl 4 GOTO :MORE_NEMMAR
IF ERRORLEVEl 3 GOTO :MORE_FRAWEN
IF ERRORLEVEL 2 GOTO :MORE_FAEL
IF ERRORLEVEL 1 GOTO :MORE_HUMAN

:MORE_HUMAN
REM MODE con: cols=125 lines=22
CLS
ECHO.
TYPE "%cd%\data\assets\ui\human.txt"
ECHO.
ECHO Choose the HUMAN race?
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| Humans, a race of tall, fair-skinned are a people who have settled in most places in NAME-IN-PROGRESS, though
ECHO ^| they are native to the northern lands of Fulkwinn. A strong and intelligent people, 
ECHO ^| humans have enjoyed ruling most of NIP for most of their civilized existence.
ECHO ^| This RACE gets the following bonuses:
ECHO ^| +50 to starting HEALTH.
ECHO ^| +2 to starting DAMAGE skill.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO [1 / CHOOSE ] ^| [Q / BACK ]
CHOICE /C 1Q /N /M ">"
IF ERRORLEVEL 2 GOTO :CHOOSE_RACE
IF ERRORLEVEL 1 GOTO :SELECT_HUMAN_RACE

:SELECT_HUMAN_RACE
SET player.race=human
GOTO :CHOOSE_CLASS

:MORE_FAEL
CLS
ECHO.
TYPE "%cd%\data\assets\ui\human.txt"
ECHO.
ECHO Choose the FAEL race?
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| The Fael are a short, stalky people native to the deep caves of the Drudge. They're renowned for their blacksmith
ECHO ^| legends and strength of their tools and armors. They've remained mostly uninvolved in the politics on the surface.
ECHO ^| SKILL TO BOOST UNDETERMINED
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO [1 / CHOOSE ] ^| [Q / BACK ]
CHOICE /C 1Q /N /M ">"
IF ERRORLEVEL 2 GOTO :CHOOSE_RACE
IF ERRORLEVEL 1 GOTO :SELECT_FAEL_RACE

:SELECT_FAEL_RACE
SET player.race=fael
GOTO :CHOOSE_RACE

:MORE_FRAWEN
CLS
ECHO.
TYPE "%cd%\data\assets\ui\human.txt"
ECHO.
ECHO Choose the FRAWEN race?
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| The Frawen are tall with sharp, pointy ears and reside almost exclusively inside of the Iridescent Forest
ECHO ^| surrounding Windhelm. Their knowledge of the forests makes them excellent at moving quickly and quietly.
ECHO ^| Their time in the forest has also been a boon to their intelligence.
ECHO ^| +2 to starting INTELLIGENCE skill.
ECHO ^| +50 to starting STAMINA.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO [1 / CHOOSE ] ^| [Q / BACK ]
CHOICE /C 1Q /N /M ">"
IF ERRORLEVEL 2 GOTO :CHOOSE_RACE
IF ERRORLEVEL 1 GOTO :SELECT_FRAWEN_RACE

:SELECT_FRAWEN_RACE
SET player.race=frawen
GOTO :CHOOSE_CLASS

:MORE_NEMMAR
CLS
ECHO.
TYPE "%cd%\data\assets\ui\human.txt"
ECHO.
ECHO Choose the HUMAN race?
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| The Nemmar are a cat-like people with strong eyesight, powerful smell and sharp claws. They're native to warmer
ECHO ^| climates and thus a rare sight so far north in Windhelm.
ECHO ^| +2 to starting DAMAGE skill.
ECHO ^| +50 to starting HEALTH.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO [1 / CHOOSE ] ^| [Q / BACK ]
CHOICE /C 1Q /N /M ">"
IF ERRORLEVEL 2 GOTO :CHOOSE_RACE
IF ERRORLEVEL 1 GOTO :SELECT_NEMMAR_RACE

:SELECT_NEMMAR_RACE
SET player.race=nemmar
GOTO :CHOOSE_CLASS

:CHOOSE_CLASS
MODE con: cols=120 lines=20
CLS
ECHO.
TYPE "%cd%\data\assets\ui\your_class.txt"
ECHO.
ECHO Choose a class for %player.name%. Select a class to learn more.
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| [S] Sorcerer : Born to a family of poor Sorcerers, lost to the winds.
ECHO ^| [W] Warrior  : A shard formed in battle, many scars remain.
ECHO ^| [D] Druid    : Their greatest distraction will be their downfall.
ECHO +----------------------------------------------------------------------------------------------------------------------+
CHOICE /C SWD /N /M ">"
IF ERRORLEVEL 3 GOTO :DRUID_CHOSEN_PREVIEW
IF ERRORLEVEL 2 GOTO :WARRIOR_CHOSEN_PREVIEW
IF ERRORLEVEL 1 GOTO :SORCERER_CHOSEN_PREVIEW
GOTO :CHOOSE_CLASS

:DRUID_CHOSEN_PREVIEW
MODE con: cols=125 lines=22
CLS
ECHO.
TYPE "%cd%\data\assets\ui\druid.txt"
ECHO.
ECHO.
ECHO Choose the DRUID class?
ECHO +---------------------------------------------------------------------------------------------------------------------------+
ECHO ^| Druids are powerful mages who devote their life to nature. Due to their strong relationship with the Goddess of Nature,
ECHO ^| Druids are granted +100 MAGICKA, however the devotion costs them -30 HEALTH.
ECHO ^| Starting stats: HEALTH: 70 ^| STAMINA: 100 ^| MAGICKA: 200
ECHO ^| Starting skills: DAMAGE: 2 ^| STAMINA: 2   ^| MAGICKA 6 ^| SPEECH: 2 ^| ATHLETICS: 2 ^| REFLEX: 2 ^| INTELLIGENCE: 2
ECHO ^| Starting magic skills: ALTERATION: 6 ^| DESTRUCTION: 2     ^| RESTORATION: 6
ECHO ^| Other: REPUTATION: 2 ^| FACTION: Association Druider
ECHO +---------------------------------------------------------------------------------------------------------------------------+
ECHO [1 / CHOOSE ] ^| [Q / BACK]
CHOICE /C 1Q /N /M ">"
IF ERRORLEVEL 2 GOTO :CHOOSE_CLASS
IF ERRORLEVEL 1 GOTO :DRUID_CHOSEN
GOTO :CHOOSE_CLASS

:WARRIOR_CHOSEN_PREVIEW
MODE con: cols=120 lines=23
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
ECHO ^| Starting stats: HEALTH: 160 ^| STAMINA: 100 ^| MAGICKA: 30
ECHO ^| Starting skills: DAMAGE: 6  ^| STAMINA: 2   ^| MAGICKA: 2
ECHO ^| Starting magic skills: ALTERATION: 2 ^| DESTRUCTION: 2 ^| RESTORATION: 2
ECHO ^| Other: REPUTATION: 2 ^| FACTION: Silver Sliver's Guild
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO [1 / CHOOSE ] ^| [Q / BACK]
CHOICE /C 1Q /N /M ">"
IF ERRORLEVEL 2 GOTO :CHOOSE_CLASS
IF ERRORLEVEL 1 GOTO :WARRIOR_CHOSEN
GOTO :CHOOSE_CLASS

:SORCERER_CHOSEN_PREVIEW
MODE con: cols=120 lines=24
CLS
ECHO.
TYPE "%cd%\data\assets\ui\sorcerer.txt"
ECHO.
ECHO.
ECHO Choose the SORCERER class?
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO ^| Sorcerers are born with a strong connection to the magical world and as a result start with increased MAGICKA.
ECHO ^| Sorcerers are granted +100 MAGICKA. Their devotion has cost them 50 STAMINA. Druids also start with higher average
ECHO ^| magical skills than others.
ECHO ^| Starting stats: HEALTH: 100 ^| STAMINA: 50 ^| MAGICKA: 200
ECHO ^| Starting skills: DAMAGE: 2  ^| STAMINA: 2  ^| MAGICKA: 6
ECHO ^| Starting magica skills: ALTERATION: 12 ^| DESTRUCTION: 8 ^| RESTORATION: 12
ECHO ^| Other: REPUTATION: 2 ^| FACTION: Sorcerers Guild
ECHO +----------------------------------------------------------------------------------------------------------------------+
ECHO [1 / CHOOSE ] ^| [Q / BACK]
CHOICE /C 1Q /N /M ">"
IF ERRORLEVEL 2 GOTO :CHOOSE_CLASS
IF ERRORLEVEL 1 GOTO :SORCERER_CHOSEN
GOTO :CHOOSE_CLASS

:DRUID_CHOSEN
SET player.health=70
SET player.health_max=70
SET player.magicka=200
SET player.magicka_max=200
SET player.magicka_skill=6
SET player.magicSchool_AlterationSkill=6
SET player.magicSchool_DestructionSkill=2
SET player.magicSchool_RestorationSkill=6
SET player.class=Druid
SET player.class_ability=precognition
SET player.faction=Association Druider
SET player.factionRelations_AssociationDruider=40
GOTO :APPLY_RACE_BONUSES

:WARRIOR_CHOSEN
SET player.health=160
SET player.health_max=160
SET player.magicka=30
SET player.magicka_max=30
SET player.skill_athletics=6
SET player.skill_damage=6
SET player.magicSchool_AlterationSkill=2
SET player.magicSchool_DestructionSkill=2
SET player.magicSchool_RestorationSkill=2
SET player.class=Warrior
SET player.class_ability=rage
SET player.faction=Silver Slivers Guild
SET player.factionRelations_SilverSliversGuild=40
GOTO :APPLY_RACE_BONUSES

:SORCERER_CHOSEN
SET player.health=100
SET player.health_max=100
SET player.magicka=150
SET player.magicka_max=150
SET player.stamina=50
SET player.stamina_max=50
SET player.magicka_skill=6
SET player.magicSchool_AlterationSkill=12
SET player.magicSchool_DestructionSkill=8
SET player.magicSchool_RestorationSkill=12
SET player.class=Sorcerer
SET player.class_ability=sapping
SET player.faction=Sorcerers Guild
SET player.factionRelations_SorcerersGuild=40
GOTO :APPLY_RACE_BONUSES

REM Applies health and other skill bonuses.
:APPLY_RACE_BONUSES
IF %player.race% == human (
    GOTO :APPLY_RACE_BONUS_HUMAN
) ELSE IF %player.race% == "fael" (
    GOTO :APPLY_RACE_BONUS_FAEL
) ELSE IF %player.race% == "frawen" (
    GOTO :APPLY_RACE_BONUS_FRAWEN
) ELSE IF %player.race% == "nemmar" (
    GOTO :APPLY_RACE_BONUS_NEMMAR
)

REM More weird, inconsist batch behavior! Regardless of DELAYEDEXPANSION, SET /A simply does not work in this script. I have no idea why. It baffles me.
:APPLY_RACE_BONUS_HUMAN
SET /A player.health_max=!player.health_max! +50
SET player.health=%player.health_max%
SET /A player.skill_damage=!player.skill_damage! +2
GOTO :SAVE_DATA

:APPLY_RACE_BONUS_FAEL
GOTO :SAVE_DATA

:APPLY_RACE_BONUS_FRAWEN
SET /A player.health=!player.health_max! +50
SET player.health=!player.health_max!
SET /A player.skill_intelligence=!player.skill_intelligence! +2
GOTO :SAVE_DATA

:APPLY_RACE_BONUS_NEMMAR
SET /A player.health=!player.health! +50
SET player.health=!player.health_max!
SET /A player.skill_damage=!player.skill_damage! +2
GOTO :SAVE_DATA

REM Saves data and exits.
:SAVE_DATA
SET SLOPr=SAVE
CALL "%cd%\data\functions\SLOP.bat"
GOTO :EOF