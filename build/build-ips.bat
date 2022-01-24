@echo off
setlocal
set rom=%1
set tmpRom=%2
set patchName=%3
set patcherUtil=%~dp0\tools\flips\flips.exe
set patchesPath=%~dp0..\patches\

IF not exist "%patcherUtil%" goto :ERRpatcher
IF not exist "%patchesPath%" goto :ERRpatches
IF not exist "%rom%" goto :ERRrom
IF not exist "%tmpRom%" goto :ERRrom
IF "%patchName%" EQU "" goto :ERRpatch

echo The unmodified ROM '%rom%' will be used for patch creation...
CALL :FXCreate %patchName%.ips
IF %ERRORLEVEL% EQU 0 (
  echo IPS patch created.
  @pause
  goto :end
) ELSE (
  echo IPS patch creation failed. See logs above for details.
  goto :error
)

:FXCreate
echo Creating %1 from modified ROM %tmpRom%
"%patcherUtil%" "%rom%" "%tmpRom%" "%patchesPath%%1"
exit /b %errorlevel%

:ERRpatcher
echo IPS Patcher utility is missing. Is it there '%patcherUtil%'?
goto error

:ERRpatches
echo Path for the patches doesn't exist. Is this the good one '%patchesPath%'?
goto error

:ERRrom
echo You need to specify the original ROM and hacked ROM to create the patches.
goto error

:ERRpatch
echo You need to specify a patch name to create it.
goto error

:error
exit /b 1

:end
exit /b 0