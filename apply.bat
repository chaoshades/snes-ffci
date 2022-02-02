@echo off
set rom=%1
set dev=%2
set buildPath=%~dp0.\build\

IF not exist "%rom%" goto :ERRrom
IF "%dev%" NEQ "" IF "%dev%" NEQ "dev" goto :ERRdev

set patchedRom=
CALL :FXCopy patchedRom %rom%

echo The following ROM '%patchedRom%' will be patched...
CALL :FXApply %patchedRom% 01-worldmap.ips
CALL :FXApply %patchedRom% 02-vehicles.ips
CALL :FXApply %patchedRom% 04-monsters.ips
CALL :FXApply %patchedRom% 06-characters.ips
CALL :FXApply %patchedRom% 08-events.ips
IF "%dev%" EQU "dev" (
  echo Adding 'dev' patches...
  CALL :FXApply %patchedRom% 99-devRoom.ips
)
IF %ERRORLEVEL% EQU 0 (
  echo ROM patched.
  @pause
  goto :end
) ELSE (
  echo ROM patching failed. See logs above for details.
  goto :error
)

:FXCopy
set src=%2
set path=%~p2
set file=%~n2
set ext=%~x2
set dest=%file%-patched%ext%

echo Copying %src% into %path%
copy /y "%src%" "%dest%" >NUL
set "%~1=%dest%"

exit /b %errorlevel%

:FXApply
set rom=%1
set patch=%2

CALL %buildPath%ips-patcher.bat %rom% %patch%

exit /b %errorlevel%

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