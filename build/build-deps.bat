@echo off
setlocal
set rom=%1
set patchName=%2
set configFile=%3

IF not exist "%rom%" goto :ERRrom
IF not exist "%configFile%" goto :ERRconfig
IF "%patchName%" EQU "" goto :ERRpatch

echo Building dependencies for '%patchName%' ...
echo The following ROM '%rom%' will be patched...
CALL :FXApply %rom% %patchName% %configFile%

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
set patchName=%2
set config=%3

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
                IF !ERRORLEVEL! EQU 0 CALL :FXPatch %rom% !currkey!.ips
            )
        )
    )
)
endlocal
exit /b %errorlevel%

:FXPatch
set rom=%1
set patch=%2

CALL ips-patcher.bat %rom% %patch%

exit /b %errorlevel%

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