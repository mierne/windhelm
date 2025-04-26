TITLE (WINDHELM) - EVIe

SET player_levelup_notif=.
SET player.info=...
SET player.damage_dealt=...
SET enemy.damage_dealt=...
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

:ENCOUNTER
IF "%currentEnemy%" == "Bandit" (
    SET enemy.health=%bandit.health%
    SET enemy.magicka=%bandit.magicka%
    SET enemy.damage=%bandit.damage%
    SET enemy.damage_type_resistance=%bandit.damage_type_resistance%
    SET enemy.damage_resisted=%bandit.damage_resisted%
    SET enemy.damage_base=%bandit.damage%
    SET ce.boss_active=0
    SET curEn=Bandit
    GOTO :combat_engine
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
    GOTO :combat_engine
) ELSE (
    REM Error handling.
    ECHO Enemy type unavailable. >> EV-ERROR.log
    SET errorType=EnemyType
    CALL "%winLoc%\data\functions\Error Handler.bat"
    EXIT /B
)

REM Call Combat Engine
:combat_engine
CALL "%winLoc%\data\Combat Engine\Combat Engine.bat"
REM Reset Window size
MODE con: cols=120 lines=20
GOTO :EOF