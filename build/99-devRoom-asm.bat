@echo off
setlocal
set rom=%1
set patchName=%2
set patcherUtil=%~dp0\tools\asar\asar.exe
set patchesPath=%~dp0..\src\%patchName%\

IF not exist "%patcherUtil%" goto :ERRpatcher
IF not exist "%patchesPath%" goto :ERRpatches
IF not exist "%rom%" goto :ERRrom
IF "%patchName%" EQU "" goto :ERRpatch

echo The following ROM '%rom%' will be patched...
CALL :FXApply ship-fabul-to-corneria.asm
CALL :FXApply enterprise-baron-to-corneria.asm
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
echo ASM Patcher utility is missing. Is it there '%patcherUtil%'?
goto error

:ERRpatches
echo Path for the patches doesn't exist. Is this the good one '%patchesPath%'?
goto error

:ERRrom
echo You need to specify a ROM to apply the patches.
goto error

:ERRpatch
echo You need to specify a patch name to apply every ASM patch in it.
goto error

:error
exit /b 1

:end
exit /b %errorlevel%