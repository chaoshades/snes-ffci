@echo off
set rom=%1
set dev=%2
set configFile=%~dp0.\build-config-all.ini

IF not exist "%rom%" goto :ERRrom
IF "%dev%" NEQ "" IF "%dev%" NEQ "dev" goto :ERRdev

echo The following ROM '%rom%' will be patched...
CALL :FXApply default %rom% %configFile%

IF "%dev%" EQU "dev" (
  echo Adding 'dev' patches...
  CALL :FXApply dev %rom% %configFile%
)
IF %ERRORLEVEL% EQU 0 (
  echo ROM patched.
  @pause
  goto :end
) ELSE (
  echo ROM patching failed. See logs above for details.
  goto :error
)

:FXApply
setlocal enableextensions enabledelayedexpansion
set kind=%1
set rom=%2
set config=%3

set area=[%kind%]
set currarea=
for /f "usebackq delims=" %%a in ("!config!") do (
    set ln=%%a
    if "x!ln:~0,1!"=="x[" (
        set currarea=!ln!
    ) else (
        for /f "delims=" %%b in ("!ln!") do (
            set currkey=%%b
            if "x!area!"=="x!currarea!" (
                IF !ERRORLEVEL! EQU 0 CALL !currkey! %rom%
            )
        )
    )
)
endlocal
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