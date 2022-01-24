@echo off
set rom=%1
set patchName=01-worldmap
set tmpPath=%~dp0\tmp\
set tmpRom="%tmpPath%%patchName%%~x1"

IF not exist "%rom%" goto :ERRrom
IF not exist "%tmpPath%" mkdir "%tmpPath%"

REM Actually, the map editing is done with FF6Tools, so based on a already builded rom
REM CALL :FXBackup %rom%
REM IF %ERRORLEVEL% EQU 0 CALL 01-worldmap-ips.bat %tmpRom% %patchName%
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