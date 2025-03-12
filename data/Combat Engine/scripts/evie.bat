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
SET bandit.health=100
SET bandit.stamina=100
SET bandit.magicka=100
SET bandit.damage=14
SET bandit.damage_type_resistance=physical
SET bandit.damage_resisted=0

REM Abyssal Guardian Information
SET abyssal_guardian.health=250
SET abyssal_guardian.stamina=200
SET abyssal_guardian.magicka=400
SET abyssal_guardian.damage=20
SET abyssal_guardian.special_damage=45
SET abyssal_guardian.damage_type_resistance=physical
SET abyssal_guardian.damage_resisted=12
SET abyssal_guardian.special_name=The Dark Lurketh

:ENCOUNTER
IF "%currentEnemy%" == "Bandit" (
    SET enemy.health=%bandit.health%
    SET enemy.stamina=%bandit.stamina%
    SET enemy.magicka=%bandit.magicka%
    SET enemy.damage=%bandit.damage%
    SET enemy.damage_type_resistance=%bandit.damage_type_resistance%
    SET enemy.damage_resisted=%bandit.damage_resisted%
    SET enemy.damage_base=%bandit.damage%
    SET ce.boss_active=0
    SET curEn=Bandit
    GOTO :combat_engine
) ELSE IF "%currentEnemy%" == "Abyssal Guardian" (
    SET enemy.health=%abyssal_guardian.health%
    SET enemy.stamina=%abyssal_guardian.stamina%
    SET enemy.magicka=%abyssal_guardian.magicka%
    SET enemy.damage=%abyssal_guardian.damage%
    SET enemy.damage_base=%abyssal_guardian.damage%
    SET enemy.special_damage==%abyssal_guardian.special_damage%
    SET enemy.damage_type_resistance=%abyssal_guardian.damage_type_resistance%
    SET enemy.damage_resisted=%abyssal_guardian.damage_resisted%
    SET enemy.special_name==%abyssal_guardian.special_name%
    SET ce.boss_active=1
    SET curEn=Abyssal Guardian
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