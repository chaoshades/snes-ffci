@echo off
setlocal
set rom=%1
set patch=%2
set patcherUtil=%~dp0.\tools\flips\flips.exe
set patchesPath=%~dp0..\patches\

IF not exist "%patcherUtil%" goto :ERRpatcher
IF not exist "%patchesPath%" goto :ERRpatches

CALL :FXPatch %rom% %patch% %patchesPath%
goto :end

:FXPatch
set rom=%1
set ips=%2
set path=%3

echo Applying %ips%
"%patcherUtil%" "%path%%ips%" "%rom%"

exit /b %errorlevel%

:ERRpatcher
echo IPS Patcher utility is missing. Is it there '%patcherUtil%'?
goto error

:ERRpatches
echo Path for the patches doesn't exist. Is this the good one '%patchesPath%'?
goto error

:error
exit /b 1

:end
exit /b %errorlevel%