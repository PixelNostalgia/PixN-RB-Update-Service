@echo off
pushd %1
rem Text color code for Light Green is A
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

REM Function to handle errors with a pause
set "handle_error=timeout /t 4 >nul"

REM Read from ASCII.txt and visualize ASCII art
type ASCII.txt

echo.
echo Pixel Nostalgia updater running...
echo Version 1.38
echo.
ping -n 2 127.0.0.1 > nul
cls


REM *******************************************************************
REM *******************************************************************
REM **************************Warning Message**************************
REM *******************************************************************
REM *******************************************************************

rem Text color code for Yellow is E
set "colorCode=E"
color %colorCode%

echo.
echo #########################################################
echo #                                                       #
echo #                   IMPORTANT NOTICE:                   #
echo #      IF YOU HAVE PAID ANY FORM OF MONEY FOR THIS      #
echo #     OR ANY OTHER TEAM PIXEL NOSTALGIA / RGS BUILD     #
echo #                DEMAND YOUR MONEY BACK!                #
echo #                                                       #
echo #         THIS BUILD IS FREELEY AVAILABLE TO ALL        #
echo #                VIA OUR DISCORD SERVER:                #
echo #                                                       #
echo #             https://discord.gg/xNxrAr6sGv             #
echo #                                                       #
echo #########################################################
echo.

ping -n 10 127.0.0.1 > nul
rem Text color code for Light Green is A
set "colorCode=A"
color %colorCode%
cls

REM *******************************************************************
REM *******************************************************************
REM **This first section applies config that is NOT version dependent**
REM *******************************************************************
REM *******************************************************************

REM This section pulls down the latest PixN Custom Collections...
echo.
echo Updating the PixN Custom Collections...
echo.
ping -n 1 127.0.0.1 > nul
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
	echo.
)
move /Y ".\PixN-Collections\*.cfg" ..\..\emulationstation\.emulationstation\collections\
rmdir /S /Q ".\PixN-Collections"
:SKIP
ping -n 1 127.0.0.1 > nul
echo.


REM This section restores the PixN Update Service artwork...
echo Checking if the PixN Update Service artwork needs restoring...
echo.
IF EXIST "pixn-us-check-v1" goto GOTPS
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Add-PixNService.ps1 -O Add-PixNService.ps1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo.
	echo Download Completed Successfully...
	echo.
)
echo pixn-us-check-v1 > pixn-us-check-v1
:GOTPS
ping -n 1 127.0.0.1 > nul
powershell -ExecutionPolicy Bypass -File "Add-PixNService.ps1"
echo.
ping -n 1 127.0.0.1 > nul
:SKIP
del /Q "pixn-rb-update-service-logo.png" >nul 2>&1
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/pixn-rb-update-service-logo.png -O pixn-rb-update-service-logo.png
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	got SKIP
) else (
    echo Download Completed Successfully...
)
move /Y "pixn-rb-update-service-logo.png" ..\..\system\es_menu\media\
:SKIP
ping -n 1 127.0.0.1 > nul
echo.

REM This section cleans up from when the PixN Update Service was added to the system wheel...
rmdir /S /Q "..\..\roms\pixn" >nul 2>&1

REM This section applies the PinballFX and Piball M Fix...
echo Applying PinballFX and Piball M Fix if required...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "pinballfx-v1" goto SKIP
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Pin-Lic.7z -O Pin-Lic.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/7z.exe -O 7z.exe
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/7z.dll -O 7z.dll
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
7z x Pin-Lic.7z -aoa -p22446688 -o.\

md "%localappdata%\PinballFX"
md "%localappdata%\PinballM"

xcopy PinballFX "%localappdata%\PinballFX" /S /E /D /I /Y
echo Copying files...
xcopy PinballM "%localappdata%\PinballM" /S /E /D /I /Y

robocopy "PinballFX\Saved\SaveGames" "%localappdata%\PinballFX\Saved\SaveGames" /mir /xd 76561197981264163 /w:0 /r:0
robocopy "PinballM\Saved\SaveGames" "%localappdata%\PinballM\Saved\SaveGames" /mir /xd 76561197981264163 /w:0 /r:0

rmdir /S /Q "PinballFX"
rmdir /S /Q "PinballM"
del /Q Pin-Lic.7z >nul 2>&1
ping -n 1 127.0.0.1 > nul
echo pinballfx-v1 > pinballfx-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section applies Zaccaria Pinball config...
echo Applying Zaccaria Pinball Config if required...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "ZP-v1" goto SKIP
del /Q ZP.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/ZP.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
7z x ZP.7z -aoa -p22446688 -o.\
echo.
ver | find "XP" > nul
    if %ERRORLEVEL% == 0 SET PixN-MyDocs=%USERPROFILE%\My Documents
    if %ERRORLEVEL% == 1 FOR /f "tokens=3" %%x IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Personal"') do (set PixN-MyDocs=%%x)
echo Copying files...
md "%PixN-MyDocs%\Zaccaria_Pinball" >nul 2>&1
echo n | copy /-y "Zaccaria_Pinball" "%PixN-MyDocs%\Zaccaria_Pinball"
ping -n 1 127.0.0.1 > nul
rmdir /S /Q "Zaccaria_Pinball"
del /Q ZP.7z >nul 2>&1
echo ZP-v1 > ZP-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section adds OpenAL32.dll if required...
echo Checking if OpenAL32.dll is required...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "OpenAL32.dll-v1" goto SKIP
IF NOT EXIST ..\..\roms\zaccariapinball\ZaccariaPinball.pc\ goto SKIP
IF EXIST ..\..\roms\zaccariapinball\ZaccariaPinball.pc\OpenAL32.dll goto SKIP

wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/OpenAL32.dll -O OpenAL32.dll
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
copy OpenAL32.dll ..\..\roms\zaccariapinball\ZaccariaPinball.pc\
echo.
del /Q OpenAL32.dll >nul 2>&1
echo OpenAL32.dll-v1 > OpenAL32.dll-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for updated Radio stations...
echo Checking for updated Radio Stations...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "Radio-v3" goto SKIP
del /Q radio.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/radio.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
del /Q /S ..\..\roms\radio\*.* >nul 2>&1
ping -n 1 127.0.0.1 > nul
7z x radio.7z -aoa -p22446688 -o..\..\roms\radio\
echo.
del /Q radio.7z >nul 2>&1

echo Radio-v3 > Radio-v3
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for updates to the PixN Radio station...
echo Checking for updates to the PixN Radio Station...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "PixN-Radio-v4" goto SKIP
del /Q PixN-Radio.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/PixN-Radio.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
del /Q /S ..\..\roms\radio\content\vlc\PixN-Radio\*.* >nul 2>&1
del /Q /S "..\..\roms\radio\content\vlc\PixN Radio.m3u8" >nul 2>&1
del /Q /S "..\..\roms\radio\content\vlc\PixN-Radio.m3u8" >nul 2>&1
ping -n 1 127.0.0.1 > nul
7z x PixN-Radio.7z -aoa -p22446688 -o..\..\roms\radio\content\vlc\
echo.
del /Q PixN-Radio.7z >nul 2>&1

wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/PixN-Radio.bat -O PixN-Radio.bat
copy PixN-Radio.bat ..\..\roms\radio\PixN-Radio.bat /y
ping -n 2 127.0.0.1 > nul
del /Q /S ..\..\emulators\pixn\PixN-Radio.bat >nul 2>&1

echo PixN-Radio-v4 > PixN-Radio-v4
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section fixes the version of the Archimedes BIOS files...
echo Downloading updated Archimedes BIOS files if required...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "Archimedes-BIOS-v1" goto SKIP
del /Q arch-b.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/BIOS_Updates/arch-b.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x arch-b.7z -aoa -p22446688 -o.\
echo.
echo Moving files...
move /Y "aa310.zip" ..\..\bios\
move /Y "archimedes_keyboard.zip" ..\..\bios\
ping -n 1 127.0.0.1 > nul
del /Q arch-b.7z >nul 2>&1
echo Archimedes-BIOS-v1 > Archimedes-BIOS-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks the Electron BIOS files are present...
echo Downloading the Acorn Electron BIOS files if required...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "Electron-BIOS-v1" goto SKIP
del /Q electron.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/BIOS_Updates/electron.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x electron.7z -aoa -p22446688 -o.\
echo.
echo Moving files...
move /Y "electron.zip" ..\..\bios\
move /Y "electron64.zip" ..\..\bios\
move /Y "electron_plus1.zip" ..\..\bios\
move /Y "electron_plus3.zip" ..\..\bios\
ping -n 1 127.0.0.1 > nul
del /Q Electron.7z >nul 2>&1
del /Q electron.zip >nul 2>&1
del /Q electron64.zip >nul 2>&1
del /Q electron_plus1.zip >nul 2>&1
del /Q electron_plus3.zip >nul 2>&1
echo Electron-BIOS-v1 > Electron-BIOS-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks the updated DOSbox Pure MIDI File...
echo Downloading the updated DOSbox Pure MIDI file if required...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "DOSbox-Pure-MIDI-v1" goto SKIP
del /Q DOSBoxPureMidiCache.txt >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/BIOS_Updates/DOSBoxPureMidiCache.txt
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
echo Moving files...
move /Y "DOSBoxPureMidiCache.txt" ..\..\bios\
ping -n 1 127.0.0.1 > nul
echo DOSbox-Pure-MIDI-v1 > DOSbox-Pure-MIDI-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section adds the Skylanders files to the Dolphin Emulator...
echo Adding Skylanders files to the Dolphin Emulator if required...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "Sky-v1" goto SKIP
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Sky.7z -O Sky.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x Sky.7z -aoa -p22446688 -o.\
md ..\..\emulators\dolphin-emu >nul 2>&1
md ..\..\emulators\dolphin-emu\User >nul 2>&1
echo.
echo Copying files...
xcopy Skylanders ..\..\emulators\dolphin-emu\User\Skylanders\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q Sky.7z >nul 2>&1
rmdir /S /Q Skylanders >nul 2>&1

echo Sky-v1 > Sky-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated Hypseus Emulator...
echo Checking for the updated Hypseus Emulator...
echo.
ping -n 1 127.0.0.1 > nul

IF EXIST "Hypseus-v1" goto SKIP
del /Q hypseus.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/hypseus.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x hypseus.7z -aoa -p22446688 -o.\
md ..\..\emulators\hypseus >nul 2>&1
echo.
echo Copying files...
xcopy hypseus ..\..\emulators\hypseus\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q hypseus.7z >nul 2>&1
rmdir /S /Q hypseus >nul 2>&1

echo Hypseus-v1 > Hypseus-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated 3dSen Emulator...
echo Checking for the updated 3dSen Emulator...
echo.
ping -n 1 127.0.0.1 > nul

IF EXIST "3dSen-v1" goto SKIP
del /Q 3d-N.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/3d-N.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x 3d-N.7z -aoa -p22446688 -o.\
md ..\..\emulators\3dsen >nul 2>&1
echo.
echo Copying files...
xcopy 3dsen ..\..\emulators\3dsen\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q 3d-N.7z >nul 2>&1
rmdir /S /Q 3dsen >nul 2>&1

echo 3dSen-v1 > 3dSen-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated TeknoParrot Emulator...
echo Checking for the updated TeknoParrot Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "TeknoParrot-v3" goto SKIP
del /Q teknoparrot_jan2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/teknoparrot_jan2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x teknoparrot_jan2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\teknoparrot >nul 2>&1
echo.
echo Copying files...
xcopy teknoparrot ..\..\emulators\teknoparrot\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q teknoparrot_jan2025.7z >nul 2>&1
rmdir /S /Q teknoparrot >nul 2>&1

echo TeknoParrot-v3 > TeknoParrot-v3
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated Virtual Pinball Emulator...
echo Checking for the updated Virtual Pinball Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "VPinball-v2" goto SKIP
del /Q vpinball_jan2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/vpinball_jan2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x vpinball_jan2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\vpinball >nul 2>&1
echo.
echo Copying files...
xcopy vpinball ..\..\emulators\vpinball\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q vpinball_jan2025.7z >nul 2>&1
rmdir /S /Q vpinball >nul 2>&1

echo VPinball-v2 > VPinball-v2
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated Switch Emulators...
echo Checking for the updated Switch Emulators...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "Switch-v1" goto SKIP
del /Q switch_dec2024.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/switch_dec2024.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x switch_dec2024.7z -aoa -p22446688 -o.\
echo.
echo Copying files...
xcopy ryujinx ..\..\emulators\ryujinx\ /S /E /I /Q /H /Y /R
xcopy yuzu ..\..\emulators\yuzu\ /S /E /I /Q /H /Y /R
xcopy suyu ..\..\emulators\suyu\ /S /E /I /Q /H /Y /R
xcopy sudachi ..\..\emulators\sudachi\ /S /E /I /Q /H /Y /R
xcopy swsaves ..\..\saves\switch\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q switch_dec2024.7z >nul 2>&1
rmdir /S /Q ryujinx >nul 2>&1
rmdir /S /Q yuzu >nul 2>&1
rmdir /S /Q suyu >nul 2>&1
rmdir /S /Q sudachi >nul 2>&1
rmdir /S /Q swsaves >nul 2>&1

echo Switch-v1 > Switch-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks that the Ngage emulator is configured...
echo Checking Ngage Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "eka-emu-v1" goto SKIP
del /Q eka_jan2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/eka_jan2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x eka_jan2025.7z -aoa -p22446688 -o.\
md ..\..\bios\eka2l1\ >nul 2>&1
md ..\..\bios\eka2l1\data\ >nul 2>&1
echo.
echo Copying files...
robocopy data ..\..\bios\eka2l1\data\ /E /XC /XN /XO /NP >nul 2>&1
ping -n 1 127.0.0.1 > nul
del /Q eka_jan2025.7z >nul 2>&1
rmdir /S /Q data >nul 2>&1

echo eka-emu-v1 > eka-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul


REM This section checks for the updated Xash3D FWGS Emulator...
REM echo Checking for the updated Xash3D FWGS Emulator...
REM echo.
REM ping -n 1 127.0.0.1 > nul

REM IF EXIST "Xash3D-FWGS-v1" goto SKIP

REM del /Q CXfrB4pN*.* >nul 2>&1
REM wget https://pixeldrain.com/api/filesystem/CXfrB4pN
REM ren CXfrB4pN xash3d-fwgs_oct2024.7z
REM ping -n 1 127.0.0.1 > nul
REM echo.
REM 7z x xash3d-fwgs_oct2024.7z -aoa -p22446688 -o.\
REM md ..\..\emulators\xash3d-fwgs >nul 2>&1
REM echo.
REM echo Copying files...
REM xcopy xash3d-fwgs ..\..\emulators\xash3d-fwgs\ /S /E /I /Q /H /Y /R
REM ping -n 1 127.0.0.1 > nul
REM del /Q xash3d-fwgs_oct2024.7z
REM rmdir /S /Q xash3d-fwgs >nul 2>&1

REM echo Xash3D-FWGS-v1 > Xash3D-FWGS-v1
REM :SKIP
REM echo.

REM This section downloads a tiny file so we can see how many people are using the Update Service...
REM del /Q NYcXqrtb*.* >nul 2>&1
REM del /Q PixN-Stats >nul 2>&1
REM wget https://pixeldrain.com/api/filesystem/NYcXqrtb >nul 2>&1
REM ren NYcXqrtb PixN-Stats >nul 2>&1
REM ping -n 1 127.0.0.1 > nul

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

REM This section sets DOSBox Pure settings (1of2)...
setlocal

REM Set the working directory to the script's location
REM cd /d "%~dp0"

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Backup the original file
copy "%filePath%" "%filePath%.bak" >nul 2>&1

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

REM Backup the original file
copy "%filePath%" "%filePath%.bak" >nul 2>&1

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

REM This section checks for the Clone Hero Emulator...
echo.
echo Checking the Clone Hero Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "clonehero-emu-v1" goto SKIP
del /Q clonehero_mar2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/clonehero_mar2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x clonehero_mar2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\clonehero >nul 2>&1
echo.
echo Copying files...
xcopy clonehero ..\..\emulators\clonehero\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q clonehero_mar2025.7z >nul 2>&1
rmdir /S /Q clonehero >nul 2>&1
echo clonehero-emu-v1 > clonehero-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for Solarus emulator updates...
echo.
echo Checking for Solarus emulator updates...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "solarus-emu-v1" goto SKIP
del /Q solarus-v2.0.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/solarus-v2.0.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x solarus-v2.0.7z -aoa -p22446688 -o.\
md ..\..\emulators\solarus >nul 2>&1
echo.
echo Copying files...
xcopy solarus ..\..\emulators\solarus\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q solarus-v2.0.7z >nul 2>&1
rmdir /S /Q solarus >nul 2>&1
echo solarus-emu-v1 > solarus-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated RyuJinx Emulator...
echo Checking for the updated RyuJinx Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "ryujinx-emu-v2" goto SKIP
del /Q ryujinx_apr2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/ryujinx_apr2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x ryujinx_apr2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\ryujinx >nul 2>&1
echo.
echo Copying files...
xcopy ryujinx ..\..\emulators\ryujinx\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q ryujinx_apr2025.7z >nul 2>&1
rmdir /S /Q ryujinx >nul 2>&1
echo ryujinx-emu-v2 > ryujinx-emu-v2
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated Citron Emulator...
echo Checking for the updated Citron Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "citron-emu-v1" goto SKIP
del /Q citron_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/citron_feb2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x citron_feb2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\citron >nul 2>&1
echo.
echo Copying files...
xcopy citron ..\..\emulators\citron\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q citron_feb2025.7z >nul 2>&1
rmdir /S /Q citron >nul 2>&1
echo citron-emu-v1 > citron-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section adds the Windows 98 support files...
echo Checking for the Windows 98 support files...
echo.

REM -------------------BIOS--------------------
ping -n 1 127.0.0.1 > nul
IF EXIST "win98-bios-v1" goto SKIP
del /Q Win98.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/BIOS_Updates/Win98.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x Win98.7z -aoa -p22446688 -o.\
echo.
echo Moving files...
move /Y "cm32l_control.rom" ..\..\bios\
move /Y "cm32l_pcm.rom" ..\..\bios\
move /Y "Roland SC-55.sf2" ..\..\bios\
move /Y "Roland SC-88.sf2" ..\..\bios\
move /Y "Windows 98 SE.7z" ..\..\bios\
move /Y "Windows 98 SE.img" ..\..\bios\
ping -n 2 127.0.0.1 > nul
del /Q "cm32l_control.rom" >nul 2>&1
del /Q "cm32l_pcm.rom" >nul 2>&1
del /Q "Roland SC-55.sf2" >nul 2>&1
del /Q "Roland SC-88.sf2" >nul 2>&1
del /Q "Windows 98 SE.7z" >nul 2>&1
del /Q "Windows 98 SE.img" >nul 2>&1
del /Q Win98.7z >nul 2>&1

REM ----------------RetroArch-------------------
echo.
ping -n 1 127.0.0.1 > nul
del /Q Win98-Retroarch.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/Win98-Retroarch.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x Win98-Retroarch.7z -aoa -p22446688 -o.\
echo.
echo Copying files...
xcopy retroarch ..\..\emulators\retroarch\ /S /E /I /Q /H /Y /R
del /Q Win98-Retroarch.7z >nul 2>&1
rmdir /S /Q retroarch >nul 2>&1

REM ----------------Decorations--------------------
echo.
ping -n 1 127.0.0.1 > nul
del /Q Win98-Decorations.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Other_Updates/Win98-Decorations.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x Win98-Decorations.7z -aoa -p22446688 -o.\
echo.
echo Copying files...
xcopy decorations ..\..\system\decorations\ /S /E /I /Q /H /Y /R
del /Q Win98-Decorations.7z >nul 2>&1
rmdir /S /Q decorations >nul 2>&1

REM ----------------Win98-End---------------------
echo win98-bios-v1 > win98-bios-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM ******************************************************************
REM ******************************************************************
REM **************This section applies ROMpack Hotfixes***************
REM ******************************************************************
REM ******************************************************************

REM ping -n 1 127.0.0.1 > nul
REM IF NOT EXIST ..\..\roms\3do\media\ goto SKIP
REM IF EXIST "3do-thumbnails-fix-v1" goto SKIP
REM del /Q 3do-thumbnails-fix.7z >nul 2>&1
REM wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Game-Fixes/3do/3do-thumbnails-fix.7z
REM if %ERRORLEVEL% neq 0 (
REM     echo Download Failed! - Skipping...
REM     %handle_error%
REM 	goto SKIP
REM ) else (
REM     echo Download Completed Successfully...
REM )
REM ping -n 1 127.0.0.1 > nul
REM echo.
REM 7z x 3do-thumbnails-fix.7z -aoa -p22446688 -o..\..\roms\3do\media\thumbnails\
REM echo.
REM del /Q 3do-thumbnails-fix.7z >nul 2>&1
REM echo 3do-thumbnails-fix-v1 > 3do-thumbnails-fix-v1
REM :SKIP


REM ******************************************************************
REM ******************************************************************
REM ***This section applies config based on the version of RetroBat***
REM ******************************************************************
REM ******************************************************************

CLS
IF EXIST "..\..\system\version.info" goto CHECKv7
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
ping -n 1 127.0.0.1 > nul
CLS
goto THEMES

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
  goto CHECKv5
)

:CHECKv5
>nul find "5." ..\..\system\version.info && (
  echo You are running RetroBat v5.x...
  echo.
  goto END
) || (
  goto END
)

:CONFIGUREv7
echo.
echo Configuring v7.x
echo.

REM This section removes old custom system config files that are no longer needed in RBv7.x...
echo.
echo Cleaning up old config files...
echo.
ping -n 1 127.0.0.1 > nul
del /Q ..\..\emulationstation\.emulationstation\es_systems_cgenius.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_cdogs.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_corsixth.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_3ds.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_tg-16.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_examu.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_segalindbergh.cfg >nul 2>&1
ping -n 1 127.0.0.1 > nul

REM This section renames boom3 to doom3 as required for RBv7.x...
echo.
echo Renaming boom3 to doom3 as required for RetroBat v7.x...
ren ..\..\roms\doom3 doom3.old >nul 2>&1
ren ..\..\roms\boom3 doom3 >nul 2>&1
echo.
ping -n 1 127.0.0.1 > nul

REM This section adds the new BIOS files required for RBv7.x...
echo.
echo Adding the new BIOS files required for RetroBat v7.x...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "Aquarius-BIOS-v1" goto SKIP
del /Q aquarius-bios.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/BIOS_Updates/aquarius-bios.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x aquarius-bios.7z -aoa -p22446688 -o.\
echo.
echo Moving files...
move /Y "aquarius.zip" ..\..\bios\
move /Y "aquarius_ar.zip" ..\..\bios\
move /Y "aquarius2.zip" ..\..\bios\
move /Y "aquariusp.zip" ..\..\bios\
ping -n 1 127.0.0.1 > nul
del /Q aquarius-bios.7z >nul 2>&1
del /Q aquarius.zip >nul 2>&1
del /Q aquarius_ar.zip >nul 2>&1
del /Q aquarius2.zip >nul 2>&1
del /Q aquariusp.zip >nul 2>&1
echo Aquarius-BIOS-v1 > Aquarius-BIOS-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section adds the new Emulators required for RBv7.x...
echo Adding the new Emulators required for RetroBat v7.x...
echo.

REM This section checks for the updated cGenius Emulator...
echo.
echo Checking for the updated cGenius Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "cgenius-emu-v1" goto SKIP
del /Q cgenius_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/cgenius_feb2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x cgenius_feb2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\cgenius >nul 2>&1
echo.
echo Copying files...
xcopy cgenius ..\..\emulators\cgenius\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q cgenius_feb2025.7z >nul 2>&1
rmdir /S /Q cgenius >nul 2>&1
echo cgenius-emu-v1 > cgenius-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated Kronos Emulator...
echo Checking for the updated Kronos Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "kronos-emu-v1" goto SKIP
del /Q kronos_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/kronos_feb2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x kronos_feb2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\kronos >nul 2>&1
echo.
echo Copying files...
xcopy kronos ..\..\emulators\kronos\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q kronos_feb2025.7z >nul 2>&1
rmdir /S /Q kronos >nul 2>&1
echo kronos-emu-v1 > kronos-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated Lime3DS Emulator...
echo Checking for the updated Lime3DS Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "lime3ds-emu-v1" goto SKIP
del /Q lime3ds_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/lime3ds_feb2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x lime3ds_feb2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\lime3ds >nul 2>&1
echo.
echo Copying files...
xcopy lime3ds ..\..\emulators\lime3ds\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q lime3ds_feb2025.7z >nul 2>&1
rmdir /S /Q lime3ds >nul 2>&1
echo lime3ds-emu-v1 > lime3ds-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated MagicEngine Emulator...
echo Checking for the updated MagicEngine Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "magicengine-emu-v1" goto SKIP
del /Q magicengine_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/magicengine_feb2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x magicengine_feb2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\magicengine >nul 2>&1
echo.
echo Copying files...
xcopy magicengine ..\..\emulators\magicengine\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q magicengine_feb2025.7z >nul 2>&1
rmdir /S /Q magicengine >nul 2>&1
echo magicengine-emu-v1 > magicengine-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated Mandarine Emulator...
echo Checking for the updated Mandarine Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "mandarine-emu-v1" goto SKIP
del /Q mandarine_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/mandarine_feb2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x mandarine_feb2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\mandarine >nul 2>&1
echo.
echo Copying files...
xcopy mandarine ..\..\emulators\mandarine\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q mandarine_feb2025.7z >nul 2>&1
rmdir /S /Q mandarine >nul 2>&1
echo mandarine-emu-v1 > mandarine-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated OpenJazz Emulator...
echo Checking for the updated OpenJazz Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "openjazz-emu-v1" goto SKIP
del /Q openjazz_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/openjazz_feb2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x openjazz_feb2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\openjazz >nul 2>&1
echo.
echo Copying files...
xcopy openjazz ..\..\emulators\openjazz\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q openjazz_feb2025.7z >nul 2>&1
rmdir /S /Q openjazz >nul 2>&1
echo openjazz-emu-v1 > openjazz-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated PDark Emulator...
echo Checking for the updated PDark Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "pdark-emu-v1" goto SKIP
del /Q pdark_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/pdark_feb2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x pdark_feb2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\pdark >nul 2>&1
echo.
echo Copying files...
xcopy pdark ..\..\emulators\pdark\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q pdark_feb2025.7z >nul 2>&1
rmdir /S /Q pdark >nul 2>&1
echo pdark-emu-v1 > pdark-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated Retroarch Emulator...
echo Checking for the updated Retroarch Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "retroarch-emu-v1" goto SKIP
del /Q retroarch_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/retroarch_feb2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x retroarch_feb2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\retroarch >nul 2>&1
echo.
echo Copying files...
xcopy retroarch ..\..\emulators\retroarch\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q retroarch_feb2025.7z >nul 2>&1
rmdir /S /Q retroarch >nul 2>&1
echo retroarch-emu-v1 > retroarch-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated ShadPS4 Emulator...
echo Checking for the updated ShadPS4 Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "shadps4-emu-v1" goto SKIP
del /Q shadps4_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/shadps4_feb2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x shadps4_feb2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\shadps4 >nul 2>&1
echo.
echo Copying files...
xcopy shadps4 ..\..\emulators\shadps4\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q shadps4_feb2025.7z >nul 2>&1
rmdir /S /Q shadps4 >nul 2>&1
echo shadps4-emu-v1 > shadps4-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated Xenia Emulator...
echo Checking for the updated Xenia Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "xenia-emu-v1" goto SKIP
del /Q xenia_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/xenia_feb2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x xenia_feb2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\xenia >nul 2>&1
echo.
echo Copying files...
xcopy xenia ..\..\emulators\xenia\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q xenia_feb2025.7z >nul 2>&1
rmdir /S /Q xenia >nul 2>&1
echo xenia-emu-v1 > xenia-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated Xenia-Canary Emulator...
echo Checking for the updated Xenia-Canary Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "xenia-canary-emu-v1" goto SKIP
del /Q xenia-canary_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/xenia-canary_feb2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x xenia-canary_feb2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\xenia-canary >nul 2>&1
echo.
echo Copying files...
xcopy xenia-canary ..\..\emulators\xenia-canary\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q xenia-canary_feb2025.7z >nul 2>&1
rmdir /S /Q xenia-canary >nul 2>&1
echo xenia-canary-emu-v1 > xenia-canary-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated Xenia-Manager Emulator...
echo Checking for the updated Xenia-Manager Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "xenia-manager-emu-v1" goto SKIP
del /Q xenia-manager_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/xenia-manager_feb2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x xenia-manager_feb2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\xenia-manager >nul 2>&1
echo.
echo Copying files...
xcopy xenia-manager ..\..\emulators\xenia-manager\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q xenia-manager_feb2025.7z >nul 2>&1
rmdir /S /Q xenia-manager >nul 2>&1
echo xenia-manager-emu-v1 > xenia-manager-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section checks for the updated Yabasanshiro Emulator...
echo Checking for the updated Yabasanshiro Emulator...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "yabasanshiro-emu-v1" goto SKIP
del /Q yabasanshiro_feb2025.7z >nul 2>&1
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/Emulator_Updates/yabasanshiro_feb2025.7z
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo Download Completed Successfully...
)
ping -n 1 127.0.0.1 > nul
echo.
7z x yabasanshiro_feb2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\yabasanshiro >nul 2>&1
echo.
echo Copying files...
xcopy yabasanshiro ..\..\emulators\yabasanshiro\ /S /E /I /Q /H /Y /R
ping -n 1 127.0.0.1 > nul
del /Q yabasanshiro_feb2025.7z >nul 2>&1
rmdir /S /Q yabasanshiro >nul 2>&1
echo yabasanshiro-emu-v1 > yabasanshiro-emu-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul

REM This section pulls down the latest custom system config files for RBv7.x...
echo Updating system config files...
echo.
ping -n 1 127.0.0.1 > nul
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
move /Y ".\PixN-RBv7.x-Custom-Systems\.emulationstation\*.cfg" ..\..\emulationstation\.emulationstation\
rmdir /S /Q ".\PixN-RBv7.x-Custom-Systems"
:SKIP
ping -n 1 127.0.0.1 > nul
echo.
goto THEMES

:CONFIGUREv6
echo.
echo Configuring v6.x
echo.

REM This section removes old custom system config files that are no longer needed...
echo.
echo Cleaning up old config files...
echo.
ping -n 1 127.0.0.1 > nul
del /Q ..\..\emulationstation\.emulationstation\es_systems_tg-16.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_examu.cfg >nul 2>&1
del /Q ..\..\emulationstation\.emulationstation\es_systems_segalindbergh.cfg >nul 2>&1
ping -n 1 127.0.0.1 > nul

REM This section pulls down the latest custom system config files for RBv6.x...
echo Updating system config files...
echo.
ping -n 1 127.0.0.1 > nul
..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/PixelNostalgia/PixN-RBv6.x-Custom-Systems.git
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo.
	echo Download Completed Successfully...
	echo.
)
move /Y ".\PixN-RBv6.x-Custom-Systems\.emulationstation\*.cfg" ..\..\emulationstation\.emulationstation\
rmdir /S /Q ".\PixN-RBv6.x-Custom-Systems"
:SKIP
ping -n 1 127.0.0.1 > nul
echo.

REM This section pulls down the latest es-checkversion script...
echo.
echo Updating es-checkversion script if required...
echo.
ping -n 1 127.0.0.1 > nul
IF EXIST "es-checkversion-v1" goto SKIP
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/es-checkversion-v6.4.cmd -O es-checkversion.cmd
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo.
	echo Download Completed Successfully...
	echo.
)
move /Y "es-checkversion.cmd" ..\..\emulationstation\
ping -n 1 127.0.0.1 > nul
echo es-checkversion-v1 > es-checkversion-v1
:SKIP
echo.
ping -n 1 127.0.0.1 > nul
goto THEMES


:THEMES
REM This section updates the PixN Themes using rclone...
set "colorCode=A"
color %colorCode%
cls
echo Checking for theme updates...
echo.
ping -n 1 127.0.0.1 > nul
del /Q "Full Download - Hypermax Plus PixN.bat" >nul 2>&1
del /Q "Full Download - Alekfull-ARTFLIX-PixN.bat" >nul 2>&1
del /Q "Full Download - Carbon-PixN.bat" >nul 2>&1
del /Q "Full Download - Ckau Book PixN.bat" >nul 2>&1
ping -n 1 127.0.0.1 > nul

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
ping -n 2 127.0.0.1 > nul

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
ping -n 2 127.0.0.1 > nul

IF EXIST "rclone-v3" goto RC-END
del /Q rc.7z >nul 2>&1
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/rc.7z -O rc.7z
if %ERRORLEVEL% neq 0 (
    echo rclone download failed! - Skipping...
    %handle_error%
	goto RC-END
) else (
    echo rclone download successful...
)
ping -n 1 127.0.0.1 > nul
7z x rc.7z -aoa -p22446688 -o.\
ping -n 1 127.0.0.1 > nul
del /Q rc.7z >nul 2>&1
echo rclone-v3 > rclone-v3
echo.
:RC-END
ping -n 2 127.0.0.1 > nul
del /Q rclone.conf >nul 2>&1
ping -n 2 127.0.0.1 > nul
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/rclone.conf -O rclone.conf
ping -n 1 127.0.0.1 > nul
echo.

:SKIP
cls
echo Checking for theme updates...

REM *******************************************************************
REM *******************************************************************
REM **************************Warning Message**************************
REM *******************************************************************
REM *******************************************************************

echo.
echo #########################################################
echo #                                                       #
echo #                   REMEMBER.........                   #
echo #      IF YOU HAVE PAID ANY FORM OF MONEY FOR THIS      #
echo #     OR ANY OTHER TEAM PIXEL NOSTALGIA / RGS BUILD     #
echo #                DEMAND YOUR MONEY BACK!                #
echo #                                                       #
echo #         THIS BUILD IS FREELEY AVAILABLE TO ALL        #
echo #                VIA OUR DISCORD SERVER:                #
echo #                                                       #
echo #             https://discord.gg/xNxrAr6sGv             #
echo #                                                       #
echo #########################################################
echo.

ping -n 1 127.0.0.1 > nul
echo Checking Hypermax-Plus-PixN for updates...
echo.
ping -n 1 127.0.0.1 > nul
rclone sync PixN-Themes-SH:/update/Themes/Hypermax-Plus-PixN ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN --progress

echo.
echo Checking Carbon-PixN for updates...
echo.
ping -n 1 127.0.0.1 > nul
rclone sync PixN-Themes-SH:/update/Themes/Carbon-PixN ..\..\emulationstation\.emulationstation\themes\Carbon-PixN --progress

echo.
echo Checking Ckau-Book-PixN for updates...
echo.
ping -n 1 127.0.0.1 > nul
rclone sync PixN-Themes-SH:/update/Themes/ckau-book-PixN ..\..\emulationstation\.emulationstation\themes\ckau-book-PixN --progress

echo.
echo Checking Ckau-Book for updates...
echo.
ping -n 1 127.0.0.1 > nul
rclone sync PixN-Themes-SH:/update/Themes/ckau-book ..\..\emulationstation\.emulationstation\themes\ckau-book --progress

REM *******************************************************************
REM *******************************************************************
REM **************************RetroDeck Config*************************
REM *******************************************************************
REM *******************************************************************

IF NOT EXIST "pixnretrodeck-ally-v1.0" goto SKIP
echo.
echo Applying final updates...
echo.
del /Q pixnretrodeck.svg >nul 2>&1
del /Q pixnretrodeck-hyper-silver.png >nul 2>&1
del /Q pixnretrodeck-hyper-system.png >nul 2>&1
del /Q pixnretrodeck-hyper-system1.png >nul 2>&1
del /Q pixnretrodeck-hyper-system2.png >nul 2>&1
ping -n 1 127.0.0.1 > nul
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck.svg
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck-hyper-silver.png
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck-hyper-system.png
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck-hyper-system1.png
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/Themes/RetroDeck/pixnretrodeck-hyper-system2.png
echo .
copy /Y pixnretrodeck.svg ..\..\emulationstation\.emulationstation\themes\Carbon-PixN\art\logos\retrobat.svg
echo .
copy /Y pixnretrodeck.svg ..\..\emulationstation\.emulationstation\themes\ckau-book-PixN\_inc\logos\retrobat.svg
echo .
copy /Y pixnretrodeck.svg ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\logos\retrobat.svg
copy /Y pixnretrodeck.svg ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\menu\logos\retrobat.svg
copy /Y pixnretrodeck-hyper-silver.png ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\_inc\menu\silver\retrobat.png
copy /Y pixnretrodeck-hyper-system.png ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\retrobat\_inc\system.png
copy /Y pixnretrodeck-hyper-system1.png ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\retrobat\_inc\system1.png
copy /Y pixnretrodeck-hyper-system2.png ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN\retrobat\_inc\system2.png
ping -n 1 127.0.0.1 > nul
del /Q pixnretrodeck.svg >nul 2>&1
del /Q pixnretrodeck-hyper-silver.png >nul 2>&1
del /Q pixnretrodeck-hyper-system.png >nul 2>&1
del /Q pixnretrodeck-hyper-system1.png >nul 2>&1
del /Q pixnretrodeck-hyper-system2.png >nul 2>&1
:SKIP


:END
echo.
echo.
echo All done, once this script closes, please restart RetroBat for any changes to take effect... :)
ping -n 5 127.0.0.1 > nul
popd

exit
