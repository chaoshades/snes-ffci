@echo off
set rom=%1
set dev=%2
set buildPath=%~dp0.\build\
set configFile=%~dp0.\apply-config.ini
set depsConfigFile=%buildPath%\build-deps.ini

IF not exist "%rom%" goto :ERRrom
IF "%dev%" NEQ "" IF "%dev%" NEQ "-dev" goto :ERRdev

echo The following ROM '%rom%' will be patched...
CALL :FXApply default %rom% %configFile%

IF %ERRORLEVEL% EQU 0 (
  IF "%dev%" EQU "-dev" (
    echo Adding 'dev' patches...
    CALL :FXApply dev %rom% %configFile%
  )
)
IF %ERRORLEVEL% EQU 0 (
  goto :end
) ELSE (
  goto :error
)

:FXCopy
set src=%2
set suffix=%3
IF "%suffix%" EQU "" set suffix=patched
set path=%~p2
set file=%~n2
set ext=%~x2
set dest=%file%-%suffix%%ext%

echo Copying %src% into %path%
copy /y "%src%" "%dest%" >NUL
set "%~1=%dest%"

exit /b %errorlevel%

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
                IF !ERRORLEVEL! EQU 0 CALL :FXPatch %rom% !currkey!
            )
        )
    )
)
endlocal
exit /b %errorlevel%

:FXPatch
set rom=%1
set patch=%2

set depRom=
CALL :FXCopy depRom %rom% deps-%patch%
CALL %buildPath%build-deps.bat !depRom! %patch% %depsConfigFile%

exit /b %errorlevel%

:ERRrom
echo You need to specify a ROM to apply the patches.
goto error

:ERRdev
echo "-dev" is the only supported option to apply 'dev' patches.
goto error

:error
exit /b 1

:end
exit /b %errorlevel%