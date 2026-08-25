@echo off
title Configuring v6.x...
REM Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

rem Script to send the window full screen
:VBSDynamicBuild
SET TempVBSFile=%temp%\~tmpSendKeysTemp.vbs
IF EXIST "%TempVBSFile%" DEL /F /Q "%TempVBSFile%"
ECHO Set WshShell = WScript.CreateObject("WScript.Shell") >>"%TempVBSFile%"
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"
ECHO WshShell.SendKeys "{F11}"                            >>"%TempVBSFile%"
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"

CSCRIPT //nologo "%TempVBSFile%"

REM *******************************************************************************************************************************************************************************************
REM This section fixes TriForce Games...
REM *******************************************************************************************************************************************************************************************

echo.
echo Updating config for TriForce Games...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\TriForce-Config-v1" goto SKIP
del /Q TriForce-Game-Settings.zip >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/TriForce-Game-Settings.zip >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x TriForce-Game-Settings.zip -aoa -o..\..\emulators\dolphin-triforce\User\GameSettings\ >nul 2>&1
echo.
ping -n 1 127.0.0.1 >nul
del /Q TriForce-Game-Settings.zip >nul 2>&1
echo TriForce-Config-v1 > .\Flags\TriForce-Config-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM This section removes old custom system config files that are no longer needed...
echo.
echo Cleaning up old config files...
echo.
ping -n 1 127.0.0.1 >nul
del /Q ..\..\emulationstation\.emulationstation\es_systems_tg-16.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_examu.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_segalindbergh.cfg >nul 2>&1
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated Hypseus Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking for the updated Hypseus Emulator...
echo.
ping -n 1 127.0.0.1 >nul

IF EXIST ".\Flags\Hypseus-v1" goto SKIP
del /Q hypseus.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/hypseus.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x hypseus.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\hypseus >nul 2>&1
echo.
echo ...Copying files...
xcopy hypseus ..\..\emulators\hypseus\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q hypseus.7z >nul 2>&1
rmdir /S /Q hypseus >nul 2>&1

echo Hypseus-v1 > .\Flags\Hypseus-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for Solarus emulator updates...
REM *******************************************************************************************************************************************************************************************

echo.
echo Checking for Solarus emulator updates...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\solarus-emu-v1" goto SKIP
del /Q solarus-v2.0.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/solarus-v2.0.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x solarus-v2.0.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\solarus >nul 2>&1
echo.
echo ...Copying files...
xcopy solarus ..\..\emulators\solarus\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q solarus-v2.0.7z >nul 2>&1
rmdir /S /Q solarus >nul 2>&1
echo solarus-emu-v1 > .\Flags\solarus-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section pulls down the latest custom system config files for RBv6.x...
REM *******************************************************************************************************************************************************************************************

echo Updating system config files...
echo.
ping -n 1 127.0.0.1 >nul
..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/PixelNostalgia/PixN-RBv6.x-Custom-Systems.git >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo.
	echo ...Download Completed Successfully...
	echo.
)
move /Y ".\PixN-RBv6.x-Custom-Systems\.emulationstation\*.cfg" ..\..\emulationstation\.emulationstation\ >nul 2>&1
rmdir /S /Q ".\PixN-RBv6.x-Custom-Systems" >nul 2>&1
:SKIP
ping -n 1 127.0.0.1 >nul
echo.

REM *******************************************************************************************************************************************************************************************
REM This section pulls down the latest es-checkversion script...
REM *******************************************************************************************************************************************************************************************

echo.
echo Updating es-checkversion script if required...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\es-checkversion-v1" goto SKIP
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/es-checkversion-v6.4.cmd -O es-checkversion.cmd >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo.
	echo ...Download Completed Successfully...
	echo.
)
move /Y "es-checkversion.cmd" ..\..\emulationstation\ >nul 2>&1
ping -n 1 127.0.0.1 >nul
echo es-checkversion-v1 > .\Flags\es-checkversion-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************


:END

exit