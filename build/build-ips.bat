@echo off
setlocal
set origRom=%1
set hackedRom=%2
set patchName=%3
set tmpPath=%~dp0..\patches\tmp\

IF not exist "%origRom%" goto :ERRrom
IF not exist "%hackedRom%" goto :ERRrom
IF "%patchName%" EQU "" goto :ERRpatch

echo The unmodified ROM '%origRom%' will be used for patch creation...
CALL :FXCreate %origRom% %hackedRom% %patchName% %tmpPath%

IF %ERRORLEVEL% EQU 0 (
  echo IPS patch created.
  @pause
  goto :end
) ELSE (
  echo IPS patch creation failed. See logs above for details.
  goto :error
)

:FXCreate
set orig=%1
set hacked=%2
set dest=%~n3
set ext=%~x3
set tmp=%4
REM Stringify the current date and time into YYYY_MM_DD__HH_MM_SS
set dt=%DATE%__%TIME:~0,8%
set dt=%dt:-=_%
set dt=%dt::=_%
set dest=%dest%_%dt%%ext%

IF not exist "%tmp%" mkdir "%tmp%"

echo Creating patch from modified ROM %hacked% into %tmp%
CALL ips-creator.bat %orig% %hacked% %dest% %tmp%

exit /b %errorlevel%

:ERRrom
echo You need to specify the original ROM and hacked ROM to create the patch.
goto error

:ERRpatch
echo You need to specify a patch name to create it.
goto error

:error
exit /b 1

:end
exit /b 0