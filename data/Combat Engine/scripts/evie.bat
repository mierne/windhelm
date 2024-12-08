TITLE (WINDHELM) - EVIe

REM Every enemy excluding the iBandit is disabled for testing.
SET player_levelup_notif=.
SET player.info=...
SET player.damage_dealt=...
SET enemy.damage_dealt=...

REM Below is a list of Variables, each list pertains to a specific enemy.
REM Global Variables
SET player.armor_calculated=0
SET enLooted=0

REM BANDIT VARIABLES
SET bandit.health=100
SET bandit.damage_base=14
SET bandit.damage=14
SET bandit.weak_to_weakness=False

REM JESTER VARIABLES
REM SET iJesterHP=125
REM SET iJesterAT_b=22
REM SET iJesterAT=22
REM SET iJesterWK=False

REM GNOME VARIABLES
REM SET iGnomeHP=75
REM SET iGnomeAT_b=28
REM SET iGnomeAT=28
REM SET iGnomeWK=True

REM JESTER COOLDOWNS
REM Jester "Joke" attack, dealing multiplied damage.
REM SET iJesterJK=6

REM HUNTER VARIABLES
REM SET iHunterHP=115
REM SET iHunterAT_b=20
REM SET iHunterAT=20
REM SET iHunterWK=False

REM GOBLIN VARIABLES
REM SET iGoblinHP=60
REM SET iGoblinAT_b=16
REM SET iGoblinAT=16
REM SET iGoblinWK=False
REM GNOME COOLDOWNS
REM Gnome "Poke" Attack, dealing multiplied damage.
REM SET iGnomePA=4
REM Default Action points for debugging
REM SET pAP=10

REM GOLEM VARIABLES
REM SET iGolemHP=90
REM SET iGolemAT_b=20
REM SET iGolemAT=20
REM SET iGolemMGK=0
REM SET iGolemWK=False

REM Testing
REM SET curEn=%currentEnemy%
REM SET enemy.health=%iBanditHP%
REM SET enemy.damage=%iBanditAT%
REM SET enemy.damage_normal=%enemy.damage_base%
REM SET enemy.stamina=%iBanditSTM%
REM SET enemy.stamina_cost=%iBanditSTMC%
REM GOTO :combat_engine

REM Assigns the dynamic enemy variable with the values of specific enemies.
SET curEn=%currentEnemy%
IF %curEn% == iBandit (
    SET enemy.health=%bandit.health%
    SET enemy.damage=%bandit.damage%
    SET enemy.damage_base=%bandit.damage_base%
    SET enemy.weak_to_weakness=%iBanditWK%
    SET curEn=Bandit
    GOTO :combat_engine
) ELSE IF %curEn% == iJester (
    SET enemy.health=%iJesterHP%
    SET enemy.damage=%iJesterAT%
    SET enemy.damageb=%iJesterAT_b%
    SET enemy.weaken_res=%iJesterWK%
    SET enemy.stamina=%iJesterSTM%
    SET enemy.stamina_cost=%iJesterSTMC%
    SET curEn=Jester
    GOTO :combat_engine
) ELSE IF %curEn% == iGnome (
    SET enemy.health=%iGnomeHP%
    SET enemy.damage=%iGnomeAT%
    SET enemy.damageb=%iGnomeAT_b%
    SET enemy.weaken_res=%iGnomeWK%
    SET enemy.stamina=%iGnomeSTM%
    SET enemy.stamina_cost=%iGnomeSTMC%
    SET curEn=Gnome
    GOTO :combat_engine
) ELSE IF %curEn% == iHunter (
    SET enemy.health=%iHunterHP%
    SET enemy.damage=%iHunterAT%
    SET enemy.damageb=%iHunterAT_b%
    SET enemy.weaken_res=%iHunterWK%
    SET enemy.stamina=%iHunterSTM%
    SET enemy.stamina_cost=%iHunterSTMC%
    SET curEn=Hunter
    GOTO :combat_engine
) ELSE IF %curEn% == iGoblin (
    SET enemy.health=%iGoblinHP%
    SET enemy.damage=%iGoblinAT%
    SET enemy.damageb=%iGoblinAT_b%
    SET enemy.weaken_res=%iGoblinWK%
    SET enemy.stamina=%iGoblinSTM%
    SET enemy.stamina_cost=%iGoblinSTMC%
    SET curEn=Goblin
    GOTO :combat_engine
) ELSE IF %curEn% == iGolem (
    SET enemy.health=%iGolemHP%
    SET enemy.damage=%iGolemAT%
    SET enemy.damageb=%iGolemAT_b%
    SET enemy.weaken_res=%iGolemWK%
    SET enemy.stamina=%iGolemSTM%
    SET enemy.stamina_cost=%iGolemSTMC%
    SET enMGK=%iGolemMGK%
    GOTO :combat_engine
) ELSE (
    REM Error handling.
    ECHO Enemy type unavailable. >> EV-ERROR.log
    SET errorType=EnemyType
    CALL "%cd%\data\functions\Error Handler.bat"
    EXIT /B
)

REM Call Combat Engine
:combat_engine
CALL "%cd%\data\Combat Engine\Combat Engine.bat"
REM Reset Window size
MODE con: cols=120 lines=20
GOTO :EOF