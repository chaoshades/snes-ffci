@echo off
set rom=%1
set dev=%2

IF not exist "%rom%" goto :ERRrom
IF "%dev%" NEQ "" IF "%dev%" NEQ "dev" goto :ERRdev

echo The following ROM '%rom%' will be patched...
CALL 01-worldmap.bat %rom%
CALL 02-vehicles.bat %rom%
CALL 04-monsters.bat %rom%
CALL 06-characters.bat %rom%
CALL 08-events.bat %rom%
IF "%dev%" EQU "dev" (
  echo Adding 'dev' patches...
  CALL 99-devRoom.bat %rom%
)
IF %ERRORLEVEL% EQU 0 (
  echo ROM patched.
  @pause
  goto :end
) ELSE (
  echo ROM patching failed. See logs above for details.
  goto :error
)

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