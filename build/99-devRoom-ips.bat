@echo off
setlocal
set rom=%1
set patcherUtil=%~dp0\tools\flips\flips.exe
set patchesPath=%~dp0..\patches\

IF not exist "%patcherUtil%" goto :ERRpatcher
IF not exist "%patchesPath%" goto :ERRpatches
IF not exist "%rom%" goto :ERRrom

echo The following ROM '%rom%' will be patched...
CALL :FXApply 08-events.ips
IF %ERRORLEVEL% EQU 0 (
  echo ROM patched.
  @pause
  goto :end
) ELSE (
  echo ROM patching failed. See logs above for details.
  goto :error
)

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

:error
exit /b 1

:end
exit /b %errorlevel%