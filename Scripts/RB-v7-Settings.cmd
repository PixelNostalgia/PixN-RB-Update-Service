@echo off
title Configuring v7.x...
REM Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

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

REM This section removes old custom system config files that are no longer needed in RBv7.x...
echo.
echo Cleaning up old config files...
echo.
ping -n 1 127.0.0.1 >nul
del /Q ..\..\emulationstation\.emulationstation\es_systems_cgenius.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_cdogs.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_corsixth.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_3ds.cfg >nul 2>&1
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
REM This section adds the new Emulators required for RBv7.x...
REM *******************************************************************************************************************************************************************************************

echo Adding the new Emulators required for RetroBat v7.x...
echo.

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated cGenius Emulator...
REM *******************************************************************************************************************************************************************************************

echo.
echo Checking for the updated cGenius Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\cgenius-emu-v1" goto SKIP
del /Q cgenius_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/cgenius_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x cgenius_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\cgenius >nul 2>&1
echo.
echo ...Copying files...
xcopy cgenius ..\..\emulators\cgenius\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q cgenius_feb2025.7z >nul 2>&1
rmdir /S /Q cgenius >nul 2>&1
echo cgenius-emu-v1 > .\Flags\cgenius-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated Kronos Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking for the updated Kronos Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\kronos-emu-v1" goto SKIP
del /Q kronos_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/kronos_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x kronos_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\kronos >nul 2>&1
echo.
echo ...Copying files...
xcopy kronos ..\..\emulators\kronos\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q kronos_feb2025.7z >nul 2>&1
rmdir /S /Q kronos >nul 2>&1
echo kronos-emu-v1 > .\Flags\kronos-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated Lime3DS Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking for the updated Lime3DS Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\lime3ds-emu-v1" goto SKIP
del /Q lime3ds_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/lime3ds_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x lime3ds_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\lime3ds >nul 2>&1
echo.
echo ...Copying files...
xcopy lime3ds ..\..\emulators\lime3ds\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q lime3ds_feb2025.7z >nul 2>&1
rmdir /S /Q lime3ds >nul 2>&1
echo lime3ds-emu-v1 > .\Flags\lime3ds-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated MagicEngine Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking for the updated MagicEngine Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\magicengine-emu-v1" goto SKIP
del /Q magicengine_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/magicengine_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x magicengine_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\magicengine >nul 2>&1
echo.
echo ...Copying files...
xcopy magicengine ..\..\emulators\magicengine\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q magicengine_feb2025.7z >nul 2>&1
rmdir /S /Q magicengine >nul 2>&1
echo magicengine-emu-v1 > .\Flags\magicengine-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated Mandarine Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking for the updated Mandarine Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\mandarine-emu-v1" goto SKIP
del /Q mandarine_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/mandarine_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x mandarine_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\mandarine >nul 2>&1
echo.
echo ...Copying files...
xcopy mandarine ..\..\emulators\mandarine\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q mandarine_feb2025.7z >nul 2>&1
rmdir /S /Q mandarine >nul 2>&1
echo mandarine-emu-v1 > .\Flags\mandarine-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated OpenJazz Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking for the updated OpenJazz Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\openjazz-emu-v1" goto SKIP
del /Q openjazz_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/openjazz_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x openjazz_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\openjazz >nul 2>&1
echo.
echo ...Copying files...
xcopy openjazz ..\..\emulators\openjazz\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q openjazz_feb2025.7z >nul 2>&1
rmdir /S /Q openjazz >nul 2>&1
echo openjazz-emu-v1 > .\Flags\openjazz-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated PDark Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking for the updated PDark Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\pdark-emu-v1" goto SKIP
del /Q pdark_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/pdark_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x pdark_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\pdark >nul 2>&1
echo.
echo ...Copying files...
xcopy pdark ..\..\emulators\pdark\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q pdark_feb2025.7z >nul 2>&1
rmdir /S /Q pdark >nul 2>&1
echo pdark-emu-v1 > .\Flags\pdark-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated Xenia Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking for the updated Xenia Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\xenia-emu-v2" goto SKIP
del /Q xenia_Aug20-2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/xenia_Aug20-2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x xenia_Aug20-2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\xenia >nul 2>&1
echo.
echo ...Copying files...
xcopy xenia ..\..\emulators\xenia\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q xenia_Aug20-2025.7z >nul 2>&1
rmdir /S /Q xenia >nul 2>&1
echo xenia-emu-v2 > .\Flags\xenia-emu-v2
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated Xenia-Canary Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking for the updated Xenia-Canary Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\xenia-canary-emu-v2" goto SKIP
del /Q xenia-canary_Oct06-2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/xenia-canary_Oct06-2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x xenia-canary_Oct06-2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\xenia-canary >nul 2>&1
echo.
echo ...Copying files...
xcopy xenia-canary ..\..\emulators\xenia-canary\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q xenia-canary_Oct06-2025.7z >nul 2>&1
rmdir /S /Q xenia-canary >nul 2>&1
echo xenia-canary-emu-v2 > .\Flags\xenia-canary-emu-v2
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated Xenia-Manager Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking for the updated Xenia-Manager Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\xenia-manager-emu-v1" goto SKIP
del /Q xenia-manager_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/xenia-manager_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x xenia-manager_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\xenia-manager >nul 2>&1
echo.
echo ...Copying files...
xcopy xenia-manager ..\..\emulators\xenia-manager\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q xenia-manager_feb2025.7z >nul 2>&1
rmdir /S /Q xenia-manager >nul 2>&1
echo xenia-manager-emu-v1 > .\Flags\xenia-manager-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated Yabasanshiro Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking for the updated Yabasanshiro Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\yabasanshiro-emu-v1" goto SKIP
del /Q yabasanshiro_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/yabasanshiro_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x yabasanshiro_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\yabasanshiro >nul 2>&1
echo.
echo ...Copying files...
xcopy yabasanshiro ..\..\emulators\yabasanshiro\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q yabasanshiro_feb2025.7z >nul 2>&1
rmdir /S /Q yabasanshiro >nul 2>&1
echo yabasanshiro-emu-v1 > .\Flags\yabasanshiro-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section pulls down the latest custom system config files for RBv7.x...
REM *******************************************************************************************************************************************************************************************

echo Updating system config files...
echo.
ping -n 1 127.0.0.1 >nul
..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/PixelNostalgia/PixN-RBv7.x-Custom-Systems.git
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo.
	echo ...Download Completed Successfully...
	echo.
)
move /Y ".\PixN-RBv7.x-Custom-Systems\.emulationstation\*.cfg" ..\..\emulationstation\.emulationstation\ >nul 2>&1
rmdir /S /Q ".\PixN-RBv7.x-Custom-Systems" >nul 2>&1
:SKIP
ping -n 1 127.0.0.1 >nul
echo.

REM *******************************************************************************************************************************************************************************************

:CHECKv7.2+
>nul findstr /l /c:"7.2" /c:"7.3" /c:"7.4" /c:"7.5" /c:"7.6" /c:"7.7" /c:"7.8" /c:"7.9" ..\..\system\version.info && (
  echo You are running RetroBat v7.2 or higher...
  echo.
  goto CONFIGUREv7.2+
) || (
  goto END
)

:CONFIGUREv7.2+
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *********************************************************************************** Configure RB v7.2+ ************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

REM *******************************************************************************************************************************************************************************************
REM Renaming game folders...
REM *******************************************************************************************************************************************************************************************

echo.
echo Renaming Hypseus related game folders...
echo.
cd ..\..
set "HypROMsPath1=%cd%\roms\daphne"
set "HypROMsPath2=%cd%\roms\singe"
set "HypROMsPath3=%cd%\roms\captpower"
set "HypROMsPath4=%cd%\roms\videodriver"
echo Searching in: %HypROMsPath1%
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -Path '%HypROMsPath1%' -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -like '*.daphne' } | ForEach-Object { $oldName = $_.Name; $newName = $oldName -replace '\.daphne$', '.hypseus'; Write-Host \"Renaming: $oldName to $newName\"; Rename-Item -Path $_.FullName -NewName $newName -Force -ErrorAction SilentlyContinue }"
echo.
echo Searching in: %HypROMsPath2%
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -Path '%HypROMsPath2%' -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -like '*.daphne' } | ForEach-Object { $oldName = $_.Name; $newName = $oldName -replace '\.daphne$', '.hypseus'; Write-Host \"Renaming: $oldName to $newName\"; Rename-Item -Path $_.FullName -NewName $newName -Force -ErrorAction SilentlyContinue }"
echo.
echo Searching in: %HypROMsPath3%
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -Path '%HypROMsPath3%' -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -like '*.daphne' } | ForEach-Object { $oldName = $_.Name; $newName = $oldName -replace '\.daphne$', '.hypseus'; Write-Host \"Renaming: $oldName to $newName\"; Rename-Item -Path $_.FullName -NewName $newName -Force -ErrorAction SilentlyContinue }"
echo.
echo Searching in: %HypROMsPath4%
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -Path '%HypROMsPath4%' -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -like '*.daphne' } | ForEach-Object { $oldName = $_.Name; $newName = $oldName -replace '\.daphne$', '.hypseus'; Write-Host \"Renaming: $oldName to $newName\"; Rename-Item -Path $_.FullName -NewName $newName -Force -ErrorAction SilentlyContinue }"
echo.

move %cd%\roms\actionmax\actionmax %cd%\roms\actionmax\actionmax.hypseus > nul 2>&1

cd emulators\pixn

REM Replacing .daphne with .hypseus in the gamelist.xml...
echo Replacing .daphne with .hypseus in the gamelist.xml...
echo.
echo Const ForReading = 1 > replace.vbs
echo Const ForWriting = 2 >> replace.vbs
echo. >> replace.vbs
echo. >> replace.vbs
echo strFileName = Wscript.Arguments(0) >> replace.vbs
echo strOldText = Wscript.Arguments(1) >> replace.vbs
echo strNewText = Wscript.Arguments(2) >> replace.vbs
echo. >> replace.vbs
echo. >> replace.vbs
echo Set objFSO = CreateObject("Scripting.FileSystemObject") >> replace.vbs
echo Set objFile = objFSO.OpenTextFile(strFileName, ForReading) >> replace.vbs
echo. >> replace.vbs
echo. >> replace.vbs
echo strText = objFile.ReadAll >> replace.vbs
echo objFile.Close >> replace.vbs
echo strNewText = Replace(strText, strOldText, strNewText) >> replace.vbs
echo. >> replace.vbs
echo. >> replace.vbs
echo objFile.Close >> replace.vbs
echo Set objFile = objFSO.OpenTextFile(strFileName, ForWriting) >> replace.vbs
echo objFile.Write strNewText >> replace.vbs
echo objFile.Close>> replace.vbs

REM cscript replace.vbs "..\..\roms\singe\gamelist.xml" ".daphne</path>" ".hypseus</path>" > nul 2>&1
REM cscript replace.vbs "..\..\roms\singe\gamelist_ARRM.xml" ".daphne</path>" ".hypseus</path>" > nul 2>&1
cscript replace.vbs "..\..\roms\daphne\gamelist.xml" ".daphne</path>" ".hypseus</path>" > nul 2>&1
cscript replace.vbs "..\..\roms\daphne\gamelist_ARRM.xml" ".daphne</path>" ".hypseus</path>" > nul 2>&1
cscript replace.vbs "..\..\roms\captpower\gamelist.xml" ".daphne</path>" ".hypseus</path>" > nul 2>&1
cscript replace.vbs "..\..\roms\captpower\gamelist_ARRM.xml" ".daphne</path>" ".hypseus</path>" > nul 2>&1
cscript replace.vbs "..\..\roms\videodriver\gamelist.xml" ".daphne</path>" ".hypseus</path>" > nul 2>&1
cscript replace.vbs "..\..\roms\videodriver\gamelist_ARRM.xml" ".daphne</path>" ".hypseus</path>" > nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q replace.vbs >nul 2>&1

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

REM *******************************************************************************************************************************************************************************************

:CHECKv7.3+
>nul findstr /l /c:"7.3" /c:"7.4" /c:"7.5" /c:"7.6" /c:"7.7" /c:"7.8" /c:"7.9" ..\..\system\version.info && (
  echo You are running RetroBat v7.3 or higher...
  echo.
  goto CONFIGUREv7.3+
) || (
  goto END
)

:CONFIGUREv7.3+
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *********************************************************************************** Configure RB v7.3+ ************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

REM *******************************************************************************************************************************************************************************************
REM This section adds the new Emulators required for RetroBat v7.3 and higher
REM *******************************************************************************************************************************************************************************************

echo.
echo Adding the new Emulators required for RetroBat v7.3 and higher...
echo.
ping -n 1 127.0.0.1 >nul

IF EXIST ".\Flags\rb-7.3+emulators_11-08-2025" goto SKIP
ping -n 1 127.0.0.1 >nul
echo.
del /Q rb-7.3+emulators_11-08-2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/rb-7.3+emulators_11-08-2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x rb-7.3+emulators_11-08-2025.7z -aoa -p22446688 -o..\..\emulators\ >nul 2>&1
echo.
ping -n 1 127.0.0.1 >nul
del /Q rb-7.3+emulators_11-08-2025.7z >nul 2>&1
echo rb-7.3+emulators_11-08-2025 > .\Flags\rb-7.3+emulators_11-08-2025
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************

:CHECKv7.5+
>nul findstr /l /c:"7.5" /c:"7.6" /c:"7.7" /c:"7.8" /c:"7.9" ..\..\system\version.info && (
  echo You are running RetroBat v7.5 or higher...
  echo.
  goto CONFIGUREv7.5+
) || (
  goto END
)

:CONFIGUREv7.5+
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *********************************************************************************** Configure RB v7.5+ ************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

REM This section adds the new files/config required for RetroBat v7.5 and higher

REM *******************************************************************************************************************************************************************************************


:END

exit