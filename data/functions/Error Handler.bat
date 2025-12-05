REM Just handling the errors!

REM Check error type
IF %errorType% == EnemyType (
    GOTO :errorType_enemy
) ELSE IF %errorType% == checkTime (
    GOTO :errorType_checkTime
) ELSE IF %errorType% == attributeSkill (
    GOTO :errorType_attributeSkill
) ELSE IF %errorType% == encounterError (
    GOTO :errorType_encounterError
) ELSE IF %errorType% == LastLocal (
    GOTO :errorType_lastLocal
) ELSE IF %errorType% == invalidString (
    GOTO :errorType_invalidString
) ELSE (
    REM ...an error, inside of Error Handler??? Unthinkable!
    SET errorType=unknownError
    ECHO Error handler encountered an unhandled error. Check for logs from other scripts! >> ErrorHandler.log
    EXIT
)

REM Display the "Enemy Type" error.
:errorType_enemy
ECHO 

CLS
ECHO.
ECHO ERROR! Error Type: EnemyType.
ECHO =============================
ECHO This could mean:
ECHO The "currentEnemy" variable was left blank, or is unrecognized.
PAUSE
EXIT

REM Display the "Attribute - Skill" error.
:errorType_attributeSkill
CLS
ECHO.
ECHO ERROR! Error Type: attributeSkill.
ECHO Wuh-oh, Windhelm ran into a problem and can't continue!
ECHO What'd you do this time?
ECHO =======================================================
ECHO This error could mean:
ECHO The Player has modified their save, attempting to adjust Skill Levels to an undefined integer.
ECHO This... this is the only way to cause this error. Stop messing with my shit!
PAUSE
EXIT

:errorType_encounterError
CLS
ECHO.
ECHO Error Encountered - Windhelm has stopped.
ECHO Error Type: %errorType%
ECHO =======================================================
ECHO This could be caused by a corrupted script or save file.
ECHO If this repeats, email nope@donotemailme.fuckoff.com
PAUSE
EXIT

:errorType_lastLocal
CLS
ECHO.
ECHO Error Encountered - Windhelm has stopped.
ECHO Error Type: %errorType%
echo %ll%
ECHO =======================================================
ECHO Corrupted or modified save file.
ECHO If this repeats, email nope@donotemailme.fuckoff.com
PAUSE
EXIT

:errorType_checkTime
ECHO checkTime error. SLoP could not determine where to go.
PAUSE
EXIT

:errorType_invalidString
ECHO Combat Engine.bat: LINE %errorLineCE%. errorType? %errorType%. Occured on %DATE%,%TIME%. Critical? Yes. >> winLog.txt
EXIT