REM ANI_TRAVEL -- Animated travel transition between zones and rooms
REM Revision 0
@ECHO OFF
MODE con: cols=50 lines=23
TITLE (WINDHELM) - Traveling...
SET LOOP=0

:FRAME_1
CLS
IF %LOOP% GEQ 4 GOTO :EOF
SET /A LOOP=%LOOP% +1
ECHO Traveling...
TYPE "%winLoc%\data\assets\ui\animated\frames\t_frame2.txt"
CSCRIPT //NOLOGO %wait% %windhelm.transition_delay%

:FRAME_2
TYPE "%winLoc%\data\assets\ui\animated\frames\t_frame1.txt"
CSCRIPT //NOLOGO %wait% %windhelm.transition_delay%

:FRAME_3
TYPE "%winLoc%\data\assets\ui\animated\frames\t_frame2.txt"
CSCRIPT //NOLOGO %wait% %windhelm.transition_delay%
GOTO :FRAME_1