@echo off
set rom=%1
set patchName=02-vehicles
set tmpPath=%~dp0\tmp\
set tmpRom="%tmpPath%%patchName%%~x1"

IF not exist "%rom%" goto :ERRrom
IF not exist "%tmpPath%" mkdir "%tmpPath%"

CALL :FXBackup %rom%
IF %ERRORLEVEL% EQU 0 CALL 02-vehicles-asm.bat %tmpRom% %patchName%
IF %ERRORLEVEL% EQU 0 CALL build-ips.bat %rom% %tmpRom% %patchName%
goto :end

:FXBackup
echo Copying %1 into %tmpPath%
copy /y "%1" "%tmpRom%" >NUL
exit /b %errorlevel%

:ERRrom
echo You need to specify a ROM to apply the patches.
goto error

:error
exit /b 1

:end
exit /b %errorlevel%