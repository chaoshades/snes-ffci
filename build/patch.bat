@echo off
setlocal
set kind=%1
set rom=%2
set patchName=%3
set configFile=%4

IF "%kind%" NEQ "asm" IF "%kind%" NEQ "ips" goto :ERRkind
IF not exist "%rom%" goto :ERRrom
IF not exist "%configFile%" goto :ERRconfig
IF "%patchName%" EQU "" goto :ERRpatch

echo The following ROM '%rom%' will be patched...
CALL :FXApply %kind% %rom% %patchName% %configFile%

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
set patchName=%3
set config=%4

set area=[%patchName%]
set currarea=
for /f "usebackq delims=" %%a in ("!config!") do (
    set ln=%%a
    if "x!ln:~0,1!"=="x[" (
        set currarea=!ln!
    ) else (
        for /f "delims=" %%b in ("!ln!") do (
            set currkey=%%b
            if "x!area!"=="x!currarea!" (
                IF %ERRORLEVEL% EQU 0 CALL :FXPatch %kind% %rom% !currkey! %patchName%
            )
        )
    )
)
endlocal
exit /b %errorlevel%

:FXPatch
set kind=%1
set rom=%2
set patch=%3
set patchName=%4

CALL %kind%-patcher.bat %rom% %patch% %patchName%

exit /b %errorlevel%

:ERRkind
echo "asm" and "ips" are the only supported option to use patchers.
goto error

:ERRrom
echo You need to specify a ROM to apply the patches.
goto error

:ERRconfig
echo Build config file is missing. Is this the good one '%configFile%'?
goto error

:ERRpatch
echo You need to specify a patch name that represents the group in the config file.
goto error

:error
exit /b 1

:end
exit /b %errorlevel%