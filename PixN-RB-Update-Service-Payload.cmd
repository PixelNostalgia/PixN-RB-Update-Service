@echo off
pushd %1
REM Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

REM This section pulls down the latest PixN Scripts...
mkdir Scripts >nul 2>&1
REM Cleanup...
rmdir /S /Q "logs" >nul 2>&1
del /Q PixN-Reset.cmd >nul 2>&1
del /Q Send-F11Fullscreen.ps1 >nul 2>&1
del /Q Add-PixNService.ps1 >nul 2>&1
del /Q Fix-RetrobatShortname.ps1 >nul 2>&1
del /Q Remove-Epic-Steam-Shortcuts.ps1 >nul 2>&1
REM Download Latest...
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/PixN-Reset.cmd -O .\Scripts\PixN-Reset.cmd >nul 2>&1
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/Send-F11Fullscreen.ps1 -O .\Scripts\Send-F11Fullscreen.ps1 >nul 2>&1
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/Add-PixNService.ps1 -O .\Scripts\Add-PixNService.ps1 >nul 2>&1
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/Fix-RetrobatShortname.ps1 -O .\Scripts\Fix-RetrobatShortname.ps1 >nul 2>&1
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/Remove-Epic-Steam-Shortcuts.ps1 -O .\Scripts\Remove-Epic-Steam-Shortcuts.ps1 >nul 2>&1

REM Script to send the window full screen
powershell -ExecutionPolicy Bypass -File ".\Scripts\Send-F11Fullscreen.ps1"

REM Function to handle errors with a pause
set "handle_error=timeout /t 4 >nul"

REM Read from ASCII.txt and visualize ASCII art
type ASCII.txt

echo.
echo Pixel Nostalgia updater running...
echo Version 8.03
echo.
timeout /t 3 >nul
cls

echo.
echo #########################################################
echo #                                                       #
echo #                   IMPORTANT NOTICE:                   #
echo #      IF YOU HAVE PAID ANY FORM OF MONEY FOR THIS      #
echo #     OR ANY OTHER TEAM PIXEL NOSTALGIA / RGS BUILD     #
echo #                DEMAND YOUR MONEY BACK!                #
echo #                                                       #
echo #         THIS BUILD IS FREELY AVAILABLE TO ALL         #
echo #                VIA OUR DISCORD SERVER:                #
echo #                                                       #
echo #             https://discord.gg/xNxrAr6sGv             #
echo #                                                       #
echo #########################################################
echo.

timeout /t 2 >nul
REM Text color code for Yellow is E
set "colorCode=E"
color %colorCode%
timeout /t 2 >nul
REM Text color code for Light Green is A
set "colorCode=A"
color %colorCode%
timeout /t 2 >nul
REM Text color code for Yellow is E
set "colorCode=E"
color %colorCode%
timeout /t 2 >nul
REM Text color code for Light Green is A
set "colorCode=A"
color %colorCode%
timeout /t 2 >nul
REM Text color code for Yellow is E
set "colorCode=E"
color %colorCode%
timeout /t 2 >nul
REM Text color code for Light Green is A
set "colorCode=A"
color %colorCode%
cls

REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM ************************************************************ This first section applies config that is NOT version dependent **************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

REM This section pulls down the latest rClone config...
echo.
echo Updating rClone Configuration...
echo.
IF EXIST "rclone-v3" goto RC-END
del /Q rc.7z >nul 2>&1
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/rc.7z -O rc.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo rClone download failed! - Skipping...
    %handle_error%
	goto RC-END
) else (
    echo rClone download successful...
)
timeout /t 1 >nul
7z x rc.7z -aoa -p22446688 -o.\ >nul 2>&1
timeout /t 1 >nul
del /Q rc.7z >nul 2>&1
echo rclone-v3 > rclone-v3
:RC-END
timeout /t 2 >nul
del /Q rclone.conf >nul 2>&1
timeout /t 2 >nul
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/rclone.conf -O rclone.conf >nul 2>&1
timeout /t 1 >nul
:SKIP
REM *******************************************************************************************************************************************************************************************

REM This section pulls down the latest PixN Custom Collections...
echo.
echo Updating the PixN Custom Collections...
echo.
timeout /t 1 >nul
rmdir /S /Q ".\PixN-Collections" >nul 2>&1
md "..\..\emulationstation\.emulationstation\collections" >nul 2>&1
..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/PixelNostalgia/PixN-Collections.git
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo.
	echo Download Completed Successfully...
)
move /Y ".\PixN-Collections\*.cfg" ..\..\emulationstation\.emulationstation\collections\ >nul 2>&1
rmdir /S /Q ".\PixN-Collections" >nul 2>&1
:SKIP
timeout /t 1 >nul
echo.
REM *******************************************************************************************************************************************************************************************

REM This section restores the PixN Update Service artwork...
echo Checking if the PixN Update Service artwork needs restoring...
echo.
timeout /t 1 >nul
powershell -ExecutionPolicy Bypass -File ".\Scripts\Add-PixNService.ps1"
echo.
timeout /t 1 >nul
del /Q "pixn-rb-update-service-logo.png" >nul 2>&1
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/pixn-rb-update-service-logo.png -O pixn-rb-update-service-logo.png >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	got SKIP
) else (
    echo Download Completed Successfully...
)
move /Y "pixn-rb-update-service-logo.png" ..\..\system\es_menu\media\ >nul 2>&1
:SKIP
timeout /t 1 >nul
echo.
REM *******************************************************************************************************************************************************************************************

REM This section cleans up from when the PixN Update Service was added to the system wheel...
rmdir /S /Q "..\..\roms\pixn" >nul 2>&1
REM *******************************************************************************************************************************************************************************************

REM This section applies the PinballFX and Piball M Fix...
echo Applying PinballFX and Piball M Fix if required...
echo.
timeout /t 1 >nul
IF EXIST "pinballfx-v1" goto SKIP
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Pin-Lic.7z -O Pin-Lic.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/7z.exe -O 7z.exe >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/7z.dll -O 7z.dll >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
7z x Pin-Lic.7z -aoa -p22446688 -o.\ >nul 2>&1

md "%localappdata%\PinballFX" >nul 2>&1
md "%localappdata%\PinballM" >nul 2>&1

xcopy PinballFX "%localappdata%\PinballFX" /S /E /D /I /Y >nul 2>&1
echo Copying files...
xcopy PinballM "%localappdata%\PinballM" /S /E /D /I /Y >nul 2>&1

robocopy "PinballFX\Saved\SaveGames" "%localappdata%\PinballFX\Saved\SaveGames" /mir /xd 76561197981264163 /w:0 /r:0 >nul 2>&1
robocopy "PinballM\Saved\SaveGames" "%localappdata%\PinballM\Saved\SaveGames" /mir /xd 76561197981264163 /w:0 /r:0 >nul 2>&1

rmdir /S /Q "PinballFX" >nul 2>&1
rmdir /S /Q "PinballM" >nul 2>&1
del /Q Pin-Lic.7z >nul 2>&1
timeout /t 1 >nul
echo pinballfx-v1 > pinballfx-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section applies Zaccaria Pinball config...
echo Applying Zaccaria Pinball Config if required...
echo.
timeout /t 1 >nul
IF EXIST "ZP-v1" goto SKIP
del /Q ZP.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/ZP.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
7z x ZP.7z -aoa -p22446688 -o.\ >nul 2>&1
echo.
ver | find "XP" > nul
    if %ERRORLEVEL% == 0 SET PixN-MyDocs=%USERPROFILE%\My Documents
    if %ERRORLEVEL% == 1 FOR /f "tokens=3" %%x IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Personal"') do (set PixN-MyDocs=%%x)
echo Copying files...
md "%PixN-MyDocs%\Zaccaria_Pinball" >nul 2>&1
echo n | copy /-y "Zaccaria_Pinball" "%PixN-MyDocs%\Zaccaria_Pinball" >nul 2>&1
timeout /t 1 >nul
rmdir /S /Q "Zaccaria_Pinball" >nul 2>&1
del /Q ZP.7z >nul 2>&1
echo ZP-v1 > ZP-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section adds OpenAL32.dll if required...
echo Checking if OpenAL32.dll is required...
echo.
timeout /t 1 >nul
IF EXIST "OpenAL32.dll-v1" goto SKIP
IF NOT EXIST ..\..\roms\zaccariapinball\ZaccariaPinball.pc\ goto SKIP
IF EXIST ..\..\roms\zaccariapinball\ZaccariaPinball.pc\OpenAL32.dll goto SKIP

wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/OpenAL32.dll -O OpenAL32.dll >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
copy OpenAL32.dll ..\..\roms\zaccariapinball\ZaccariaPinball.pc\ >nul 2>&1
echo.
del /Q OpenAL32.dll >nul 2>&1
echo OpenAL32.dll-v1 > OpenAL32.dll-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for updated Radio stations...
echo Checking for updated Radio Stations...
echo.
timeout /t 1 >nul
mkdir ..\..\roms\radio >nul 2>&1
IF EXIST "Radio-v4" goto SKIP
del /Q radio.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/radio.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
del /Q /S ..\..\roms\radio\*.* >nul 2>&1
timeout /t 1 >nul
7z x radio.7z -aoa -p22446688 -o..\..\roms\radio\ >nul 2>&1
echo.
del /Q radio.7z >nul 2>&1

echo Radio-v4 > Radio-v4
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for updates to the PixN Radio station...
echo Checking for updates to the PixN Radio Station...
echo.
timeout /t 1 >nul
IF EXIST "PixN-Radio-v5" goto SKIP
del /Q PixN-Radio.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/PixN-Radio.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
del /Q /S ..\..\roms\radio\content\vlc\PixN-Radio\*.* >nul 2>&1
del /Q /S "..\..\roms\radio\content\vlc\PixN Radio.m3u8" >nul 2>&1
del /Q /S "..\..\roms\radio\content\vlc\PixN-Radio.m3u8" >nul 2>&1
timeout /t 1 >nul
7z x PixN-Radio.7z -aoa -p22446688 -o..\..\roms\radio\content\vlc\ >nul 2>&1
echo.
del /Q PixN-Radio.7z >nul 2>&1

wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/PixN-Radio.bat -O PixN-Radio.bat >nul 2>&1
copy PixN-Radio.bat ..\..\roms\radio\PixN-Radio.bat /y >nul 2>&1
timeout /t 2 >nul
del /Q /S ..\..\emulators\pixn\PixN-Radio.bat >nul 2>&1

echo PixN-Radio-v5 > PixN-Radio-v5
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section adds the Konami LCD Artwork files...
echo Downloading the Konami LCD Artwork files if required...
echo.
timeout /t 1 >nul
IF EXIST "konami-LCD-artwork-v1" goto SKIP
del /Q Konami-LCD-Artwork.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Game_Updates/Konami-LCD-Artwork/Konami-LCD-Artwork.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x Konami-LCD-Artwork.7z -aoa -p22446688 -o..\..\saves\mame\artwork\ >nul 2>&1
echo.
timeout /t 1 >nul
del /Q Konami-LCD-Artwork.7z >nul 2>&1
echo konami-LCD-artwork-v1 > konami-LCD-artwork-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section adds the Skylanders files to the Dolphin Emulator...
echo Adding Skylanders files to the Dolphin Emulator if required...
echo.
timeout /t 1 >nul
IF EXIST "Sky-v1" goto SKIP
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Sky.7z -O Sky.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x Sky.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\dolphin-emu >nul 2>&1
md ..\..\emulators\dolphin-emu\User >nul 2>&1
echo.
echo Copying files...
xcopy Skylanders ..\..\emulators\dolphin-emu\User\Skylanders\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q Sky.7z >nul 2>&1
rmdir /S /Q Skylanders >nul 2>&1

echo Sky-v1 > Sky-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated 3dSen Emulator...
echo Checking for the updated 3dSen Emulator...
echo.
timeout /t 1 >nul

IF EXIST "3dSen-v1" goto SKIP
del /Q 3d-N.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/3d-N.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x 3d-N.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\3dsen >nul 2>&1
echo.
echo Copying files...
xcopy 3dsen ..\..\emulators\3dsen\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q 3d-N.7z >nul 2>&1
rmdir /S /Q 3dsen >nul 2>&1

echo 3dSen-v1 > 3dSen-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated genesis_plus_gx_libretro core...
echo Checking for the updated genesis_plus_gx_libretro.dll core...
echo.
timeout /t 1 >nul

IF EXIST "paprium-core-v1" goto SKIP
del /Q genesis_plus_gx_libretro.dll >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/genesis_plus_gx_libretro.dll >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
echo Copying files...
move /Y "genesis_plus_gx_libretro.dll" ..\..\emulators\retroarch\cores\ >nul 2>&1
timeout /t 1 >nul
echo paprium-core-v1 > paprium-core-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated Virtual Pinball Emulator...
echo Checking for the updated Virtual Pinball Emulator...
echo.
timeout /t 1 >nul
IF EXIST "VPinball-v2" goto SKIP
del /Q vpinball_jan2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/vpinball_jan2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x vpinball_jan2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\vpinball >nul 2>&1
echo.
echo Copying files...
xcopy vpinball ..\..\emulators\vpinball\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q vpinball_jan2025.7z >nul 2>&1
rmdir /S /Q vpinball >nul 2>&1

echo VPinball-v2 > VPinball-v2
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks that the Ngage emulator is configured...
echo Checking Ngage Emulator...
echo.
timeout /t 1 >nul
IF EXIST "eka-emu-v1" goto SKIP
del /Q eka_jan2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/eka_jan2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x eka_jan2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\bios\eka2l1\ >nul 2>&1
md ..\..\bios\eka2l1\data\ >nul 2>&1
echo.
echo Copying files...
robocopy data ..\..\bios\eka2l1\data\ /E /XC /XN /XO /NP >nul 2>&1
timeout /t 1 >nul
del /Q eka_jan2025.7z >nul 2>&1
rmdir /S /Q data >nul 2>&1

echo eka-emu-v1 > eka-emu-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section enables HD texture packs for the NES HD system...
setlocal

REM Set the working directory to the script's location
REM cd /d "%~dp0"

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Backup the original file
copy "%filePath%" "%filePath%.bak" >nul 2>&1

REM Execute PowerShell command in Bypass mode
powershell -ExecutionPolicy Bypass -Command ^
    "if (!(Select-String -Path '%filePath%' -Pattern '<string name=\"nes_hd.hd_packs\"')) { " ^
    "try { " ^
    "$content = Get-Content '%filePath%'; " ^
    "$insertIndex = [Array]::IndexOf($content, '</config>'); " ^
    "if ($insertIndex -eq -1) { throw 'Closing </config> tag not found' } " ^
    "$content = $content[0..($insertIndex-1)] + '    <string name=\"nes_hd.hd_packs\" value=\"1\" />' + $content[$insertIndex..($content.Length-1)]; " ^
    "$content | Set-Content '%filePath%'; " ^
    "} catch { " ^
    "Write-Host 'Error occurred: ' $_.Exception.Message; " ^
    "exit 1; " ^
    "}; " ^
    "}"

endlocal
REM *******************************************************************************************************************************************************************************************

REM This section forces TransitionStyle to instant to improve the visuals for the HyperMax Theme...
setlocal

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Execute Windows PowerShell in Bypass mode
powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command ^
    "$path = '%filePath%'; " ^
    "try { " ^
    "    [xml]$xml = Get-Content -LiteralPath $path; " ^
    "    if ($xml.config -eq $null) { throw 'Root <config> node not found' } " ^
    "    @($xml.config.string | Where-Object { $_.name -eq 'TransitionStyle' }) | ForEach-Object { [void]$xml.config.RemoveChild($_) }; " ^
    "    $newNode = $xml.CreateElement('string'); " ^
    "    [void]$newNode.SetAttribute('name','TransitionStyle'); " ^
    "    [void]$newNode.SetAttribute('value','instant'); " ^
    "    [void]$xml.config.AppendChild($newNode); " ^
    "    $xml.Save($path); " ^
    "} catch { " ^
    "    Write-Host 'Error occurred:' $_.Exception.Message; " ^
    "    exit 1; " ^
    "}"

endlocal
REM *******************************************************************************************************************************************************************************************

REM This section sets DOSBox Pure settings (1of2)...
setlocal

REM Set the working directory to the script's location
REM cd /d "%~dp0"

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Execute PowerShell command in Bypass mode
powershell -ExecutionPolicy Bypass -Command ^
    "if (!(Select-String -Path '%filePath%' -Pattern '<string name=\"dos.core\"')) { " ^
    "try { " ^
    "$content = Get-Content '%filePath%'; " ^
    "$insertIndex = [Array]::IndexOf($content, '</config>'); " ^
    "if ($insertIndex -eq -1) { throw 'Closing </config> tag not found' } " ^
    "$content = $content[0..($insertIndex-1)] + '    <string name=\"dos.core\" value=\"dosbox_pure\" />' + $content[$insertIndex..($content.Length-1)]; " ^
    "$content | Set-Content '%filePath%'; " ^
    "} catch { " ^
    "Write-Host 'Error occurred: ' $_.Exception.Message; " ^
    "exit 1; " ^
    "}; " ^
    "}"

endlocal

REM This section sets DOSBox Pure settings (2of2)...
setlocal

REM Set the working directory to the script's location
REM cd /d "%~dp0"

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Execute PowerShell command in Bypass mode
powershell -ExecutionPolicy Bypass -Command ^
    "if (!(Select-String -Path '%filePath%' -Pattern '<string name=\"dos.dosbox_pure_conf\"')) { " ^
    "try { " ^
    "$content = Get-Content '%filePath%'; " ^
    "$insertIndex = [Array]::IndexOf($content, '</config>'); " ^
    "if ($insertIndex -eq -1) { throw 'Closing </config> tag not found' } " ^
    "$content = $content[0..($insertIndex-1)] + '    <string name=\"dos.dosbox_pure_conf\" value=\"inside\" />' + $content[$insertIndex..($content.Length-1)]; " ^
    "$content | Set-Content '%filePath%'; " ^
    "} catch { " ^
    "Write-Host 'Error occurred: ' $_.Exception.Message; " ^
    "exit 1; " ^
    "}; " ^
    "}"

endlocal
REM *******************************************************************************************************************************************************************************************

REM This section sets the correct Vectrex Bezels...
setlocal

REM Set the working directory to the script's location
REM cd /d "%~dp0"

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Execute PowerShell command in Bypass mode
powershell -ExecutionPolicy Bypass -Command ^
    "if (!(Select-String -Path '%filePath%' -Pattern '<string name=\"vectrex.bezel\"')) { " ^
    "try { " ^
    "$content = Get-Content '%filePath%'; " ^
    "$insertIndex = [Array]::IndexOf($content, '</config>'); " ^
    "if ($insertIndex -eq -1) { throw 'Closing </config> tag not found' } " ^
    "$content = $content[0..($insertIndex-1)] + '    <string name=\"vectrex.bezel\" value=\"thebezelproject\" />' + $content[$insertIndex..($content.Length-1)]; " ^
    "$content | Set-Content '%filePath%'; " ^
    "} catch { " ^
    "Write-Host 'Error occurred: ' $_.Exception.Message; " ^
    "exit 1; " ^
    "}; " ^
    "}"

endlocal

REM This section sets the correct Vectrex Shader...
setlocal

REM Set the working directory to the script's location
REM cd /d "%~dp0"

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Execute PowerShell command in Bypass mode
powershell -ExecutionPolicy Bypass -Command ^
    "if (!(Select-String -Path '%filePath%' -Pattern '<string name=\"vectrex.shaderset\"')) { " ^
    "try { " ^
    "$content = Get-Content '%filePath%'; " ^
    "$insertIndex = [Array]::IndexOf($content, '</config>'); " ^
    "if ($insertIndex -eq -1) { throw 'Closing </config> tag not found' } " ^
    "$content = $content[0..($insertIndex-1)] + '    <string name=\"vectrex.shaderset\" value=\"flatten-glow\" />' + $content[$insertIndex..($content.Length-1)]; " ^
    "$content | Set-Content '%filePath%'; " ^
    "} catch { " ^
    "Write-Host 'Error occurred: ' $_.Exception.Message; " ^
    "exit 1; " ^
    "}; " ^
    "}"

endlocal
REM *******************************************************************************************************************************************************************************************
REM *************************************************************This section adds new Emulators as required...********************************************************************************
REM *******************************************************************************************************************************************************************************************
echo Checking Emulators as required...
echo.

REM This section adds the ffmpeg core to Retroarch...
echo.
echo Checking Retroarch for the ffmpeg core...
echo.
timeout /t 1 >nul
IF EXIST "retroarch-emu-v1" goto SKIP
del /Q retroarch_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/retroarch_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x retroarch_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\retroarch >nul 2>&1
echo.
echo Copying files...
xcopy retroarch ..\..\emulators\retroarch\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q retroarch_feb2025.7z >nul 2>&1
rmdir /S /Q retroarch >nul 2>&1
echo retroarch-emu-v1 > retroarch-emu-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks the ShadPS4 Emulator...
echo Checking the ShadPS4 Emulator...
echo.
timeout /t 1 >nul
IF EXIST "shadps4-emu-v2" goto SKIP
del /Q shadps4_dec2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/shadps4_dec2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x shadps4_dec2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\shadps4 >nul 2>&1
echo.
echo Copying files...
xcopy shadps4 ..\..\emulators\shadps4\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q shadps4_dec2025.7z >nul 2>&1
rmdir /S /Q shadps4 >nul 2>&1
echo shadps4-emu-v2 > shadps4-emu-v2
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks the TeknoParrot Emulator...
echo Checking the TeknoParrot Emulator...
echo.
timeout /t 1 >nul
IF EXIST "TeknoParrot-v4" goto SKIP
REM Backup TecknoParrot data...
7z a "..\..\emulators\teknoparrot\UserProfiles-PixN-Backup.zip" "..\..\emulators\teknoparrot\UserProfiles\" >nul 2>&1
7z a "..\..\emulators\teknoparrot\GameProfiles-PixN-Backup.zip" "..\..\emulators\teknoparrot\GameProfiles\" >nul 2>&1
timeout /t 1 >nul
del /Q teknoparrot_jan2026.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/teknoparrot_jan2026.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x teknoparrot_jan2026.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\teknoparrot >nul 2>&1
echo.
echo Copying files...
xcopy teknoparrot ..\..\emulators\teknoparrot\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q teknoparrot_jan2026.7z >nul 2>&1
rmdir /S /Q teknoparrot >nul 2>&1

echo TeknoParrot-v4 > TeknoParrot-v4
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks the Switch Emulators...
echo Checking the Switch Emulators: Eden - Citron - Ryujinx
echo.
timeout /t 1 >nul
IF EXIST "Switch-v2" goto Switch-Eden
del /Q switch_dec2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/switch_dec2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto Switch-Eden
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x switch_dec2025.7z -aoa -p22446688 -o..\..\ >nul 2>&1
echo.
timeout /t 1 >nul
del /Q switch_dec2025.7z >nul 2>&1
echo Switch-v2 > Switch-v2
echo.

:Switch-Eden
timeout /t 1 >nul
IF EXIST "Switch-Eden-v1" goto SW-FW
del /Q Eden-v0.2.0-rc2-amd64-msvc-standard.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/Eden-v0.2.0-rc2-amd64-msvc-standard.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SW-FW
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x Eden-v0.2.0-rc2-amd64-msvc-standard.7z -aoa -p22446688 -o..\..\emulators\eden\ >nul 2>&1
echo.
timeout /t 1 >nul
del /Q Eden-v0.2.0-rc2-amd64-msvc-standard.7z >nul 2>&1
echo Switch-Eden-v1 > Switch-Eden-v1
echo.

:SW-FW
REM This section checks for the updated Switch Firmware...
echo.
echo Checking for updated Switch Firmware
echo.
timeout /t 2 >nul
rclone sync PixN-Themes-SH:/update/RetroBat/BIOS_Updates/Sync/Switch/fw-v21.0.0/Firmware ..\..\emulators\citron\user\nand\system\Contents\registered --progress
echo.
rclone sync ..\..\emulators\citron\user\nand\system\Contents\registered ..\..\emulators\eden\user\nand\system\Contents\registered --progress
echo.
rclone sync ..\..\emulators\citron\user\nand\system\Contents\registered ..\..\emulators\sudachi\user\nand\system\Contents\registered --progress
echo.
rclone sync ..\..\emulators\citron\user\nand\system\Contents\registered ..\..\emulators\suyu\user\nand\system\Contents\registered --progress
echo.
rclone sync ..\..\emulators\citron\user\nand\system\Contents\registered ..\..\emulators\yuzu\user\nand\system\Contents\registered --progress
echo.
timeout /t 1 >nul

REM This section checks for the updated Switch Keys...
del /Q switch_keys_v21.0.0.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/BIOS_Updates/switch_keys_v21.0.0.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x switch_keys_v21.0.0.7z -aoa -p22446688 -o..\..\emulators\citron\user\keys\ >nul 2>&1
7z x switch_keys_v21.0.0.7z -aoa -p22446688 -o..\..\emulators\eden\user\keys\ >nul 2>&1
7z x switch_keys_v21.0.0.7z -aoa -p22446688 -o..\..\emulators\sudachi\user\keys\ >nul 2>&1
7z x switch_keys_v21.0.0.7z -aoa -p22446688 -o..\..\emulators\suyu\user\keys\ >nul 2>&1
7z x switch_keys_v21.0.0.7z -aoa -p22446688 -o..\..\emulators\yuzu\user\keys\ >nul 2>&1
7z x switch_keys_v21.0.0.7z -aoa -p22446688 -o..\..\saves\switch\ryujinx\portable\system\ >nul 2>&1
echo.
timeout /t 1 >nul
del /Q switch_keys_v21.0.0.7z >nul 2>&1
timeout /t 1 >nul

:SKIP
REM This section updates Firmware for Ryujinx...
IF EXIST "Ryujinx-FW-v21.0.0" goto SKIP
del /Q switch_fw_v21.0.0.7z >nul 2>&1
timeout /t 1 >nul
rmdir /S /Q ..\..\saves\switch\ryujinx\portable\bis\system\Contents\registered >nul 2>&1
timeout /t 1 >nul
mkdir ..\..\saves\switch\ryujinx\portable\bis\system\Contents\registered >nul 2>&1
timeout /t 1 >nul
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/BIOS_Updates/switch_fw_v21.0.0.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
7z x switch_fw_v21.0.0.7z -aoa -p22446688 -o..\..\saves\switch\ryujinx\portable\bis\system\Contents\registered\ >nul 2>&1
timeout /t 1 >nul
del /Q switch_fw_v21.0.0.7z >nul 2>&1
echo Ryujinx-FW-v21.0.0 > Ryujinx-FW-v21.0.0
timeout /t 1 >nul

:SKIP
REM This section cleans up old folders and firmware etc...
rmdir /S /Q ..\..\emulators\citron\fw_prodkey >nul 2>&1
rmdir /S /Q ..\..\emulators\suyu\user\Firmware.19.0.1 >nul 2>&1
rmdir /S /Q ..\..\saves\switch\ryujinx\portable\Firmware.19.0.1 >nul 2>&1
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the Clone Hero Emulator...
echo.
echo Checking the Clone Hero Emulator...
echo.
timeout /t 1 >nul
IF EXIST "clonehero-emu-v1" goto SKIP
del /Q clonehero_mar2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/clonehero_mar2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x clonehero_mar2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\clonehero >nul 2>&1
echo.
echo Copying files...
xcopy clonehero ..\..\emulators\clonehero\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q clonehero_mar2025.7z >nul 2>&1
rmdir /S /Q clonehero >nul 2>&1
echo clonehero-emu-v1 > clonehero-emu-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section adds the Windows 98 support files...
echo Checking for the Windows 98 support files...
echo.
REM ----------------RetroArch-------------------
timeout /t 1 >nul
del /Q Win98-Retroarch.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/Win98-Retroarch.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
7z x Win98-Retroarch.7z -aoa -p22446688 -o.\ >nul 2>&1
echo.
echo Copying files...
xcopy retroarch ..\..\emulators\retroarch\ /S /E /I /Q /H /Y /R >nul 2>&1
del /Q Win98-Retroarch.7z >nul 2>&1
rmdir /S /Q retroarch >nul 2>&1
REM ----------------Decorations--------------------
echo.
timeout /t 1 >nul
del /Q Win98-Decorations.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Other_Updates/Win98-Decorations.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
7z x Win98-Decorations.7z -aoa -p22446688 -o.\ >nul 2>&1
echo.
echo Copying files...
xcopy decorations ..\..\system\decorations\ /S /E /I /Q /H /Y /R >nul 2>&1
del /Q Win98-Decorations.7z >nul 2>&1
rmdir /S /Q decorations >nul 2>&1
REM ----------------Win98-End---------------------
echo win98-bios-v2 > win98-bios-v2
:SKIP
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section fixes TriForce Games...
echo.
echo Updating config for TriForce Games...
echo.
timeout /t 1 >nul
IF EXIST "TriForce-Config-v1" goto SKIP
del /Q TriForce-Game-Settings.zip >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/TriForce-Game-Settings.zip >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x TriForce-Game-Settings.zip -aoa -o..\..\emulators\dolphin-triforce\User\GameSettings\ >nul 2>&1
echo.
timeout /t 1 >nul
del /Q TriForce-Game-Settings.zip >nul 2>&1
echo TriForce-Config-v1 > TriForce-Config-v1
:SKIP
echo.
timeout /t 1 >nul

REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM ************************************************************************* This section applies ROMpack Hotfixes ***************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

CLS
REM This section removes old files that are not needed for the IGT Slots ROMpack...
timeout /t 1 >nul
ren ..\..\roms\igtslots\fruitmach.pc\_Emu_Clean_\autorun.cmd autorun.old >nul 2>&1
ren ..\..\roms\igtslots\fruitmach.pc\autorun.cmd autorun.old >nul 2>&1
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section removes the shortname entires from the gamelist files...
echo.
timeout /t 2 >nul
echo Checking for incorrect shortnames, please wait...
powershell -ExecutionPolicy Bypass -File ".\Scripts\Fix-RetrobatShortname.ps1"
echo.
timeout /t 2 >nul
echo Check complete...
echo.
REM *******************************************************************************************************************************************************************************************

REM This section removes old EPIC and Steam shortcuts...
echo Removing old EPIC and Steam shortcuts...
echo.
timeout /t 2 >nul
powershell -ExecutionPolicy Bypass -File ".\Scripts\Remove-Epic-Steam-Shortcuts.ps1"
timeout /t 1 >nul

REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM ************************************************************************ This section adds BIOS files as required *************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

echo.
echo Adding new BIOS files as required...
echo.
timeout /t 1 >nul
rclone copy PixN-Themes-SH:/update/RetroBat/BIOS_Updates/Sync/bios ..\..\bios --progress --ignore-existing
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section downloads addidtional BIOS files for the Dolphin Emulator...
echo Checking addidtional BIOS files for the Dolphin Emulator...
echo.
timeout /t 1 >nul
IF EXIST "dolphin-bios-v1" goto SKIP
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/BIOS_Updates/Dolphin-Extra-Bios.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x Dolphin-Extra-Bios.7z -aoa -p22446688 -o.\ >nul 2>&1
echo Copying files...
echo.
xcopy Dolphin-Extra-Bios\emulators\dolphin-emu\User ..\..\emulators\dolphin-emu\User\ /s /y /d >nul 2>&1
xcopy Dolphin-Extra-Bios\saves\dolphin ..\..\saves\dolphin\ /s /y /d >nul 2>&1
echo.
timeout /t 2 >nul
rmdir /S /Q "Dolphin-Extra-Bios" >nul 2>&1
del /Q Dolphin-Extra-Bios.7z >nul 2>&1
timeout /t 1 >nul
echo dolphin-bios-v1 > dolphin-bios-v1
:SKIP
echo.
timeout /t 1 >nul

REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM ************************************************************** This section applies config based on the version of RetroBat ***************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

CLS
IF EXIST "..\..\system\version.info" goto CHECKv8
REM IF NOT EXIST "..\..\system\version.info" goto WARNING
:WARNING
    color E
    echo.
    echo ###############################################
    echo #                                             #
    echo #    WARNING! Version Info file not found!    #
    echo #  Unable to determine your RetroBat version  #
    echo #                                             #
    echo #        Skipping to the Theme Updates        #
    echo #                                             #
    echo ###############################################
    echo.
timeout /t 2 >nul
CLS
goto THEMES

:CHECKv8
>nul find "8." ..\..\system\version.info && (
  echo You are running RetroBat v8.x...
  echo.
  goto CONFIGUREv8
) || (
  goto CHECKv7
)

:CHECKv7
>nul find "7." ..\..\system\version.info && (
  echo You are running RetroBat v7.x...
  echo.
  goto CONFIGUREv7
) || (
  goto CHECKv6
)

:CHECKv6
>nul find "6." ..\..\system\version.info && (
  echo You are running RetroBat v6.x...
  echo.
  goto CONFIGUREv6
) || (
  goto THEMES
)

:CONFIGUREv8
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *********************************************************************************** Configure RB v8.x *************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

echo.
echo Configuring v8.x
echo.

REM This section removes old custom system config files that are no longer needed...
echo.
echo Cleaning up old config files...
echo.
timeout /t 1 >nul
del /Q ..\..\emulationstation\.emulationstation\es_systems_cgenius.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_cdogs.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_corsixth.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_3ds.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_tg-16.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_examu.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_segalindbergh.cfg >nul 2>&1
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section pulls down the latest custom system config files for RB v8.x...
echo Updating system config files...
echo.
timeout /t 1 >nul
..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/PixelNostalgia/PixN-RBv8.x-Custom-Systems.git
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo.
	echo Download Completed Successfully...
)
move /Y ".\PixN-RBv8.x-Custom-Systems\.emulationstation\*.cfg" ..\..\emulationstation\.emulationstation\ >nul 2>&1
rmdir /S /Q ".\PixN-RBv8.x-Custom-Systems" >nul 2>&1
:SKIP
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM Renaming game folders...
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
timeout /t 2 >nul
REM *******************************************************************************************************************************************************************************************

REM This section updates the PS3 m3u files as required...
echo.
echo Updating PS3 m3u files as required...
echo.
timeout /t 1 >nul
IF EXIST "PS3-m3u-update-v1" goto SKIP
REM Backup files...
7z a "..\..\emulators\pixn\PS3-M3U-PixN-Backup.zip" "..\..\roms\ps3\*.m3u" >nul 2>&1
for %%i in (..\..\roms\ps3\*.m3u) do cscript replace.vbs "%%i" "\dev_hdd0\" "SAVESPATH\dev_hdd0\" > nul
timeout /t 1 >nul
for %%i in (..\..\roms\ps3\*.m3u) do cscript replace.vbs "%%i" "SAVESPATHSAVESPATH\" "SAVESPATH\" > nul
timeout /t 1 >nul
for %%i in (..\..\roms\ps3\*.m3u) do cscript replace.vbs "%%i" "SAVESPATHSAVESPATHSAVESPATH\" "SAVESPATH\" > nul
timeout /t 2 >nul
echo PS3-m3u-update-v1 > PS3-m3u-update-v1
echo.
del /Q replace.vbs >nul 2>&1
:SKIP
REM *******************************************************************************************************************************************************************************************

:CHECKv8.1+
>nul findstr /l /c:"8.1" /c:"8.2" /c:"8.3" /c:"8.4" /c:"8.5" /c:"8.6" /c:"8.7" /c:"8.8" /c:"8.9" ..\..\system\version.info && (
  echo You are running RetroBat v8.1 or higher...
  echo.
  goto CONFIGUREv8.1+
) || (
  goto THEMES
)

:CONFIGUREv8.1+
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *********************************************************************************** Configure RB v8.1+ ************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

goto THEMES


:CONFIGUREv7
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *********************************************************************************** Configure RB v7.x *************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

echo.
echo Configuring v7.x
echo.

REM This section removes old custom system config files that are no longer needed in RBv7.x...
echo.
echo Cleaning up old config files...
echo.
timeout /t 1 >nul
del /Q ..\..\emulationstation\.emulationstation\es_systems_cgenius.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_cdogs.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_corsixth.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_3ds.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_tg-16.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_examu.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_segalindbergh.cfg >nul 2>&1
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated Hypseus Emulator...
echo Checking for the updated Hypseus Emulator...
echo.
timeout /t 1 >nul

IF EXIST "Hypseus-v1" goto SKIP
del /Q hypseus.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/hypseus.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x hypseus.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\hypseus >nul 2>&1
echo.
echo Copying files...
xcopy hypseus ..\..\emulators\hypseus\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q hypseus.7z >nul 2>&1
rmdir /S /Q hypseus >nul 2>&1

echo Hypseus-v1 > Hypseus-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for Solarus emulator updates...
echo.
echo Checking for Solarus emulator updates...
echo.
timeout /t 1 >nul
IF EXIST "solarus-emu-v1" goto SKIP
del /Q solarus-v2.0.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/solarus-v2.0.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x solarus-v2.0.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\solarus >nul 2>&1
echo.
echo Copying files...
xcopy solarus ..\..\emulators\solarus\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q solarus-v2.0.7z >nul 2>&1
rmdir /S /Q solarus >nul 2>&1
echo solarus-emu-v1 > solarus-emu-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section adds the new Emulators required for RBv7.x...
echo Adding the new Emulators required for RetroBat v7.x...
echo.

REM This section checks for the updated cGenius Emulator...
echo.
echo Checking for the updated cGenius Emulator...
echo.
timeout /t 1 >nul
IF EXIST "cgenius-emu-v1" goto SKIP
del /Q cgenius_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/cgenius_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x cgenius_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\cgenius >nul 2>&1
echo.
echo Copying files...
xcopy cgenius ..\..\emulators\cgenius\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q cgenius_feb2025.7z >nul 2>&1
rmdir /S /Q cgenius >nul 2>&1
echo cgenius-emu-v1 > cgenius-emu-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated Kronos Emulator...
echo Checking for the updated Kronos Emulator...
echo.
timeout /t 1 >nul
IF EXIST "kronos-emu-v1" goto SKIP
del /Q kronos_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/kronos_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x kronos_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\kronos >nul 2>&1
echo.
echo Copying files...
xcopy kronos ..\..\emulators\kronos\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q kronos_feb2025.7z >nul 2>&1
rmdir /S /Q kronos >nul 2>&1
echo kronos-emu-v1 > kronos-emu-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated Lime3DS Emulator...
echo Checking for the updated Lime3DS Emulator...
echo.
timeout /t 1 >nul
IF EXIST "lime3ds-emu-v1" goto SKIP
del /Q lime3ds_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/lime3ds_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x lime3ds_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\lime3ds >nul 2>&1
echo.
echo Copying files...
xcopy lime3ds ..\..\emulators\lime3ds\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q lime3ds_feb2025.7z >nul 2>&1
rmdir /S /Q lime3ds >nul 2>&1
echo lime3ds-emu-v1 > lime3ds-emu-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated MagicEngine Emulator...
echo Checking for the updated MagicEngine Emulator...
echo.
timeout /t 1 >nul
IF EXIST "magicengine-emu-v1" goto SKIP
del /Q magicengine_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/magicengine_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x magicengine_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\magicengine >nul 2>&1
echo.
echo Copying files...
xcopy magicengine ..\..\emulators\magicengine\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q magicengine_feb2025.7z >nul 2>&1
rmdir /S /Q magicengine >nul 2>&1
echo magicengine-emu-v1 > magicengine-emu-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated Mandarine Emulator...
echo Checking for the updated Mandarine Emulator...
echo.
timeout /t 1 >nul
IF EXIST "mandarine-emu-v1" goto SKIP
del /Q mandarine_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/mandarine_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x mandarine_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\mandarine >nul 2>&1
echo.
echo Copying files...
xcopy mandarine ..\..\emulators\mandarine\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q mandarine_feb2025.7z >nul 2>&1
rmdir /S /Q mandarine >nul 2>&1
echo mandarine-emu-v1 > mandarine-emu-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated OpenJazz Emulator...
echo Checking for the updated OpenJazz Emulator...
echo.
timeout /t 1 >nul
IF EXIST "openjazz-emu-v1" goto SKIP
del /Q openjazz_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/openjazz_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x openjazz_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\openjazz >nul 2>&1
echo.
echo Copying files...
xcopy openjazz ..\..\emulators\openjazz\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q openjazz_feb2025.7z >nul 2>&1
rmdir /S /Q openjazz >nul 2>&1
echo openjazz-emu-v1 > openjazz-emu-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated PDark Emulator...
echo Checking for the updated PDark Emulator...
echo.
timeout /t 1 >nul
IF EXIST "pdark-emu-v1" goto SKIP
del /Q pdark_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/pdark_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x pdark_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\pdark >nul 2>&1
echo.
echo Copying files...
xcopy pdark ..\..\emulators\pdark\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q pdark_feb2025.7z >nul 2>&1
rmdir /S /Q pdark >nul 2>&1
echo pdark-emu-v1 > pdark-emu-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated Xenia Emulator...
echo Checking for the updated Xenia Emulator...
echo.
timeout /t 1 >nul
IF EXIST "xenia-emu-v2" goto SKIP
del /Q xenia_Aug20-2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/xenia_Aug20-2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x xenia_Aug20-2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\xenia >nul 2>&1
echo.
echo Copying files...
xcopy xenia ..\..\emulators\xenia\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q xenia_Aug20-2025.7z >nul 2>&1
rmdir /S /Q xenia >nul 2>&1
echo xenia-emu-v2 > xenia-emu-v2
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated Xenia-Canary Emulator...
echo Checking for the updated Xenia-Canary Emulator...
echo.
timeout /t 1 >nul
IF EXIST "xenia-canary-emu-v2" goto SKIP
del /Q xenia-canary_Oct06-2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/xenia-canary_Oct06-2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x xenia-canary_Oct06-2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\xenia-canary >nul 2>&1
echo.
echo Copying files...
xcopy xenia-canary ..\..\emulators\xenia-canary\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q xenia-canary_Oct06-2025.7z >nul 2>&1
rmdir /S /Q xenia-canary >nul 2>&1
echo xenia-canary-emu-v2 > xenia-canary-emu-v2
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated Xenia-Manager Emulator...
echo Checking for the updated Xenia-Manager Emulator...
echo.
timeout /t 1 >nul
IF EXIST "xenia-manager-emu-v1" goto SKIP
del /Q xenia-manager_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/xenia-manager_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x xenia-manager_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\xenia-manager >nul 2>&1
echo.
echo Copying files...
xcopy xenia-manager ..\..\emulators\xenia-manager\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q xenia-manager_feb2025.7z >nul 2>&1
rmdir /S /Q xenia-manager >nul 2>&1
echo xenia-manager-emu-v1 > xenia-manager-emu-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated Yabasanshiro Emulator...
echo Checking for the updated Yabasanshiro Emulator...
echo.
timeout /t 1 >nul
IF EXIST "yabasanshiro-emu-v1" goto SKIP
del /Q yabasanshiro_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/yabasanshiro_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x yabasanshiro_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\yabasanshiro >nul 2>&1
echo.
echo Copying files...
xcopy yabasanshiro ..\..\emulators\yabasanshiro\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q yabasanshiro_feb2025.7z >nul 2>&1
rmdir /S /Q yabasanshiro >nul 2>&1
echo yabasanshiro-emu-v1 > yabasanshiro-emu-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM Download MAME Samples...
echo.
echo Checking for missing MAME Samples...
echo.
rclone copy PixN-Themes-SH:/update/Batocera/bios/mame/samples ..\..\saves\mame\samples --progress --ignore-existing
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section pulls down the latest custom system config files for RBv7.x...
echo Updating system config files...
echo.
timeout /t 1 >nul
..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/PixelNostalgia/PixN-RBv7.x-Custom-Systems.git
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo.
	echo Download Completed Successfully...
	echo.
)
move /Y ".\PixN-RBv7.x-Custom-Systems\.emulationstation\*.cfg" ..\..\emulationstation\.emulationstation\ >nul 2>&1
rmdir /S /Q ".\PixN-RBv7.x-Custom-Systems" >nul 2>&1
:SKIP
timeout /t 1 >nul
echo.
REM *******************************************************************************************************************************************************************************************

:CHECKv7.2+
>nul findstr /l /c:"7.2" /c:"7.3" /c:"7.4" /c:"7.5" /c:"7.6" /c:"7.7" /c:"7.8" /c:"7.9" ..\..\system\version.info && (
  echo You are running RetroBat v7.2 or higher...
  echo.
  goto CONFIGUREv7.2+
) || (
  goto THEMES
)

:CONFIGUREv7.2+
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *********************************************************************************** Configure RB v7.2+ ************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

echo.
REM Renaming game folders...
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
timeout /t 2 >nul
del /Q replace.vbs >nul 2>&1
REM *******************************************************************************************************************************************************************************************

REM This section fixes TriForce Games...
echo.
echo Updating config for TriForce Games...
echo.
timeout /t 1 >nul
IF EXIST "TriForce-Config-v1" goto SKIP
del /Q TriForce-Game-Settings.zip >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/TriForce-Game-Settings.zip >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x TriForce-Game-Settings.zip -aoa -o..\..\emulators\dolphin-triforce\User\GameSettings\ >nul 2>&1
echo.
timeout /t 1 >nul
del /Q TriForce-Game-Settings.zip >nul 2>&1
echo TriForce-Config-v1 > TriForce-Config-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

:CHECKv7.3+
>nul findstr /l /c:"7.3" /c:"7.4" /c:"7.5" /c:"7.6" /c:"7.7" /c:"7.8" /c:"7.9" ..\..\system\version.info && (
  echo You are running RetroBat v7.3 or higher...
  echo.
  goto CONFIGUREv7.3+
) || (
  goto THEMES
)

:CONFIGUREv7.3+
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *********************************************************************************** Configure RB v7.3+ ************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

REM This section adds the new Emulators required for RetroBat v7.3 and higher
echo.
echo Adding the new Emulators required for RetroBat v7.3 and higher...
echo.
timeout /t 1 >nul

IF EXIST "rb-7.3+emulators_11-08-2025" goto SKIP
timeout /t 1 >nul
echo.
del /Q rb-7.3+emulators_11-08-2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/rb-7.3+emulators_11-08-2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x rb-7.3+emulators_11-08-2025.7z -aoa -p22446688 -o..\..\emulators\ >nul 2>&1
echo.
timeout /t 1 >nul
del /Q rb-7.3+emulators_11-08-2025.7z >nul 2>&1
echo rb-7.3+emulators_11-08-2025 > rb-7.3+emulators_11-08-2025
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

:CHECKv7.5+
>nul findstr /l /c:"7.5" /c:"7.6" /c:"7.7" /c:"7.8" /c:"7.9" ..\..\system\version.info && (
  echo You are running RetroBat v7.5 or higher...
  echo.
  goto CONFIGUREv7.5+
) || (
  goto THEMES
)

:CONFIGUREv7.5+
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *********************************************************************************** Configure RB v7.5+ ************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

REM This section adds the new files/config required for RetroBat v7.5 and higher

goto THEMES

:CONFIGUREv6
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *********************************************************************************** Configure RB v6.x *************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

echo.
echo Configuring v6.x
echo.

REM This section removes old custom system config files that are no longer needed...
echo.
echo Cleaning up old config files...
echo.
timeout /t 1 >nul
del /Q ..\..\emulationstation\.emulationstation\es_systems_tg-16.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_examu.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_segalindbergh.cfg >nul 2>&1
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for the updated Hypseus Emulator...
echo Checking for the updated Hypseus Emulator...
echo.
timeout /t 1 >nul

IF EXIST "Hypseus-v1" goto SKIP
del /Q hypseus.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/hypseus.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x hypseus.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\hypseus >nul 2>&1
echo.
echo Copying files...
xcopy hypseus ..\..\emulators\hypseus\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q hypseus.7z >nul 2>&1
rmdir /S /Q hypseus >nul 2>&1

echo Hypseus-v1 > Hypseus-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section checks for Solarus emulator updates...
echo.
echo Checking for Solarus emulator updates...
echo.
timeout /t 1 >nul
IF EXIST "solarus-emu-v1" goto SKIP
del /Q solarus-v2.0.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/solarus-v2.0.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
7z x solarus-v2.0.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\solarus >nul 2>&1
echo.
echo Copying files...
xcopy solarus ..\..\emulators\solarus\ /S /E /I /Q /H /Y /R >nul 2>&1
timeout /t 1 >nul
del /Q solarus-v2.0.7z >nul 2>&1
rmdir /S /Q solarus >nul 2>&1
echo solarus-emu-v1 > solarus-emu-v1
:SKIP
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section pulls down the latest custom system config files for RBv6.x...
echo Updating system config files...
echo.
timeout /t 1 >nul
..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/PixelNostalgia/PixN-RBv6.x-Custom-Systems.git >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo.
	echo Download Completed Successfully...
	echo.
)
move /Y ".\PixN-RBv6.x-Custom-Systems\.emulationstation\*.cfg" ..\..\emulationstation\.emulationstation\ >nul 2>&1
rmdir /S /Q ".\PixN-RBv6.x-Custom-Systems" >nul 2>&1
:SKIP
timeout /t 1 >nul
echo.
REM *******************************************************************************************************************************************************************************************

REM Download MAME Samples...
echo.
echo Checking for missing MAME Samples...
echo.
rclone copy PixN-Themes-SH:/update/Batocera/bios/mame/samples ..\..\saves\mame\samples --progress --ignore-existing
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section pulls down the latest es-checkversion script...
echo.
echo Updating es-checkversion script if required...
echo.
timeout /t 1 >nul
IF EXIST "es-checkversion-v1" goto SKIP
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/es-checkversion-v6.4.cmd -O es-checkversion.cmd >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo.
	echo Download Completed Successfully...
	echo.
)
move /Y "es-checkversion.cmd" ..\..\emulationstation\ >nul 2>&1
timeout /t 1 >nul
echo es-checkversion-v1 > es-checkversion-v1
:SKIP
echo.
timeout /t 1 >nul
goto THEMES


:THEMES
REM This section updates the PixN Themes...

REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM ************************************************************************************* Themes Section **************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

set "colorCode=A"
color %colorCode%
cls
echo Checking for theme updates...
echo.
timeout /t 1 >nul
del /Q "Full Download - Hypermax Plus PixN.bat" >nul 2>&1
del /Q "Full Download - Alekfull-ARTFLIX-PixN.bat" >nul 2>&1
del /Q "Full Download - Carbon-PixN.bat" >nul 2>&1
del /Q "Full Download - Ckau Book PixN.bat" >nul 2>&1
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section removes the HyperMax-Lite-PixN Theme...
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

cscript replace.vbs "..\..\emulationstation\.emulationstation\es_settings.cfg" "Hypermax-Lite-PixN" "Hypermax-Plus-PixN" > NUL
timeout /t 2 >nul
REM *******************************************************************************************************************************************************************************************

REM This section removes the old ckau-book-rgs Theme...
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

cscript replace.vbs "..\..\emulationstation\.emulationstation\es_settings.cfg" "ckau-book-rgs" "ckau-book-PixN" > NUL
timeout /t 2 >nul
REM *******************************************************************************************************************************************************************************************

cls
echo.
echo Checking for theme updates...

echo.
echo #########################################################
echo #                                                       #
echo #                   REMEMBER.........                   #
echo #      IF YOU HAVE PAID ANY FORM OF MONEY FOR THIS      #
echo #     OR ANY OTHER TEAM PIXEL NOSTALGIA / RGS BUILD     #
echo #                DEMAND YOUR MONEY BACK!                #
echo #                                                       #
echo #         THIS BUILD IS FREELY AVAILABLE TO ALL         #
echo #                VIA OUR DISCORD SERVER:                #
echo #                                                       #
echo #             https://discord.gg/xNxrAr6sGv             #
echo #                                                       #
echo #########################################################
echo.

timeout /t 1 >nul
echo Checking Hypermax-Plus-PixN for updates...
echo.
timeout /t 1 >nul
rclone sync PixN-Themes-SH:/update/Themes/Hypermax-Plus-PixN ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN --exclude=/_inc/videos/** --progress
md "..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\videos" >nul 2>&1

echo.
echo Checking Carbon-PixN for updates...
echo.
timeout /t 1 >nul
rclone sync PixN-Themes-SH:/update/Themes/Carbon-PixN ..\..\emulationstation\.emulationstation\themes\Carbon-PixN --progress

echo.
echo Checking Ckau-Book-PixN for updates...
echo.
timeout /t 1 >nul
rclone sync PixN-Themes-SH:/update/Themes/ckau-book-PixN ..\..\emulationstation\.emulationstation\themes\ckau-book-PixN --progress

echo.
echo Checking Ckau-Book for updates...
echo.
timeout /t 1 >nul
rclone sync PixN-Themes-SH:/update/Themes/ckau-book ..\..\emulationstation\.emulationstation\themes\ckau-book --progress
echo.
REM *******************************************************************************************************************************************************************************************

REM Sync latest Decorations/Bezels...
echo.
echo Checking for updated/missing Decorations/Bezels...
echo.
REM wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/decorations/mybezels16-9/default.info >nul 2>&1
REM wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/decorations/mybezels16-9/default.png >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/decorations/mybezels16-9/neogeo.png >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/decorations/mybezels16-9/mame.png >nul 2>&1
REM move /Y default.info ..\..\decorations\thebezelproject\ >nul 2>&1
REM move /Y default.png ..\..\decorations\thebezelproject\ >nul 2>&1
move /Y neogeo.png ..\..\decorations\thebezelproject\systems\ >nul 2>&1
move /Y mame.png ..\..\decorations\thebezelproject\systems\ >nul 2>&1
timeout /t 1 >nul
REM ren ..\..\decorations\thebezelproject\default.info PixN-Bezel.info >nul 2>&1
REM ren ..\..\decorations\thebezelproject\default.png PixN-Bezel.png >nul 2>&1
del /Q ..\..\decorations\thebezelproject\default.info >nul 2>&1
del /Q ..\..\decorations\thebezelproject\default.png >nul 2>&1
del /Q ..\..\decorations\thebezelproject\PixN-Bezel.info >nul 2>&1
del /Q ..\..\decorations\thebezelproject\PixN-Bezel.png >nul 2>&1
rclone copy PixN-Themes-SH:/update/decorations/mybezels16-9/games ..\..\decorations\thebezelproject\games --progress --ignore-existing
rclone copy PixN-Themes-SH:/update/decorations/mybezels16-9/systems ..\..\decorations\thebezelproject\systems --progress --ignore-existing
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM Sync MAME Artwork...
echo.
echo Checking for updated/missing MAME Artwork...
echo.
rclone copy PixN-Themes-SH:/update/Batocera/bios/mame/artwork ..\..\saves\mame\artwork --progress --ignore-existing
echo.
timeout /t 1 >nul
REM *******************************************************************************************************************************************************************************************

REM Apply the PixB Spash video...
echo.
timeout /t 1 >nul
REM IF EXIST "Set-PixN-Splash-v2" goto SKIP
IF EXIST "pixnretrodeck-ally-v1" goto SKIP
IF EXIST "pixnretrodeck-steamdeck-v1" goto SKIP

wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/PixN-Splash-1.mp4 >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
timeout /t 1 >nul
echo.
move /Y "PixN-Splash-1.mp4" ..\..\emulationstation\.emulationstation\video\ >nul 2>&1
timeout /t 1 >nul
echo Set-PixN-Splash-v2 > Set-PixN-Splash-v2
echo.
timeout /t 1 >nul

setlocal
REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\retrobat.ini"
REM Backup the original file
copy "%filePath%" "%filePath%.bak" >nul 2>&1
REM Replace or insert INI settings
powershell -ExecutionPolicy Bypass -Command ^
    "$path = '%filePath%';" ^
    "$settings = @{ 'EnableIntro' = 'EnableIntro=1';" ^
    "              'FileName' = 'FileName=\"PixN-Splash-1.mp4\"';" ^
    "              'FilePath' = 'FilePath=\"default\"';" ^
    "              'RandomVideo' = 'RandomVideo=0';" ^
    "              'VideoDuration' = 'VideoDuration=7000' };" ^
    "$lines = Get-Content $path;" ^
    "foreach ($key in $settings.Keys) {" ^
    "  if ($lines -match \"^$key=\") {" ^
    "    $lines = $lines -replace \"^$key=.*\", $settings[$key]" ^
    "  } else {" ^
    "    $lines += $settings[$key]" ^
    "  }" ^
    "};" ^
    "$lines | Set-Content $path"
endlocal
:SKIP

REM *******************************************************************
REM *******************************************************************
REM **************************RetroDeck Config*************************
REM *******************************************************************
REM *******************************************************************

IF NOT EXIST "pixnretrodeck-ally-v1" goto SKIP-ALLY
echo.
echo Applying RetroDeck Ally updates...
echo.
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Other_Updates/Block-StartAllBack.cmd >nul 2>&1
echo.
del /Q pixnretrodeck.svg >nul 2>&1
del /Q pixnretrodeck-ally.svg >nul 2>&1
del /Q pixnretrodeck-hyper-silver.png >nul 2>&1
del /Q pixnretrodeck-hyper-system.png >nul 2>&1
del /Q pixnretrodeck-hyper-system1.png >nul 2>&1
del /Q pixnretrodeck-hyper-system2.png >nul 2>&1
timeout /t 1 >nul
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck-ally.svg >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck-hyper-silver.png >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck-hyper-system.png >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck-hyper-system1.png >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck-hyper-system2.png >nul 2>&1

copy /Y pixnretrodeck-ally.svg ..\..\emulationstation\.emulationstation\themes\Carbon-PixN\art\logos\retrobat.svg >nul 2>&1
copy /Y pixnretrodeck-ally.svg ..\..\emulationstation\.emulationstation\themes\Carbon-PixN\art\logos\retrobat-w.svg >nul 2>&1

copy /Y pixnretrodeck-ally.svg ..\..\emulationstation\.emulationstation\themes\ckau-book-PixN\_inc\logos\retrobat.svg >nul 2>&1
copy /Y pixnretrodeck-ally.svg ..\..\emulationstation\.emulationstation\themes\ckau-book-PixN\_inc\logos\retrobat-w.svg >nul 2>&1

copy /Y pixnretrodeck-ally.svg ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\logos\retrobat.svg >nul 2>&1
copy /Y pixnretrodeck-ally.svg ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\logos\retrobat-w.svg >nul 2>&1
copy /Y pixnretrodeck-ally.svg ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\menu\logos\retrobat.svg >nul 2>&1
copy /Y pixnretrodeck-ally.svg ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\menu\logos\retrobat-w.svg >nul 2>&1
copy /Y pixnretrodeck-hyper-silver.png ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\menu\silver\retrobat.png >nul 2>&1
copy /Y pixnretrodeck-hyper-system.png ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\retrobat\_inc\system.png >nul 2>&1
copy /Y pixnretrodeck-hyper-system1.png ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\retrobat\_inc\system1.png >nul 2>&1
copy /Y pixnretrodeck-hyper-system2.png ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\retrobat\_inc\system2.png >nul 2>&1
timeout /t 1 >nul
del /Q pixnretrodeck.svg >nul 2>&1
del /Q pixnretrodeck-ally.svg >nul 2>&1
del /Q pixnretrodeck-hyper-silver.png >nul 2>&1
del /Q pixnretrodeck-hyper-system.png >nul 2>&1
del /Q pixnretrodeck-hyper-system1.png >nul 2>&1
del /Q pixnretrodeck-hyper-system2.png >nul 2>&1

echo.
echo Updating Music...
echo.
timeout /t 1 >nul
rclone sync PixN-Themes-SH:/update/Music/RetroDeck ..\..\emulationstation\.emulationstation\music --progress


:SKIP-ALLY

IF NOT EXIST "pixnretrodeck-steamdeck-v1" goto SKIP-SDLCD
echo.
echo Applying RetroDeck SteamDeck LCD updates...
echo.
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Other_Updates/Block-StartAllBack.cmd >nul 2>&1
echo.
del /Q pixnretrodeck.svg >nul 2>&1
del /Q pixnretrodeck-steamdecklcd.svg >nul 2>&1
del /Q pixnretrodeck-hyper-silver.png >nul 2>&1
del /Q pixnretrodeck-hyper-system.png >nul 2>&1
del /Q pixnretrodeck-hyper-system1.png >nul 2>&1
del /Q pixnretrodeck-hyper-system2.png >nul 2>&1
timeout /t 1 >nul
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck-steamdecklcd.svg >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck-hyper-silver.png >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck-hyper-system.png >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck-hyper-system1.png >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck-hyper-system2.png >nul 2>&1

copy /Y pixnretrodeck-steamdecklcd.svg ..\..\emulationstation\.emulationstation\themes\Carbon-PixN\art\logos\retrobat.svg >nul 2>&1
copy /Y pixnretrodeck-steamdecklcd.svg ..\..\emulationstation\.emulationstation\themes\Carbon-PixN\art\logos\retrobat-w.svg >nul 2>&1

copy /Y pixnretrodeck-steamdecklcd.svg ..\..\emulationstation\.emulationstation\themes\ckau-book-PixN\_inc\logos\retrobat.svg >nul 2>&1
copy /Y pixnretrodeck-steamdecklcd.svg ..\..\emulationstation\.emulationstation\themes\ckau-book-PixN\_inc\logos\retrobat-w.svg >nul 2>&1

copy /Y pixnretrodeck-steamdecklcd.svg ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\logos\retrobat.svg >nul 2>&1
copy /Y pixnretrodeck-steamdecklcd.svg ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\logos\retrobat-w.svg >nul 2>&1
copy /Y pixnretrodeck-steamdecklcd.svg ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\menu\logos\retrobat.svg >nul 2>&1
copy /Y pixnretrodeck-steamdecklcd.svg ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\menu\logos\retrobat-w.svg >nul 2>&1
copy /Y pixnretrodeck-hyper-silver.png ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\menu\silver\retrobat.png >nul 2>&1
copy /Y pixnretrodeck-hyper-system.png ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\retrobat\_inc\system.png >nul 2>&1
copy /Y pixnretrodeck-hyper-system1.png ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\retrobat\_inc\system1.png >nul 2>&1
copy /Y pixnretrodeck-hyper-system2.png ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\retrobat\_inc\system2.png >nul 2>&1
timeout /t 1 >nul
del /Q pixnretrodeck.svg >nul 2>&1
del /Q pixnretrodeck-steamdecklcd.svg >nul 2>&1
del /Q pixnretrodeck-hyper-silver.png >nul 2>&1
del /Q pixnretrodeck-hyper-system.png >nul 2>&1
del /Q pixnretrodeck-hyper-system1.png >nul 2>&1
del /Q pixnretrodeck-hyper-system2.png >nul 2>&1

echo.
echo Updating Music...
echo.
timeout /t 1 >nul
rclone sync PixN-Themes-SH:/update/Music/RetroDeck ..\..\emulationstation\.emulationstation\music --progress

:SKIP-SDLCD

REM *******************************************************************************************************************************************************************************************
:END
echo.
echo.
echo ##########################################################
echo #                                                        #
echo #           All done - Once this script closes           #
echo # please restart RetroBat for any changes to take effect #
echo #                                                        #
echo #                       Enjoy...                         #
echo #                                                        #
echo ##########################################################
echo.
timeout /t 5 >nul
cls
popd
exit