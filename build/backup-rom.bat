@echo off
setlocal
set rom=%2
set patchName=%3
set tmpPath=%~dp0.\tmp\

IF not exist "%rom%" goto :ERRrom
IF "%patchName%" EQU "" goto :ERRpatch

set tmpRom=
CALL :FXCopy tmpRom %rom% %patchName% %tmpPath%

endlocal & set "%~1=%tmpRom%"
goto :end

:FXCopy
set src=%2
set ext=%~x2
set dest=%~n3
set tmp=%4
REM Stringify the current date and time into YYYY_MM_DD__HH_MM_SS
set dt=%DATE%__%TIME:~0,8%
set dt=%dt:-=_%
set dt=%dt::=_%
set dest=%tmp%%dest%_%dt%%ext%

IF not exist "%tmp%" mkdir "%tmp%"

echo Copying %src% into %tmp%
copy /y "%src%" "%dest%" >NUL
set "%~1=%dest%"

exit /b %errorlevel%

:ERRrom
echo You need to specify a ROM to backup.
goto error

:ERRpatch
echo You need to specify a patch name to name the backuped ROM after it.
goto error

:error
exit /b 1

:end
exit /b %errorlevel%