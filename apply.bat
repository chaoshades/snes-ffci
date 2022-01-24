@echo off
set rom=%1
set dev=%2
set patcherUtil=%~dp0\build\tools\flips\flips.exe
set patchesPath=%~dp0\patches\
set patchedRom="%~dpn1-patched%~x1"

IF not exist "%patcherUtil%" goto :ERRpatcher
IF not exist "%patchesPath%" goto :ERRpatches
IF not exist "%rom%" goto :ERRrom
IF "%dev%" NEQ "" IF "%dev%" NEQ "dev" goto :ERRdev

CALL :FXBackup %rom% %patchedRom%
echo The following ROM '%patchedRom%' will be patched...
REM By the IPS dependency graph, only 08-events is needed because it contains everyone else
REM CALL :FXApply 01-worldmap.ips
REM CALL :FXApply 02-vehicles.ips
REM CALL :FXApply 04-monsters.ips
REM CALL :FXApply 06-characters.ips
CALL :FXApply 08-events.ips
IF "%dev%" EQU "dev" (
  echo Adding 'dev' patches...
  CALL :FXApply 99-devRoom.ips
)
IF %ERRORLEVEL% EQU 0 (
  echo ROM patched.
  @pause
  goto :end
) ELSE (
  echo ROM patching failed. See logs above for details.
  goto :error
)

:FXBackup
echo Copying %1 into %~p2
copy /y "%1" "%patchedRom%" >NUL
exit /b %errorlevel%

:FXApply
IF %ERRORLEVEL% EQU 0 (
  echo Applying %1
  "%patcherUtil%" "%patchesPath%%1" "%rom%"
)
exit /b %errorlevel%

:ERRpatcher
echo IPS Patcher utility is missing. Is it there '%patcherUtil%'?
goto error

:ERRpatches
echo Path for the patches doesn't exist. Is this the good one '%patchesPath%'?
goto error

:ERRrom
echo You need to specify a ROM to apply the patches.
goto error

:ERRdev
echo "dev" is the only supported option to apply 'dev' patches.
goto error

:error
exit /b 1

:end
exit /b %errorlevel%