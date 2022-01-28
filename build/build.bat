@echo off
setlocal enabledelayedexpansion
set patchName=%1
set rom=%2
set hackedRom=%3
set ipsConfigFile=%~dp0.\build-config-ips.ini
set asmConfigFile=%~dp0.\build-config-asm.ini

IF "%hackedRom%" EQU "" (
  set tmpRom=
  CALL backup-rom.bat tmpRom %rom% %patchName%
  IF !ERRORLEVEL! EQU 0 CALL patch.bat ips !tmpRom! %patchName% %ipsConfigFile%
  IF !ERRORLEVEL! EQU 0 CALL patch.bat asm !tmpRom! %patchName% %asmConfigFile%
  IF !ERRORLEVEL! EQU 0 CALL build-ips.bat %rom% !tmpRom! %patchName%.ips
  goto :end
) ELSE (
  CALL build-ips.bat %rom% %hackedRom% %patchName%.ips
  goto :end
)

:end
exit /b %errorlevel%