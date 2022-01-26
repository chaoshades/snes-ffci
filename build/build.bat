@echo off
setlocal
set rom=%1
set patchName=%2
set ipsConfigFile=%~dp0.\build-config-ips.ini
set asmConfigFile=%~dp0.\build-config-asm.ini

set tmpRom=
CALL backup-rom.bat tmpRom %rom% %patchName%
IF %ERRORLEVEL% EQU 0 CALL patch.bat ips %tmpRom% %patchName% %ipsConfigFile%
IF %ERRORLEVEL% EQU 0 CALL patch.bat asm %tmpRom% %patchName% %asmConfigFile%
IF %ERRORLEVEL% EQU 0 CALL build-ips.bat %rom% %tmpRom% %patchName%.ips
goto :end

:error
exit /b 1

:end
exit /b %errorlevel%