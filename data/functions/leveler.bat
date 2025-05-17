REM Allows the Player to level up skills with skill points which are rewarded every X levels. (Undetermined as of now.)

REM Set skill level costs
IF %player.level% EQU 5 (
    REM Adjust skill level costs.
    SET /A windhelm.skill_damage_level_cost=!windhelm.skill_damage_level_cost! +4
    SET /A windhelm.skill_speech_level_cost=!windhelm.skill_speech_level_cost! +4
    SET /A windhelm.skill_athletics_level_cost=!windhelm.skill_athletics_level_cost! +4
    SET /A windhelm.skill_intelligence_level_cost=!windhelm.skill_intelligence_level_cost! +4
    SET /A windhelm.skill_destruction_level_cost=!windhelm.skill_destruction_level_cost! +4
    SET /A windhelm.skill_restoration_level_cost=!windhelm.skill_restoration_level_cost! +4
) ELSE IF %player.level% EQU 10 (
    SET /A windhelm.skill_damage_level_cost=!windhelm.skill_damage_level_cost! +4
    SET /A windhelm.skill_speech_level_cost=!windhelm.skill_speech_level_cost! +4
    SET /A windhelm.skill_athletics_level_cost=!windhelm.skill_athletics_level_cost! +4
    SET /A windhelm.skill_intelligence_level_cost=!windhelm.skill_intelligence_level_cost! +4
    SET /A windhelm.skill_destruction_level_cost=!windhelm.skill_destruction_level_cost! +4
    SET /A windhelm.skill_restoration_level_cost=!windhelm.skill_restoration_level_cost! +4
) ELSE (
    REM Player level not within defined requirements.
    GOTO :PLAYER_LEVEL_UP_LOGIC
)

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
        GOTO :LEVEL_FIVE_REWARD
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
        SET player.xp_required=35000
        SET /A player.level=!player.level! +1
        SET player.awarded_points=0
        SET displayMessage=Level up^! You've reached level ten.
        GOTO :LEVEL_TEN_REWARD
    ) ELSE (
        REM Level up not possible.
        SET displayMessage=Cannot level up.
        GOTO :EOF
    ) 
) ELSE IF %player.level% EQU 10 (
    IF %player.xp% GEQ 35000 (
        SET /A player.xp=!player.xp! -35000
        SET player.xp_required=60000
        SET /A player.level=!player.level! +1
        SET player.awarded_points=0
        SET displayMessage=Level up^! You've reached level 11.
        GOTO :EOF
    ) ELSE (
        SET displayMessage=Cannot level up.
        GOTO :EOF
    )
) ELSE IF %player.level% EQU 11 (
    IF %player.xp% GEQ 60000 (
        SET /A player.xp=!player.xp! -60000
        SET player.xp_required=120000
        SET /A player.level=!player.level! +1
        SET player.awarded_points=0
        SET displayMessage=Level up^! You've reached level 12.
    ) ELSE (
        SET displayMessage=Cannot level up.
        GOTO :EOF
    )
) ELSE IF %player.level% EQU 12 (
    SET displayMessage=You've reached the maximum level.
    GOTO :EOF
) ELSE (
    REM Error
    ECHO LEVELER.BAT has encountered an error.
    PAUSE
    EXIT /B
)

:LEVEL_FIVE_REWARD
SET player.level_up_points=6
GOTO :SKILL_POINT_COSTS_SCALER

:LEVEL_TEN_REWARD
SET player.level_up_points=12
GOTO :SKILL_POINT_COSTS_SCALER

:SKILL_POINT_COSTS_SCALER


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
ECHO ^| HP: %player.health% ^| ATK: %player.damage% ^| DEF: %player.armor% ^| MGK: %player.magicka% ^| LUNIS: %player.coins% ^| XP: %player.xp%/%player.xp_required%
ECHO +----------------------------------------------------------------------------------------------------------------+
ECHO ^| DAMAGE:  %player.skill_damage%,  COST: %windhelm.skill_damage_level_cost% ^| ATHLETICS: %player.skill_athletics%, COST: %windhelm.skill_athletics_level_cost%
ECHO ^| SPEECH:  %player.skill_speech%,  COST: %windhelm.skill_speech_level_cost%^| INTELLIGENCE: %player.skill_intelligence%, COST: %windhelm.skill_intelligence_level_cost%
ECHO ^| DESTRUCTION: %player.skill_destruction%, COST: %windhelm.skill_destruction_level_cost% ^| RESTORATION: %player.skill_restoration%, COST: %windhelm.skill_restoration_level_cost%
ECHO +----------------------------------------------------------------------------------------------------------------+
ECHO + [1 / DAMAGE ] ^| [2 / SPEECH ] ^| [3 / DESTRUCTION ] ^| [ 4 / RESTORATION ] ^| [5 / ATHLETICS ]
ECHO + [6 / INTELLIGENCE ] ^| [Q / DONE ]
ECHO +----------------------------------------------------------------------------------------------------------------+
SET /P CH=">"
IF /I "%CH%" == "1" GOTO :SKILLS_IMPROVE_DAMAGE
IF /I "%CH%" == "2" GOTO :SKILLS_IMPROVE_SPEECH
IF /I "%CH%" == "3" GOTO :SKILLS_IMPROVE_DESTRUCTIOIN
IF /I "%CH%" == "4" GOTO :SKILLS_IMPROVE_RESTORATION
IF /I "%CH%" == "5" GOTO :SKILLS_IMPROVE_ATHLETICS
IF /I "%CH%" == "6" GOTO :SKILLS_IMPROVE_INTELLIGENCE
IF /I "%CH%" == "Q" GOTO :AUTOSAVE

REM Attempt to improve the damage skill.
:SKILLS_IMPROVE_DAMAGE
IF %player.skill_damage% EQU 10 (
    REM This skill is at the maximum level.
    SET displayMessage=This skill is already at the maximum level^!
    GOTO :LEVEL_UP_SKILLS
) ELSE (
    REM Improve the skill level.
    IF %player.level_up_points% LSS %windhelm.skill_damage_level_cost% (
        REM Player does not have enough level up points for this.
        SET displayMessage=You do not have enough points for this.
        GOTO :LEVEL_UP_SKILLS
    ) ELSE (
        SET /A player.skill_damage=!player.skill_damage! +1
        SET /A player.level_up_points=!player.level_up_points! -%windhelm.skill_damage_level_cost%
        SET displayMessage=Increased damage skill by 1 for %windhelm.skill_damage_level_cost% points.
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
    IF %player.level_up_points% LSS %windhelm.skill_speech_level_cost% (
        REM Player does not have enough level up points for this.
        SET displayMessage=You do not have enough points for this.
        GOTO :LEVEL_UP_SKILLS
    ) ELSE (
        SET /A player.skill_speech=!player.skill_speech! +1
        SET /A player.level_up_points=!player.level_up_points! -%windhelm.skill_speech_level_cost%
        SET displayMessage=Increased speech skill by 1 for %windhelm.skill_speech_level_cost% points.
        GOTO :LEVEL_UP_SKILLS
    )
)

:SKILLS_IMPROVE_DESTRUCTIOIN
IF %player.skill_destruction% EQU 10 (
    SET displayMessage=This skill is already at the maximum level^!
    GOTO :LEVEL_UP_SKILLS
) ELSE (
    IF %player.level_up_points% LSS %windhelm.skill_destruction_level_cost% (
        SET displayMessage=You do not have enough points.
        GOTO :LEVEL_UP_SKILLS
    ) ELSE (
        SET /A player.skill_destruction=!player.skill_destruction! +1
        SET /A player.level_up_points=!player.level_up_points! -%windhelm.skill_destruction_level_cost%
        SET displayMessage=Increased 'Destruction' skill by +1 for %windhelm.skill_destruction_level_cost% points.
        GOTO :LEVEL_UP_SKILLS
    )
)

:SKILLS_IMPROVE_RESTORATION
IF %player.skill_restoration% EQU 10 (
    SET displayMessage=This skill is already at the maximum level^!
    GOTO :LEVEL_UP_SKILLS
) ELSE (
    IF %player.level_up_points% LSS %windhelm.skill_restoration_level_cost% (
        SET displayMessage=You do not have enough points.
        GOTO :LEVEL_UP_SKILLS
    ) ELSE (
        SET /A player.skill_restoration=!player.skill_restoration! +1
        SET /A player.level_up_points=!player.level_up_points! -%windhelm.skill_restoration_level_cost%
        SET displayMessage=Increased 'Restoration' skill by +1 for %windhelm.skill_restoration_level_cost% points.
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
    IF %player.level_up_points% LSS %windhelm.skill_intelligence_level_cost% (
        REM Player does not have enough level up points for this.
        SET displayMessage=You do not have enough points for this.
        GOTO :LEVEL_UP_SKILLS
    ) ELSE (
        SET /A player.skill_intelligence=!player.skill_intelligence! +1
        SET /A player.level_up_points=!player.level_up_points! -%windhelm.skill_intelligence_level_cost
        SET displayMessage=Increased 'Intelligence' skill by +1 for %windhelm.skill_intelligence_level_cost% points.
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
    IF %player.level_up_points% LSS %windhelm.skill_athletics_level_cost% (
        REM Player does not have enough level up points for this.
        SET displayMessage=You do not have enough points for this.
        GOTO :LEVEL_UP_SKILLS
    ) ELSE (
        SET /A player.skill_athletics=!player.skill_athletics! +1
        SET /A player.level_up_points=!player.level_up_points! -%windhelm.skill_athletics_level_cost%
        SET displayMessage=Increased 'Athletics' skill by +1 for %windhelm.skill_athletics_level_cost% points.
        GOTO :LEVEL_UP_SKILLS
    )
)

:AUTOSAVE
SET SLOPr=SAVE
CALL "%winLoc%\data\functions\SLOP.bat"
GOTO :EOF