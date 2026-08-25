@echo off
title Configuring v8.x...
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
REM This section removes old custom system config files that are no longer needed...
REM *******************************************************************************************************************************************************************************************

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
REM This section pulls down the latest custom system config files for RB v8.x...
REM *******************************************************************************************************************************************************************************************

echo Updating system config files...
echo.
ping -n 1 127.0.0.1 >nul
..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/PixelNostalgia/PixN-RBv8.x-Custom-Systems.git
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo.
	echo ...Download Completed Successfully...
)
move /Y ".\PixN-RBv8.x-Custom-Systems\.emulationstation\*.cfg" ..\..\emulationstation\.emulationstation\ >nul 2>&1
rmdir /S /Q ".\PixN-RBv8.x-Custom-Systems" >nul 2>&1
:SKIP
ping -n 1 127.0.0.1 >nul

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

REM move %cd%\roms\sonicmania %cd%\roms\sonic-mania
REM move %cd%\roms\sonic3air %cd%\roms\sonic3-air
REM move %cd%\roms\snes-msu %cd%\roms\snes-msu1
REM move %cd%\roms\gb-msu %cd%\roms\sgb-msu1
REM move %cd%\roms\o2em %cd%\roms\odyssey2
REM move %cd%\roms\casloopy %cd%\roms\loopy

REM *******************************************************************************************************************************************************************************************
REM Replacing .daphne with .hypseus in the gamelist.xml...
REM *******************************************************************************************************************************************************************************************

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

REM *******************************************************************************************************************************************************************************************
REM This section updates the PS3 m3u files as required...
REM *******************************************************************************************************************************************************************************************

echo.
echo Updating PS3 m3u files as required...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\PS3-m3u-update-v1" goto SKIP
REM Backup files...
7z a "..\..\emulators\pixn\PS3-M3U-PixN-Backup.zip" "..\..\roms\ps3\*.m3u" >nul 2>&1
for %%i in (..\..\roms\ps3\*.m3u) do cscript replace.vbs "%%i" "\dev_hdd0\" "SAVESPATH\dev_hdd0\" > nul
ping -n 1 127.0.0.1 >nul
for %%i in (..\..\roms\ps3\*.m3u) do cscript replace.vbs "%%i" "SAVESPATHSAVESPATH\" "SAVESPATH\" > nul
ping -n 1 127.0.0.1 >nul
for %%i in (..\..\roms\ps3\*.m3u) do cscript replace.vbs "%%i" "SAVESPATHSAVESPATHSAVESPATH\" "SAVESPATH\" > nul
ping -n 1 127.0.0.1 >nul
echo PS3-m3u-update-v1 > .\Flags\PS3-m3u-update-v1
echo.
del /Q replace.vbs >nul 2>&1
:SKIP

REM *******************************************************************************************************************************************************************************************
REM This section enables the WebServer needed by the PixN Portal...
REM *******************************************************************************************************************************************************************************************

setlocal

REM Set the working directory to the script's location
REM cd /d "%~dp0"

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Execute PowerShell command in Bypass mode
powershell -ExecutionPolicy Bypass -Command ^
    "if (!(Select-String -Path '%filePath%' -Pattern '<bool name=\"PublicWebAccess\"')) { " ^
    "try { " ^
    "$content = Get-Content '%filePath%'; " ^
    "$insertIndex = [Array]::IndexOf($content, '</config>'); " ^
    "if ($insertIndex -eq -1) { throw 'Closing </config> tag not found' } " ^
    "$content = $content[0..($insertIndex-1)] + '    <bool name=\"PublicWebAccess\" value=\"true\" />' + $content[$insertIndex..($content.Length-1)]; " ^
    "$content | Set-Content '%filePath%'; " ^
    "} catch { " ^
    "Write-Host 'Error occurred: ' $_.Exception.Message; " ^
    "exit 1; " ^
    "}; " ^
    "}"

endlocal

REM *******************************************************************************************************************************************************************************************
REM Setting options for the AtariST pack...
REM *******************************************************************************************************************************************************************************************

start /wait .\Scripts\AtariST-Settings.cmd

REM *******************************************************************************************************************************************************************************************

:CHECKv8.1+
>nul findstr /l /c:"8.1" /c:"8.2" /c:"8.3" /c:"8.4" /c:"8.5" /c:"8.6" /c:"8.7" /c:"8.8" /c:"8.9" ..\..\system\version.info && (
  echo You are running RetroBat v8.1 or higher...
  echo.
  goto CONFIGUREv8.1+
) || (
  goto END
)

:CONFIGUREv8.1+
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *********************************************************************************** Configure RB v8.1+ ************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

REM Nothing required here yet...

REM *******************************************************************************************************************************************************************************************

:CHECKv8.2+
>nul findstr /l /c:"8.2" /c:"8.3" /c:"8.4" /c:"8.5" /c:"8.6" /c:"8.7" /c:"8.8" /c:"8.9" ..\..\system\version.info && (
  echo You are running RetroBat v8.2 or higher...
  echo.
  goto CONFIGUREv8.2+
) || (
  goto END
)

:CONFIGUREv8.2+
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *********************************************************************************** Configure RB v8.2+ ************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

REM *******************************************************************************************************************************************************************************************
REM Updating Emulators for the Namco2x6 pack...
REM *******************************************************************************************************************************************************************************************

echo Checking for required Namco2x6 files...
echo.
ping -n 1 127.0.0.1 >nul

IF EXIST ".\Flags\Namco2x6-v1" goto SKIP
del /Q memcards.7z >nul 2>&1
del /Q namco2x6.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/namco2x6.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/BIOS_Updates/memcards.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
rmdir /S /Q "..\..\emulators\teknoparrot\pcsx2x6" >nul 2>&1
md ..\..\emulators\pcsx2x6 >nul 2>&1
md ..\..\saves\namco2x6 >nul 2>&1
7z x memcards.7z -aoa -o..\..\saves\namco2x6\ >nul 2>&1
7z x namco2x6.7z -aoa -o..\..\emulators\ >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q memcards.7z >nul 2>&1
del /Q namco2x6.7z >nul 2>&1
echo Namco2x6-v1 > .\Flags\Namco2x6-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************

REM *******************************************************************************************************************************************************************************************


:END

exit