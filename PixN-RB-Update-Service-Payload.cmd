@echo off
title PixN Update Service v8.15
pushd %1
REM Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

REM Function to handle errors with a pause
set "handle_error=ping -n 4 127.0.0.1 >nul"

REM This section pulls down the PixN Update Service core files...
echo.
echo Checking PixN Update Service core files...
echo.
mkdir Scripts >nul 2>&1
mkdir Flags >nul 2>&1
mkdir RGSDownloadService >nul 2>&1
mkdir PortableGit >nul 2>&1
IF EXIST ".\Flags\pixn-core-files-v1" goto SKIP
del /Q pixn-core-files.7z >nul 2>&1
curl --insecure -O "http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Update_Service/- PixN_ReadMe.txt" >nul 2>&1
curl --insecure -O "http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Update_Service/7z.exe" >nul 2>&1
curl --insecure -O "http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Update_Service/7z.dll" >nul 2>&1
curl --insecure -O "http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Update_Service/pixn-core-files.7z" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download failed! - exiting...
    %handle_error%
	goto CORE-FILES-FAILED
) else (
    echo ...Download successful...
)
ping -n 1 127.0.0.1 >nul
echo.
echo Extracting files...
echo.
7z x pixn-core-files.7z -aoa -p22446688 -o..\..\emulators\pixn\ >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q pixn-core-files.7z >nul 2>&1
echo pixn-core-files-v1 > .\Flags\pixn-core-files-v1
ping -n 1 127.0.0.1 >nul
:SKIP

REM This section pulls down the latest PixN Scripts...
REM Cleanup...
rmdir /S /Q "logs" >nul 2>&1
del /Q PixN-Reset.cmd >nul 2>&1
del /Q Send-F11Fullscreen.ps1 >nul 2>&1
del /Q Add-PixNService.ps1 >nul 2>&1
del /Q Fix-RetrobatShortname.ps1 >nul 2>&1
del /Q Remove-Epic-Steam-Shortcuts.ps1 >nul 2>&1
del /Q AtariST-Settings.cmd >nul 2>&1
del /Q RB-v6-Settings.cmd >nul 2>&1
del /Q RB-v7-Settings.cmd >nul 2>&1
del /Q RB-v8-Settings.cmd >nul 2>&1
ping -n 2 127.0.0.1 >nul
REM Download Latest...
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/PixN-Reset.cmd -O .\Scripts\PixN-Reset.cmd >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/Move-Flags.cmd -O .\Scripts\Move-Flags.cmd >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/Send-F11Fullscreen.ps1 -O .\Scripts\Send-F11Fullscreen.ps1 >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/Add-PixNService.ps1 -O .\Scripts\Add-PixNService.ps1 >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/Fix-RetrobatShortname.ps1 -O .\Scripts\Fix-RetrobatShortname.ps1 >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/Remove-Epic-Steam-Shortcuts.ps1 -O .\Scripts\Remove-Epic-Steam-Shortcuts.ps1 >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/Set-DOSBoxBootFreeSpace.ps1 -O .\Scripts\Set-DOSBoxBootFreeSpace.ps1 >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/AtariST-Settings.cmd -O .\Scripts\AtariST-Settings.cmd >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/RB-v6-Settings.cmd -O .\Scripts\RB-v6-Settings.cmd >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/RB-v7-Settings.cmd -O .\Scripts\RB-v7-Settings.cmd >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/RB-v8-Settings.cmd -O .\Scripts\RB-v8-Settings.cmd >nul 2>&1
REM Script to send the window full screen
powershell -ExecutionPolicy Bypass -File ".\Scripts\Send-F11Fullscreen.ps1"

REM Move Flag files to new home...
start /wait .\Scripts\Move-Flags.cmd

REM Read from ASCII.txt and visualize ASCII art
type ASCII.txt

echo.
echo Pixel Nostalgia updater running...
echo Version 8.15
echo.
ping -n 3 127.0.0.1 >nul
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

ping -n 2 127.0.0.1 >nul
REM Text color code for Yellow is E
set "colorCode=E"
color %colorCode%
ping -n 2 127.0.0.1 >nul
REM Text color code for Light Green is A
set "colorCode=A"
color %colorCode%
ping -n 2 127.0.0.1 >nul
REM Text color code for Yellow is E
set "colorCode=E"
color %colorCode%
ping -n 2 127.0.0.1 >nul
REM Text color code for Light Green is A
set "colorCode=A"
color %colorCode%
ping -n 2 127.0.0.1 >nul
REM Text color code for Yellow is E
set "colorCode=E"
color %colorCode%
ping -n 2 127.0.0.1 >nul
REM Text color code for Light Green is A
set "colorCode=A"
color %colorCode%
cls

REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM ************************************************************ This first section applies config that is NOT version dependent **************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

REM *******************************************************************************************************************************************************************************************
REM This section pulls down the latest rClone config...
REM *******************************************************************************************************************************************************************************************

echo.
echo Updating rClone Configuration...
echo.
IF EXIST ".\Flags\rclone-v3" goto RC-END
del /Q rc.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/rc.7z -O rc.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...rClone download failed! - Skipping...
    %handle_error%
	goto RC-END
) else (
    echo ...rClone download successful...
)
ping -n 1 127.0.0.1 >nul
7z x rc.7z -aoa -p22446688 -o.\ >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q rc.7z >nul 2>&1
echo rclone-v3 > .\Flags\rclone-v3
:RC-END
ping -n 1 127.0.0.1 >nul
del /Q rclone.conf >nul 2>&1
ping -n 1 127.0.0.1 >nul
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/rclone.conf -O rclone.conf >nul 2>&1
ping -n 1 127.0.0.1 >nul
:SKIP

REM *******************************************************************************************************************************************************************************************
REM This section checks for Download Service Updates...
REM *******************************************************************************************************************************************************************************************

echo.
echo Checking for script updates...
ping -n 2 127.0.0.1 > nul
REM IF EXIST ".\Flags\PixN-DS-v0.13" goto SKIP
del /Q rgs_download_service_0.13.exe >nul 2>&1
del /Q rgs_download_service_0.12.exe >nul 2>&1
del /Q rgs_download_service_0.11.exe >nul 2>&1
del /Q rgs_download_service_0.10.exe >nul 2>&1
del /Q rgs_download_service_0.9.exe >nul 2>&1
del /Q rgs_download_service.exe >nul 2>&1
del /Q RGSDownloadService-Setup.exe >nul 2>&1
del /Q RGSDownloadService-Setup.exe.* >nul 2>&1
del /Q README.txt >nul 2>&1
del /Q "RGS Download Service - README.txt" >nul 2>&1
ping -n 2 127.0.0.1 > nul
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies "http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Update_Service/rgs_download_service_0.13.exe" >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies "http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Update_Service/RGS Download Service - README.txt" >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies "http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Update_Service/RGSDownloadService-Setup.exe" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    %handle_error%
	goto SKIP
) else (
    echo.
)
ping -n 2 127.0.0.1 > nul
ren rgs_download_service_0.13.exe rgs_download_service.exe >nul 2>&1
echo.
REM echo Copying files...
ping -n 2 127.0.0.1 > nul
net stop "RGS Download Service" >nul 2>&1
ping -n 5 127.0.0.1 > nul
move /Y "rgs_download_service.exe" ..\..\emulators\pixn\RGSDownloadService\ >nul 2>&1
move /Y "RGS Download Service - README.txt" ..\..\emulators\pixn\RGSDownloadService\ >nul 2>&1
ping -n 2 127.0.0.1 > nul
net start "RGS Download Service" >nul 2>&1

echo PixN-DS-v0.13 > .\Flags\PixN-DS-v0.13
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM *******************************************************************************************************************************************************************************************
REM This section pulls down the latest PixN Custom Collections...
REM *******************************************************************************************************************************************************************************************

echo.
echo Updating the PixN Custom Collections...
echo.
ping -n 1 127.0.0.1 >nul
rmdir /S /Q ".\PixN-Collections" >nul 2>&1
md "..\..\emulationstation\.emulationstation\collections" >nul 2>&1
..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/PixelNostalgia/PixN-Collections.git
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo.
	echo ...Download Completed Successfully...
)
move /Y ".\PixN-Collections\*.cfg" ..\..\emulationstation\.emulationstation\collections\ >nul 2>&1
rmdir /S /Q ".\PixN-Collections" >nul 2>&1
:SKIP
ping -n 1 127.0.0.1 >nul
echo.

REM *******************************************************************************************************************************************************************************************
REM This section restores the PixN Update Service artwork...
REM *******************************************************************************************************************************************************************************************

echo Checking if the PixN Update Service artwork needs restoring...
echo.
ping -n 1 127.0.0.1 >nul
powershell -ExecutionPolicy Bypass -File ".\Scripts\Add-PixNService.ps1"
echo.
ping -n 1 127.0.0.1 >nul
del /Q "pixn-rb-update-service-logo.png" >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/pixn-rb-update-service-logo.png -O pixn-rb-update-service-logo.png >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	got SKIP
) else (
    echo ...Download Completed Successfully...
)
move /Y "pixn-rb-update-service-logo.png" ..\..\system\es_menu\media\ >nul 2>&1
:SKIP
ping -n 1 127.0.0.1 >nul
echo.

REM *******************************************************************************************************************************************************************************************
REM This section cleans up from when the PixN Update Service was added to the system wheel...
REM rmdir /S /Q "..\..\roms\pixn" >nul 2>&1
REM *******************************************************************************************************************************************************************************************

REM *******************************************************************************************************************************************************************************************
REM This section applies the PinballFX and Piball M Fix...
REM *******************************************************************************************************************************************************************************************

echo Applying PinballFX and Piball M Fix if required...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\pinballfx-v1" goto SKIP
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Pin-Lic.7z -O Pin-Lic.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/7z.exe -O 7z.exe >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/7z.dll -O 7z.dll >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
7z x Pin-Lic.7z -aoa -p22446688 -o.\ >nul 2>&1

md "%localappdata%\PinballFX" >nul 2>&1
md "%localappdata%\PinballM" >nul 2>&1

xcopy PinballFX "%localappdata%\PinballFX" /S /E /D /I /Y >nul 2>&1
echo ...Copying files...
xcopy PinballM "%localappdata%\PinballM" /S /E /D /I /Y >nul 2>&1

robocopy "PinballFX\Saved\SaveGames" "%localappdata%\PinballFX\Saved\SaveGames" /mir /xd 76561197981264163 /w:0 /r:0 >nul 2>&1
robocopy "PinballM\Saved\SaveGames" "%localappdata%\PinballM\Saved\SaveGames" /mir /xd 76561197981264163 /w:0 /r:0 >nul 2>&1

rmdir /S /Q "PinballFX" >nul 2>&1
rmdir /S /Q "PinballM" >nul 2>&1
del /Q Pin-Lic.7z >nul 2>&1
ping -n 1 127.0.0.1 >nul
echo pinballfx-v1 > .\Flags\pinballfx-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section applies Zaccaria Pinball config...
REM *******************************************************************************************************************************************************************************************

echo Applying Zaccaria Pinball Config if required...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\ZP-v1" goto SKIP
del /Q ZP.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/ZP.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
7z x ZP.7z -aoa -p22446688 -o.\ >nul 2>&1
echo.
ver | find "XP" > nul
    if %ERRORLEVEL% == 0 SET PixN-MyDocs=%USERPROFILE%\My Documents
    if %ERRORLEVEL% == 1 FOR /f "tokens=3" %%x IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Personal"') do (set PixN-MyDocs=%%x)
echo ...Copying files...
md "%PixN-MyDocs%\Zaccaria_Pinball" >nul 2>&1
echo n | copy /-y "Zaccaria_Pinball" "%PixN-MyDocs%\Zaccaria_Pinball" >nul 2>&1
ping -n 1 127.0.0.1 >nul
rmdir /S /Q "Zaccaria_Pinball" >nul 2>&1
del /Q ZP.7z >nul 2>&1
echo ZP-v1 > .\Flags\ZP-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section adds OpenAL32.dll if required...
REM *******************************************************************************************************************************************************************************************

echo Checking if OpenAL32.dll is required...
echo.
ping -n 1 127.0.0.1 >nul
REM IF EXIST ".\Flags\OpenAL32.dll-v1" goto SKIP
IF NOT EXIST ..\..\roms\zaccariapinball\ZaccariaPinball.pc\ goto SKIP
IF EXIST ..\..\roms\zaccariapinball\ZaccariaPinball.pc\OpenAL32.dll goto SKIP

wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/OpenAL32.dll -O OpenAL32.dll >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
copy OpenAL32.dll ..\..\roms\zaccariapinball\ZaccariaPinball.pc\ >nul 2>&1
echo.
del /Q OpenAL32.dll >nul 2>&1
echo OpenAL32.dll-v1 > .\Flags\OpenAL32.dll-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for updated Radio stations...
REM *******************************************************************************************************************************************************************************************

echo Checking for updated Radio Stations...
echo.
ping -n 1 127.0.0.1 >nul
mkdir ..\..\roms\radio >nul 2>&1
IF EXIST ".\Flags\Radio-v4" goto SKIP
del /Q radio.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/radio.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
del /Q /S ..\..\roms\radio\*.* >nul 2>&1
ping -n 1 127.0.0.1 >nul
7z x radio.7z -aoa -p22446688 -o..\..\roms\radio\ >nul 2>&1
echo.
del /Q radio.7z >nul 2>&1

echo Radio-v4 > .\Flags\Radio-v4
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for updates to the PixN Radio station...
REM *******************************************************************************************************************************************************************************************

echo Checking for updates to the PixN Radio Station...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\PixN-Radio-v5" goto SKIP
del /Q PixN-Radio.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/PixN-Radio.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
del /Q /S ..\..\roms\radio\content\vlc\PixN-Radio\*.* >nul 2>&1
del /Q /S "..\..\roms\radio\content\vlc\PixN Radio.m3u8" >nul 2>&1
del /Q /S "..\..\roms\radio\content\vlc\PixN-Radio.m3u8" >nul 2>&1
ping -n 1 127.0.0.1 >nul
7z x PixN-Radio.7z -aoa -p22446688 -o..\..\roms\radio\content\vlc\ >nul 2>&1
echo.
del /Q PixN-Radio.7z >nul 2>&1

wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Scripts/PixN-Radio.bat -O PixN-Radio.bat >nul 2>&1
copy PixN-Radio.bat ..\..\roms\radio\PixN-Radio.bat /y >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q /S ..\..\emulators\pixn\PixN-Radio.bat >nul 2>&1

echo PixN-Radio-v5 > .\Flags\PixN-Radio-v5
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section adds the Konami LCD Artwork files...
REM *******************************************************************************************************************************************************************************************

echo Downloading the Konami LCD Artwork files if required...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\konami-LCD-artwork-v1" goto SKIP
del /Q Konami-LCD-Artwork.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Game_Updates/Konami-LCD-Artwork/Konami-LCD-Artwork.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x Konami-LCD-Artwork.7z -aoa -p22446688 -o..\..\saves\mame\artwork\ >nul 2>&1
echo.
ping -n 1 127.0.0.1 >nul
del /Q Konami-LCD-Artwork.7z >nul 2>&1
echo konami-LCD-artwork-v1 > .\Flags\konami-LCD-artwork-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section adds the Skylanders files to the Dolphin Emulator...
REM *******************************************************************************************************************************************************************************************

echo Adding Skylanders files to the Dolphin Emulator if required...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\Sky-v1" goto SKIP
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Sky.7z -O Sky.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x Sky.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\dolphin-emu >nul 2>&1
md ..\..\emulators\dolphin-emu\User >nul 2>&1
echo.
echo ...Copying files...
xcopy Skylanders ..\..\emulators\dolphin-emu\User\Skylanders\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q Sky.7z >nul 2>&1
rmdir /S /Q Skylanders >nul 2>&1

echo Sky-v1 > .\Flags\Sky-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated 3dSen Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking for the updated 3dSen Emulator...
echo.
ping -n 1 127.0.0.1 >nul

IF EXIST ".\Flags\3dSen-v1" goto SKIP
del /Q 3d-N.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/3d-N.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x 3d-N.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\3dsen >nul 2>&1
echo.
echo ...Copying files...
xcopy 3dsen ..\..\emulators\3dsen\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q 3d-N.7z >nul 2>&1
rmdir /S /Q 3dsen >nul 2>&1

echo 3dSen-v1 > .\Flags\3dSen-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated genesis_plus_gx_libretro core...
REM *******************************************************************************************************************************************************************************************

echo Checking for the updated genesis_plus_gx_libretro.dll core...
echo.
ping -n 1 127.0.0.1 >nul

IF EXIST ".\Flags\paprium-core-v1" goto SKIP
del /Q genesis_plus_gx_libretro.dll >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/genesis_plus_gx_libretro.dll >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
echo ...Copying files...
move /Y "genesis_plus_gx_libretro.dll" ..\..\emulators\retroarch\cores\ >nul 2>&1
ping -n 1 127.0.0.1 >nul
echo paprium-core-v1 > .\Flags\paprium-core-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the updated Visual Pinball Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking for the updated Visual Pinball Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\VPinball-v2" goto SKIP
del /Q vpinball_jan2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/vpinball_jan2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x vpinball_jan2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\vpinball >nul 2>&1
echo.
echo ...Copying files...
xcopy vpinball ..\..\emulators\vpinball\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q vpinball_jan2025.7z >nul 2>&1
rmdir /S /Q vpinball >nul 2>&1

echo VPinball-v2 > .\Flags\VPinball-v2
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks that the Ngage emulator is configured...
REM *******************************************************************************************************************************************************************************************

echo Checking Ngage Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\eka-emu-v1" goto SKIP
del /Q eka_jan2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/eka_jan2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x eka_jan2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\bios\eka2l1\ >nul 2>&1
md ..\..\bios\eka2l1\data\ >nul 2>&1
echo.
echo ...Copying files...
robocopy data ..\..\bios\eka2l1\data\ /E /XC /XN /XO /NP >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q eka_jan2025.7z >nul 2>&1
rmdir /S /Q data >nul 2>&1

echo eka-emu-v1 > .\Flags\eka-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section enables HD texture packs for the NES HD system...
REM *******************************************************************************************************************************************************************************************

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
REM *******************************************************************************************************************************************************************************************

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
REM *******************************************************************************************************************************************************************************************

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

REM *******************************************************************************************************************************************************************************************
REM This section sets DOSBox Pure settings (2of2)...
REM *******************************************************************************************************************************************************************************************

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
REM *******************************************************************************************************************************************************************************************

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

REM *******************************************************************************************************************************************************************************************
REM This section sets the correct Vectrex Shader...
REM *******************************************************************************************************************************************************************************************

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

REM *******************************************************************************************************************************************************************************************
REM This section adds the ffmpeg core to Retroarch...
REM *******************************************************************************************************************************************************************************************

echo.
echo Checking Retroarch for the ffmpeg core...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\retroarch-emu-v2" goto SKIP
del /Q retroarch_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/retroarch_feb2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x retroarch_feb2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\retroarch >nul 2>&1
echo.
echo ...Copying files...
xcopy retroarch ..\..\emulators\retroarch\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q retroarch_feb2025.7z >nul 2>&1
rmdir /S /Q retroarch >nul 2>&1
echo retroarch-emu-v2 > .\Flags\retroarch-emu-v2
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks the ShadPS4 Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking the ShadPS4 Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\shadps4-emu-v2" goto SKIP
del /Q shadps4_dec2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/shadps4_dec2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x shadps4_dec2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\shadps4 >nul 2>&1
echo.
echo ...Copying files...
xcopy shadps4 ..\..\emulators\shadps4\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q shadps4_dec2025.7z >nul 2>&1
rmdir /S /Q shadps4 >nul 2>&1
echo shadps4-emu-v2 > .\Flags\shadps4-emu-v2
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks the TeknoParrot Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking the TeknoParrot Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\TeknoParrot-v7" goto SKIP
REM Backup TecknoParrot data...
7z a "..\..\emulators\teknoparrot\UserProfiles-PixN-Backup.zip" "..\..\emulators\teknoparrot\UserProfiles\" >nul 2>&1
7z a "..\..\emulators\teknoparrot\GameProfiles-PixN-Backup.zip" "..\..\emulators\teknoparrot\GameProfiles\" >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q teknoparrot_jul2026.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/teknoparrot_jul2026.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x teknoparrot_jul2026.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\teknoparrot >nul 2>&1
echo ...Copying files...
xcopy teknoparrot ..\..\emulators\teknoparrot\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q teknoparrot_jul2026.7z >nul 2>&1
rmdir /S /Q teknoparrot >nul 2>&1

echo TeknoParrot-v7 > .\Flags\TeknoParrot-v7
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks the Switch Emulators...
REM *******************************************************************************************************************************************************************************************

echo Checking the Switch Emulators: Eden - Citron - Ryujinx
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\Switch-v2" goto Switch-Eden
del /Q switch_dec2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/switch_dec2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
	echo.
    %handle_error%
	goto Switch-Eden
) else (
    echo ...Download Completed Successfully...
	echo.
)
ping -n 1 127.0.0.1 >nul
7z x switch_dec2025.7z -aoa -p22446688 -o..\..\ >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q switch_dec2025.7z >nul 2>&1
echo Switch-v2 > .\Flags\Switch-v2

:Switch-Eden
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\Switch-Eden-v1" goto SW-FW
del /Q Eden-v0.2.0-rc2-amd64-msvc-standard.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/Eden-v0.2.0-rc2-amd64-msvc-standard.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SW-FW
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x Eden-v0.2.0-rc2-amd64-msvc-standard.7z -aoa -p22446688 -o..\..\emulators\eden\ >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q Eden-v0.2.0-rc2-amd64-msvc-standard.7z >nul 2>&1
echo Switch-Eden-v1 > .\Flags\Switch-Eden-v1

:SW-FW
REM This section checks for the updated Switch Firmware...
echo Checking for updated Switch Firmware
echo.
ping -n 1 127.0.0.1 >nul
rclone sync PixN-Themes-SH:/update/RetroBat/BIOS_Updates/Sync/Switch/fw-v21.0.0/Firmware ..\..\emulators\citron\user\nand\system\Contents\registered --progress --modify-window 2s
echo.
rclone sync ..\..\emulators\citron\user\nand\system\Contents\registered ..\..\emulators\eden\user\nand\system\Contents\registered --progress --modify-window 2s
echo.
rclone sync ..\..\emulators\citron\user\nand\system\Contents\registered ..\..\emulators\sudachi\user\nand\system\Contents\registered --progress --modify-window 2s
echo.
rclone sync ..\..\emulators\citron\user\nand\system\Contents\registered ..\..\emulators\suyu\user\nand\system\Contents\registered --progress --modify-window 2s
echo.
rclone sync ..\..\emulators\citron\user\nand\system\Contents\registered ..\..\emulators\yuzu\user\nand\system\Contents\registered --progress --modify-window 2s
echo.
ping -n 1 127.0.0.1 >nul

REM This section checks for the updated Switch Keys...
del /Q switch_keys_v21.0.0.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/BIOS_Updates/switch_keys_v21.0.0.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
	echo.
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
	echo.
)
ping -n 1 127.0.0.1 >nul
7z x switch_keys_v21.0.0.7z -aoa -p22446688 -o..\..\emulators\citron\user\keys\ >nul 2>&1
7z x switch_keys_v21.0.0.7z -aoa -p22446688 -o..\..\emulators\eden\user\keys\ >nul 2>&1
7z x switch_keys_v21.0.0.7z -aoa -p22446688 -o..\..\emulators\sudachi\user\keys\ >nul 2>&1
7z x switch_keys_v21.0.0.7z -aoa -p22446688 -o..\..\emulators\suyu\user\keys\ >nul 2>&1
7z x switch_keys_v21.0.0.7z -aoa -p22446688 -o..\..\emulators\yuzu\user\keys\ >nul 2>&1
7z x switch_keys_v21.0.0.7z -aoa -p22446688 -o..\..\saves\switch\ryujinx\portable\system\ >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q switch_keys_v21.0.0.7z >nul 2>&1
ping -n 1 127.0.0.1 >nul

:SKIP
REM This section updates Firmware for Ryujinx...
IF EXIST ".\Flags\Ryujinx-FW-v21.0.0" goto SKIP
del /Q switch_fw_v21.0.0.7z >nul 2>&1
ping -n 1 127.0.0.1 >nul
rmdir /S /Q ..\..\saves\switch\ryujinx\portable\bis\system\Contents\registered >nul 2>&1
ping -n 1 127.0.0.1 >nul
mkdir ..\..\saves\switch\ryujinx\portable\bis\system\Contents\registered >nul 2>&1
ping -n 1 127.0.0.1 >nul
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/BIOS_Updates/switch_fw_v21.0.0.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
	echo.
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
	echo.
)
ping -n 1 127.0.0.1 >nul
7z x switch_fw_v21.0.0.7z -aoa -p22446688 -o..\..\saves\switch\ryujinx\portable\bis\system\Contents\registered\ >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q switch_fw_v21.0.0.7z >nul 2>&1
echo Ryujinx-FW-v21.0.0 > .\Flags\Ryujinx-FW-v21.0.0
ping -n 1 127.0.0.1 >nul

:SKIP
REM This section cleans up old folders and firmware etc...
rmdir /S /Q ..\..\emulators\citron\fw_prodkey >nul 2>&1
rmdir /S /Q ..\..\emulators\suyu\user\Firmware.19.0.1 >nul 2>&1
rmdir /S /Q ..\..\saves\switch\ryujinx\portable\Firmware.19.0.1 >nul 2>&1
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section checks for the Clone Hero Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking the Clone Hero Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\clonehero-emu-v1" goto SKIP
del /Q clonehero_mar2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/clonehero_mar2025.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x clonehero_mar2025.7z -aoa -p22446688 -o.\ >nul 2>&1
md ..\..\emulators\clonehero >nul 2>&1
echo.
echo ...Copying files...
xcopy clonehero ..\..\emulators\clonehero\ /S /E /I /Q /H /Y /R >nul 2>&1
ping -n 1 127.0.0.1 >nul
del /Q clonehero_mar2025.7z >nul 2>&1
rmdir /S /Q clonehero >nul 2>&1
echo clonehero-emu-v1 > .\Flags\clonehero-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM *************************************************************This section adds the Windows 98 support files...*****************************************************************************
REM *******************************************************************************************************************************************************************************************

echo Checking for the Windows 98 support files...
echo.
REM ----------------RetroArch-------------------
ping -n 1 127.0.0.1 >nul
del /Q Win98-Retroarch.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/Win98-Retroarch.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
7z x Win98-Retroarch.7z -aoa -p22446688 -o.\ >nul 2>&1
echo.
echo ...Copying files...
xcopy retroarch ..\..\emulators\retroarch\ /S /E /I /Q /H /Y /R >nul 2>&1
del /Q Win98-Retroarch.7z >nul 2>&1
rmdir /S /Q retroarch >nul 2>&1
REM ----------------BootOS Size--------------------
powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -File ".\Scripts\Set-DOSBoxBootFreeSpace.ps1"
REM ----------------Decorations--------------------
echo.
ping -n 1 127.0.0.1 >nul
del /Q Win98-Decorations.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Other_Updates/Win98-Decorations.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
7z x Win98-Decorations.7z -aoa -p22446688 -o.\ >nul 2>&1
echo.
echo ...Copying files...
xcopy decorations ..\..\system\decorations\ /S /E /I /Q /H /Y /R >nul 2>&1
del /Q Win98-Decorations.7z >nul 2>&1
rmdir /S /Q decorations >nul 2>&1
REM ----------------Win98-End---------------------
echo win98-bios-v2 > .\Flags\win98-bios-v2
:SKIP
ping -n 1 127.0.0.1 >nul


REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM ************************************************************************* This section applies ROMpack Hotfixes ***************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

CLS
REM This section removes old files that are not needed for the IGT Slots ROMpack...
ping -n 1 127.0.0.1 >nul
ren ..\..\roms\igtslots\fruitmach.pc\_Emu_Clean_\autorun.cmd autorun.old >nul 2>&1
ren ..\..\roms\igtslots\fruitmach.pc\autorun.cmd autorun.old >nul 2>&1
ping -n 1 127.0.0.1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section removes the shortname entires from the gamelist files...
echo.
ping -n 1 127.0.0.1 >nul
echo Checking for incorrect shortnames, please wait...
powershell -ExecutionPolicy Bypass -File ".\Scripts\Fix-RetrobatShortname.ps1"
echo.
ping -n 1 127.0.0.1 >nul
echo Check complete...
echo.
REM *******************************************************************************************************************************************************************************************

REM This section fixes SuperBrosWar...
ping -n 1 127.0.0.1 >nul
IF EXIST "..\..\roms\superbroswar\sbw.sbw" goto SKIP
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Game-Fixes/superbroswar/sbw.sbw -O ..\..\roms\superbroswar\sbw.sbw >nul 2>&1
if %ERRORLEVEL% neq 0 (
    goto SKIP
) else (
    echo.
)
ping -n 1 127.0.0.1 >nul
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Game-Fixes/superbroswar/gamelist.xml -O ..\..\roms\superbroswar\gamelist.xml >nul 2>&1
if %ERRORLEVEL% neq 0 (
    goto SKIP
) else (
    echo.
)
ping -n 1 127.0.0.1 >nul
:SKIP
REM *******************************************************************************************************************************************************************************************

REM This section removes old EPIC and Steam shortcuts...
echo Removing old EPIC and Steam shortcuts...
echo.
ping -n 1 127.0.0.1 >nul
powershell -ExecutionPolicy Bypass -File ".\Scripts\Remove-Epic-Steam-Shortcuts.ps1"
ping -n 1 127.0.0.1 >nul
REM *******************************************************************************************************************************************************************************************

REM This section syncs PS3 licence files...
echo Adding new PS3 Licence files as required...
echo.
ping -n 1 127.0.0.1 >nul
rclone copy PixN-Themes-SH:/update/Game-Fixes/ps3/lics ..\..\saves\ps3\rpcs3\dev_hdd0\home\00000001\exdata --progress --ignore-existing --modify-window 2s
echo.
ping -n 1 127.0.0.1 >nul


REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************
REM ************************************************************************ This section adds BIOS files as required *************************************************************************
REM *******************************************************************************************************************************************************************************************
REM *******************************************************************************************************************************************************************************************

echo.
echo Adding new BIOS files as required...
echo.
ping -n 1 127.0.0.1 >nul
rclone copy PixN-Themes-SH:/update/RetroBat/BIOS_Updates/Sync/bios ..\..\bios --progress --ignore-existing --modify-window 2s
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM Download PCSX2x6 BIOS files...
REM *******************************************************************************************************************************************************************************************
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies "http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/BIOS_Updates/r27v1602f.7d" >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies "http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/BIOS_Updates/r27v1602f.8g" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    %handle_error%
	goto SKIP
) else (
    echo.
)
ping -n 2 127.0.0.1 > nul
move /Y "r27v1602f.7d" ..\..\emulators\teknoparrot\pcsx2x6\TeknoParrot\bios\ >nul 2>&1
move /Y "r27v1602f.8g" ..\..\emulators\teknoparrot\pcsx2x6\TeknoParrot\bios\ >nul 2>&1
ping -n 2 127.0.0.1 > nul
:SKIP

REM *******************************************************************************************************************************************************************************************
REM Download MAME Samples...
REM *******************************************************************************************************************************************************************************************

echo.
echo Checking for missing MAME Samples...
echo.
rclone copy PixN-Themes-SH:/update/Batocera/bios/mame/samples ..\..\saves\mame\samples --progress --ignore-existing --modify-window 2s
echo.
ping -n 1 127.0.0.1 >nul

REM *******************************************************************************************************************************************************************************************
REM This section downloads addidtional BIOS files for the Dolphin Emulator...
REM *******************************************************************************************************************************************************************************************

echo Checking addidtional BIOS files for the Dolphin Emulator...
echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\dolphin-bios-v1" goto SKIP
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/BIOS_Updates/Dolphin-Extra-Bios.7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
7z x Dolphin-Extra-Bios.7z -aoa -p22446688 -o.\ >nul 2>&1
echo ...Copying files...
echo.
xcopy Dolphin-Extra-Bios\emulators\dolphin-emu\User ..\..\emulators\dolphin-emu\User\ /s /y /d >nul 2>&1
xcopy Dolphin-Extra-Bios\saves\dolphin ..\..\saves\dolphin\ /s /y /d >nul 2>&1
echo.
ping -n 1 127.0.0.1 >nul
rmdir /S /Q "Dolphin-Extra-Bios" >nul 2>&1
del /Q Dolphin-Extra-Bios.7z >nul 2>&1
ping -n 1 127.0.0.1 >nul
echo dolphin-bios-v1 > .\Flags\dolphin-bios-v1
:SKIP
echo.
ping -n 1 127.0.0.1 >nul


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
ping -n 2 127.0.0.1 >nul
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

start /wait .\Scripts\RB-v8-Settings.cmd

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

start /wait .\Scripts\RB-v7-Settings.cmd

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

start /wait .\Scripts\RB-v6-Settings.cmd

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

REM *******************************************************************************************************************************************************************************************
REM Setting default theme on first run...
REM *******************************************************************************************************************************************************************************************

echo.
ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\set-default-theme-v1" goto SKIP

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

cscript replace.vbs "..\..\emulationstation\.emulationstation\es_settings.cfg" "es-theme-carbon" "ckau-book-PixN" > NUL

echo set-default-theme-v1 > .\Flags\set-default-theme-v1
:SKIP
echo.
REM *******************************************************************************************************************************************************************************************

echo Checking for theme updates...
echo.
ping -n 1 127.0.0.1 >nul
del /Q "Full Download - Hypermax Plus PixN.bat" >nul 2>&1
del /Q "Full Download - Alekfull-ARTFLIX-PixN.bat" >nul 2>&1
del /Q "Full Download - Carbon-PixN.bat" >nul 2>&1
del /Q "Full Download - Ckau Book PixN.bat" >nul 2>&1
ping -n 1 127.0.0.1 >nul
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
ping -n 1 127.0.0.1 >nul
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
ping -n 1 127.0.0.1 >nul
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

ping -n 1 127.0.0.1 >nul
IF EXIST ".\Flags\Skip-HyperMax-PixN" goto SKIP
echo Checking Hypermax-Plus-PixN for updates...
echo.
ping -n 1 127.0.0.1 >nul
rclone sync PixN-Themes-SH:/update/Themes/Hypermax-Plus-PixN ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN --exclude=/_inc/videos/** --progress --modify-window 2s
md "..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\videos" >nul 2>&1
:SKIP

IF EXIST ".\Flags\Skip-Carbon-PixN" goto SKIP
echo.
echo Checking Carbon-PixN for updates...
echo.
ping -n 1 127.0.0.1 >nul
rclone sync PixN-Themes-SH:/update/Themes/Carbon-PixN ..\..\emulationstation\.emulationstation\themes\Carbon-PixN --progress --modify-window 2s
:SKIP

IF EXIST ".\Flags\Skip-Ckau-book-PixN" goto SKIP
echo.
echo Checking Ckau-Book-PixN for updates...
echo.
ping -n 1 127.0.0.1 >nul
rclone sync PixN-Themes-SH:/update/Themes/ckau-book-PixN ..\..\emulationstation\.emulationstation\themes\ckau-book-PixN --progress --modify-window 2s
:SKIP

IF EXIST ".\Flags\Skip-Ckau-book" goto SKIP
echo.
echo Checking Ckau-Book for updates...
echo.
ping -n 1 127.0.0.1 >nul
rclone sync PixN-Themes-SH:/update/Themes/ckau-book ..\..\emulationstation\.emulationstation\themes\ckau-book --progress --modify-window 2s
:SKIP
echo.
REM *******************************************************************************************************************************************************************************************

REM Sync latest Decorations/Bezels...
echo.
echo Checking for updated/missing Decorations/Bezels...
echo.
del /Q neogeo.png >nul 2>&1
del /Q neogeo.png.* >nul 2>&1
del /Q mame.png >nul 2>&1
del /Q mame.png.* >nul 2>&1
REM wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/decorations/mybezels16-9/default.info >nul 2>&1
REM wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/decorations/mybezels16-9/default.png >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/decorations/mybezels16-9/neogeo.png >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/decorations/mybezels16-9/mame.png >nul 2>&1
REM move /Y default.info ..\..\decorations\thebezelproject\ >nul 2>&1
REM move /Y default.png ..\..\decorations\thebezelproject\ >nul 2>&1
move /Y neogeo.png ..\..\decorations\thebezelproject\systems\ >nul 2>&1
move /Y mame.png ..\..\decorations\thebezelproject\systems\ >nul 2>&1
ping -n 1 127.0.0.1 >nul
REM ren ..\..\decorations\thebezelproject\default.info PixN-Bezel.info >nul 2>&1
REM ren ..\..\decorations\thebezelproject\default.png PixN-Bezel.png >nul 2>&1
del /Q ..\..\decorations\thebezelproject\default.info >nul 2>&1
del /Q ..\..\decorations\thebezelproject\default.png >nul 2>&1
del /Q ..\..\decorations\thebezelproject\PixN-Bezel.info >nul 2>&1
del /Q ..\..\decorations\thebezelproject\PixN-Bezel.png >nul 2>&1
rclone copy PixN-Themes-SH:/update/decorations/mybezels16-9/games ..\..\decorations\thebezelproject\games --progress --ignore-existing --modify-window 2s
rclone copy PixN-Themes-SH:/update/decorations/mybezels16-9/systems ..\..\decorations\thebezelproject\systems --progress --ignore-existing --modify-window 2s

ren ..\..\system\decorations\default_unglazed\systems\saturn.png saturn.old >nul 2>&1
ren ..\..\system\decorations\default_unglazed\systems\snes.png snes.old >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Decoration_Updates/default_unglazed/systems/saturn.png -O ..\..\system\decorations\default_unglazed\systems\saturn.png >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Decoration_Updates/default_unglazed/systems/snes.png -O ..\..\system\decorations\default_unglazed\systems\snes.png >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Decoration_Updates/default_unglazed/systems/jaguarcd.info -O ..\..\system\decorations\default_unglazed\systems\jaguarcd.info >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Decoration_Updates/default_unglazed/systems/jaguarcd.png -O ..\..\system\decorations\default_unglazed\systems\jaguarcd.png >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Decoration_Updates/default_unglazed/systems/sega32xcd.info -O ..\..\system\decorations\default_unglazed\systems\sega32xcd.info >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Decoration_Updates/default_unglazed/systems/sega32xcd.png -O ..\..\system\decorations\default_unglazed\systems\sega32xcd.png >nul 2>&1


echo.
ping -n 1 127.0.0.1 >nul
REM *******************************************************************************************************************************************************************************************

REM Sync MAME Artwork...
echo.
echo Checking for updated/missing MAME Artwork...
echo.
rclone copy PixN-Themes-SH:/update/Batocera/bios/mame/artwork ..\..\saves\mame\artwork --progress --ignore-existing --modify-window 2s
echo.
ping -n 1 127.0.0.1 >nul
REM *******************************************************************************************************************************************************************************************

REM Apply the PixB Spash video...
echo.
ping -n 1 127.0.0.1 >nul
REM IF EXIST ".\Flags\Set-PixN-Splash-v2" goto SKIP
IF EXIST "pixnretrodeck-ally-v1" goto SKIP
IF EXIST "pixnretrodeck-steamdeck-v1" goto SKIP

wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/PixN-Splash-1.mp4 >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ...Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo ...Download Completed Successfully...
)
ping -n 1 127.0.0.1 >nul
echo.
move /Y "PixN-Splash-1.mp4" ..\..\emulationstation\.emulationstation\video\ >nul 2>&1
ping -n 1 127.0.0.1 >nul
echo Set-PixN-Splash-v2 > .\Flags\Set-PixN-Splash-v2
echo.
ping -n 1 127.0.0.1 >nul

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
ping -n 1 127.0.0.1 >nul
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
ping -n 1 127.0.0.1 >nul
del /Q pixnretrodeck.svg >nul 2>&1
del /Q pixnretrodeck-ally.svg >nul 2>&1
del /Q pixnretrodeck-hyper-silver.png >nul 2>&1
del /Q pixnretrodeck-hyper-system.png >nul 2>&1
del /Q pixnretrodeck-hyper-system1.png >nul 2>&1
del /Q pixnretrodeck-hyper-system2.png >nul 2>&1

echo.
echo Updating Music...
echo.
ping -n 1 127.0.0.1 >nul
rclone sync PixN-Themes-SH:/update/Music/RetroDeck ..\..\emulationstation\.emulationstation\music --progress --modify-window 2s


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
ping -n 1 127.0.0.1 >nul
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
ping -n 1 127.0.0.1 >nul
del /Q pixnretrodeck.svg >nul 2>&1
del /Q pixnretrodeck-steamdecklcd.svg >nul 2>&1
del /Q pixnretrodeck-hyper-silver.png >nul 2>&1
del /Q pixnretrodeck-hyper-system.png >nul 2>&1
del /Q pixnretrodeck-hyper-system1.png >nul 2>&1
del /Q pixnretrodeck-hyper-system2.png >nul 2>&1

echo.
echo Updating Music...
echo.
ping -n 1 127.0.0.1 >nul
rclone sync PixN-Themes-SH:/update/Music/RetroDeck ..\..\emulationstation\.emulationstation\music --progress --modify-window 2s

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
ping -n 5 127.0.0.1 >nul
cls
popd
exit

REM *******************************************************************************************************************************************************************************************
:CORE-FILES-FAILED
echo.
echo.
echo ##########################################################
echo #                                                        #
echo #                         ERROR!                         #
echo #                                                        #
echo #    It looks like the core files failed to download     #
echo #                Make sure you can access:               #
echo #            https://raw.githubusercontent.com           #
echo #                                                        #
echo ##########################################################
echo.
ping -n 5 127.0.0.1 >nul
cls
popd
exit