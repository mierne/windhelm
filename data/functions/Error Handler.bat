IF %errorType% == sublevel (
    GOTO :errorType_SUBLEVEL
) ELSE IF %errorType% == areazone (
    GOTO :errorType_AREAZONE
) ELSE (
    GOTO :errorType_ERRORHANDLER
)

:errorType_SUBLEVEL
CLS
ECHO.
ECHO Windhelm has encountered an error. The following information is known:
ECHO    Calling Script: %callingScript%
ECHO    Caused By: %errorCause%
ECHO    On line: %scriptLine%
ECHO What can you do?:
ECHO There is likely nothing the user can do to fix this issue. Please open an issue on the GitHub page.
PAUSE
EXIT

:errorType_AREAZONE
CLS
ECHO.
ECHO Windhelm has encountered an error. The following information is known:
ECHO    Calling Script: %callingScript%
ECHO    Caused By: %errorCause%
ECHO    On line: %scriptLine%
ECHO What can you do?:
ECHO There is likely nothing the user can do to fix this issue. Please open an issue on the GitHub page.
PAUSE
EXIT

:errorType_ERRORHANDLER
CLS
ECHO.
ECHO Windhelm has encountered an error. The following information is known:
ECHO    Calling Script: Error Handler.bat
ECHO    Caused By: Invalid errorType string
ECHO What can you do?:
ECHO There is likely nothing the user can do to fix this issue. Please open an issue on the GitHub page.
PAUSE
EXIT