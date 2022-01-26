@echo off
setlocal
set rom=%1
set patch=%2
set patchName=%3
set patcherUtil=%~dp0.\tools\asar\asar.exe
set patchesPath=%~dp0..\src\%patchName%\

IF not exist "%patcherUtil%" goto :ERRpatcher
IF not exist "%patchesPath%" goto :ERRpatches

CALL :FXPatch %rom% %patch% %patchesPath%
goto :end

:FXPatch
set rom=%1
set asm=%2
set path=%3

echo Applying %asm%
"%patcherUtil%" "%path%%asm%" "%rom%"

exit /b %errorlevel%

:ERRpatcher
echo ASM Patcher utility is missing. Is it there '%patcherUtil%'?
goto error

:ERRpatches
echo Path for the patches doesn't exist. Is this the good one '%patchesPath%'?
goto error

:error
exit /b 1

:end
exit /b %errorlevel%