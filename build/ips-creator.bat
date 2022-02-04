@echo off
setlocal
set origRom=%1
set hackedRom=%2
set patchName=%3
set patchesPath=%4
set patcherUtil=%~dp0.\tools\flips\flips.exe

IF not exist "%patcherUtil%" goto :ERRpatcher

CALL :FXCreate %origRom% %hackedRom% %patchName% %patchesPath%
goto :end

:FXCreate
set orig=%1
set hacked=%2
set ips=%3
set path=%4

echo Creating %ips%
"%patcherUtil%" "%orig%" "%hacked%" "%path%%ips%"
exit /b %errorlevel%

:ERRpatcher
echo IPS Patcher utility is missing. Is it there '%patcherUtil%'?
goto error

:error
exit /b 1

:end
exit /b %errorlevel%