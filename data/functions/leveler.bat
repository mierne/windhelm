REM Allows the Player to level up skills with skill points which are rewarded every X levels. (Undetermined as of now.)

:PLAYER_LEVEL_UP_LOGIC
IF %player.level% EQU 1 (
    REM Level two level up check & logic.
    IF %player.xp% GEQ 5000 (
        SET /A player.xp=!player.xp! -5000
        SET player.xp_required=10000
        SET /A player.level=!player.level! +1
        SET player.awarded_points=0
        SET displayMessage=Level up^! You've reached level two.
        GOTO :EOF
    ) ELSE (
        REM Level up not possible.
        SET displayMessage=Cannot level up.
        GOTO :EOF
    )
) ELSE IF %player.level% EQU 2 (
    REM Level three level up check & logic.
    IF %player.xp% GEQ 10000 (
        SET /A player.xp=!player.xp! -10000
        SET player.xp_required=12000
        SET /A player.level=!player.level! +1
        SET player.awarded_points=0
        SET displayMessage=Level up^! You've reached level three.
        GOTO :EOF
    ) ELSE (
        REM Level up not possible.
        SET displayMessage=Cannot level up.
        GOTO :EOF
    )
) ELSE IF %player.level% EQU 3 (
    REM Level three level up check & logic.
    IF %player.xp% GEQ 12000 (
        SET /A player.xp=!player.xp! -12000
        SET player.xp_required=14000
        SET /A player.level=!player.level! +1
        SET player.awarded_points=0
        SET displayMessage=Level up^! You've reached level four.
        GOTO :EOF
    ) ELSE (
        REM Level up not possible.
        SET displayMessage=Cannot level up.
        GOTO :EOF
    )
) ELSE IF %player.level% EQU 4 (
    REM Level three level up check & logic.
    IF %player.xp% GEQ 14000 (
        SET /A player.xp=!player.xp! -14000
        SET player.xp_required=16000
        SET /A player.level=!player.level! +1
        SET player.awarded_points=0
        SET displayMessage=Level up^! You've reached level five.
        GOTO :EOF
    ) ELSE (
        REM Level up not possible.
        GOTO :EOF
    )
) ELSE IF %player.level% EQU 5 (
    REM Level three level up check & logic.
    IF %player.xp% GEQ 16000 (
        SET /A player.xp=!player.xp! -16000
        SET player.xp_required=18000
        SET /A player.level=!player.level! +1
        SET player.awarded_points=0
        SET displayMessage=Level up^! You've reached level six.
        GOTO :EOF
    ) ELSE (
        REM Level up not possible.
        SET displayMessage=Cannot level up.
        GOTO :EOF
    )
) ELSE IF %player.level% EQU 6 (
    REM Level three level up check & logic.
    IF %player.xp% GEQ 18000 (
        SET /A player.xp=!player.xp! -18000
        SET player.xp_required=20000
        SET /A player.level=!player.level! +1
        SET player.awarded_points=0
        SET displayMessage=Level up^! You've reached level seven.
        GOTO :EOF
    ) ELSE (
        REM Level up not possible.
        SET displayMessage=Cannot level up.
        GOTO :EOF
    )
) ELSE IF %player.level% EQU 7 (
    REM Level three level up check & logic.
    IF %player.xp% GEQ 20000 (
        SET /A player.xp=!player.xp! -20000
        SET /A player.level=!player.level! +1
        SET player.awarded_points=0
        SET displayMessage=Level up^! You've reached level eight.
        GOTO :EOF
    ) ELSE (
        REM Level up not possible.
        SET displayMessage=Cannot level up.
        GOTO :EOF
    )
) ELSE IF %player.level% EQU 8 (
    REM Level three level up check & logic.
    IF %player.xp% GEQ 22000 (
        SET /A player.xp=!player.xp! -22000
        SET player.xp_required=22000
        SET /A player.level=!player.level! +1
        SET player.awarded_points=0
        SET displayMessage=Level up^! You've reached level nine.
        GOTO :EOF
    ) ELSE (
        REM Level up not possible.
        SET displayMessage=Cannot level up.
        GOTO :EOF
    )
) ELSE IF %player.level% EQU 9 (
    REM Level three level up check & logic.
    IF %player.xp% GEQ 24000 (
        SET /A player.xp=!player.xp! -24000
        SET player.xp_required=24000
        SET /A player.level=!player.level! +1
        SET player.awarded_points=0
        SET displayMessage=Level up^! You've reached level ten.
        GOTO :LEVEL_TEN_REWARD
    ) ELSE (
        REM Level up not possible.
        SET displayMessage=Cannot level up.
        GOTO :EOF
    )
)

:LEVEL_TEN_REWARD
SET player.level_up_points=4
GOTO :LEVEL_UP_SKILLS

REM Awards the player a set number of points and allows them to increase skills.
:LEVEL_UP_SKILLS
TITLE (Level Up) - Select skills to level up ^| %player_name% the %player_class%
MODE con: cols=114 lines=23
REM --
ECHO.
TYPE "%cd%\data\ascii\ui\levelup.txt"
ECHO.
ECHO.
ECHO Which skill would you like to improve? Each improvement costs 2 points.
ECHO %displayMessage%
ECHO +----------------------------------------------------------------------------------------------------------------+
ECHO ^| HP: %player_health% ^| STM: %player_stamina% ^| ATK: %player_damage% ^| AMR: %player_armor% ^| MGK: %player_magicka% ^| COINS: %player_coins% ^| XP: %player_xp% ^| LUNIS: %player_lunis%
ECHO +----------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE:  %player.skill_damage%,  COST:  6 LEVELS  ^| ATHLETICS: %player.skill_athletics%
ECHO ^| SPEECH:  %player.skill_speech%,  COST:  9 LEVELS  ^| INTELLIGENCE: %player.skill_intelligence%
ECHO ^| STAMINA: %player.skill_stamina%,  COST: 12 LEVELS ^|
ECHO ^| MAGICKA: %player.skill_magicka%,  COST: 20 LEVELS ^|
ECHO +----------------------------------------------------------------------------------------------------------------+
ECHO + [1 / IMPROVE DAMAGE ] ^| [2 / IMPROVE SPEECH ] ^| [3 / IMPROVE STAMINA ] ^| [4 / IMPROVE MAGICKA ] ^| [5 / IMPROVE ATHLETICS ] ^ [6 / IMPROVE INTELLIGENCE ] ^| [E / DONE ]
ECHO +----------------------------------------------------------------------------------------------------------------+
CHOICE /C 123456E /N /M ">"
IF ERRORLEVEL 7 GOTO :EOF
IF ERRORLEVEL 6 GOTO :SKILLS_IMPROVE_INTELLIGENCE
IF ERRORLEVEL 5 GOTO :SKILLS_IMPROVE_ATHLETICS
IF ERRORLEVEL 4 GOTO :SKILLS_IMPROVE_MAGICKA
IF ERRORLEVEL 3 GOTO :SKILLS_IMPROVE_STAMINA
IF ERRORLEVEL 2 GOTO :SKILLS_IMPROVE_SPEECH
IF ERRORLEVEL 1 GOTO :SKILLS_IMPROVE_DAMAGE

REM Attempt to improve the damage skill.
:SKILLS_IMPROVE_DAMAGE
IF %player.skill_damage% EQU 10 (
    REM This skill is at the maximum level.
    SET displayMessage=This skill is already at the maximum level^!
    GOTO :LEVEL_UP_SKILLS
) ELSE (
    REM Improve the skill level.
    IF %player.level_up_points% LSS %windhelm.damage_skill_base_cost_level% (
        REM Player does not have enough level up points for this.
        SET displayMessage=You do not have enough points for this.
        GOTO :LEVEL_UP_SKILLS
    ) ELSE (
        SET /A player.skill_damage=!player.skill_damage! +1
        SET /A player.level_up_points=!player.level_up_points! -1
        SET displayMessage=Increased damage skill by 1 for two points.
        GOTO :LEVEL_UP_SKILLS
    )
)

REM Attempt to improve the speech skill.
:SKILLS_IMPROVE_SPEECH
IF %player.skill_speech% EQU 10 (
    REM This skill is at the maximum level.
    SET displayMessage=This skill is already at the maximum level^!
    GOTO :LEVEL_UP_SKILLS
) ELSE (
    REM Improve the skill level.
    IF %player.level_up_points% LSS %windhelm.speech_skill_base_cost_level% (
        REM Player does not have enough level up points for this.
        SET displayMessage=You do not have enough points for this.
        GOTO :LEVEL_UP_SKILLS
    ) ELSE (
        SET /A player.skill_speech=!player.skill_speech! +1
        SET /A player.level_up_points=!player.level_up_points! -1
        SET displayMessage=Increased speech skill by 1 for two points.
        GOTO :LEVEL_UP_SKILLS
    )
)

REM Attempt to improve the stamina skill.
:SKILLS_IMPROVE_STAMINA
IF %player.skill_stamina% EQU 10 (
    REM This skill is at the maximum level.
    SET displayMessage=This skill is already at the maximum level^!
    GOTO :LEVEL_UP_SKILLS
) ELSE (
    REM Improve the skill level.
    IF %player.level_up_points% LSS %windhelm.damage_skill_base_cost_level% (
        REM Player does not have enough level up points for this.
        SET displayMessage=You do not have enough points for this.
        GOTO :LEVEL_UP_SKILLS
    ) ELSE (
        SET /A player.skill_stamina=!player.skill_stamina! +1
        SET /A player.level_up_points=!player.level_up_points! -1
        SET displayMessage=Increased stamina skill by 1 for two points.
        GOTO :LEVEL_UP_SKILLS
    )
)

REM Attempt to improve the magicka skill.
:SKILLS_IMPROVE_MAGICKA
IF %player.skill_magicka% EQU 10 (
    REM This skill is at the maximum level.
    SET displayMessage=This skill is already at the maximum level^!
    GOTO :LEVEL_UP_SKILLS
) ELSE (
    REM Improve the skill level.
    IF %player.level_up_points% LSS %windhelm.damage_skill_base_cost_level% (
        REM Player does not have enough level up points for this.
        SET displayMessage=You do not have enough points for this.
        GOTO :LEVEL_UP_SKILLS
    ) ELSE (
        SET /A player.skill_magicka=!player.skill_magicka! +1
        SET /A player.level_up_points=!player.level_up_points! -1
        SET displayMessage=Increased danage skill by 1 for two points.
        GOTO :LEVEL_UP_SKILLS
    )
)

REM Attempt to improve the Intelligence skill.
:SKILLS_IMPROVE_INTELLIGENCE
IF %player.skill_intelligence% EQU 10 (
    REM This skill is at the maximum level.
    SET displayMessage=This skill is already at the maximum level^!
    GOTO :LEVEL_UP_SKILLS
) ELSE (
    REM Improve the skill level.
    IF %player.level_up_points% LSS %windhelm.damage_skill_base_cost_level% (
        REM Player does not have enough level up points for this.
        SET displayMessage=You do not have enough points for this.
        GOTO :LEVEL_UP_SKILLS
    ) ELSE (
        SET /A player.skill_intelligence=!player.skill_intelligence! +1
        SET /A player.level_up_points=!player.level_up_points! -1
        SET displayMessage=Increased danage skill by 1 for two points.
        GOTO :LEVEL_UP_SKILLS
    )
)

REM Attempt to improve the Athletics skill.
:SKILLS_IMPROVE_ATHLETICS
IF %player.skill_athletics% EQU 10 (
    REM This skill is at the maximum level.
    SET displayMessage=This skill is already at the maximum level^!
    GOTO :LEVEL_UP_SKILLS
) ELSE (
    REM Improve the skill level.
    IF %player.level_up_points% LSS %windhelm.damage_skill_base_cost_level% (
        REM Player does not have enough level up points for this.
        SET displayMessage=You do not have enough points for this.
        GOTO :LEVEL_UP_SKILLS
    ) ELSE (
        SET /A player.skill_athletics=!player.skill_athletics! +1
        SET /A player.level_up_points=!player.level_up_points! -1
        SET displayMessage=Increased danage skill by 1 for two points.
        GOTO :LEVEL_UP_SKILLS
    )
)