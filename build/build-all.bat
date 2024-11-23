@echo off
set rom=%1
set configFile=%~dp0.\build-deps.ini

IF not exist "%rom%" goto :ERRrom

echo The following ROM '%rom%' will be patched...
CALL :FXApply %rom% %configFile%

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
set rom=%1
set config=%2

set currarea=
for /f "usebackq delims=" %%a in ("!config!") do (
    set ln=%%a
    if "x!ln:~0,1!"=="x[" (
        set currarea=!ln!
        IF !ERRORLEVEL! EQU 0 CALL :FXBuild !currarea:~1,-1! %rom%
    )
)
endlocal
exit /b %errorlevel%

:FXBuild
set patchName=%1
set rom=%2

CALL build.bat %patchName% %rom%

exit /b %errorlevel%

:ERRrom
echo You need to specify a ROM to apply the patches.
goto error

:error
exit /b 1

:end
exit /b %errorlevel%