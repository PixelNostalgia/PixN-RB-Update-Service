@echo off

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

rem Read from ASCII.txt and visualize ASCII art
type ASCII.txt

echo .
echo Pixel Nostalgia updater running...
echo Version 1.22
echo .
ping -n 2 127.0.0.1 > nul

REM This section pulls down the latest custom system config files...
echo .
echo Updating system config files...
echo .
ping -n 2 127.0.0.1 > nul
..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/RGS-MBU/emulationstation.git
move /Y ".\emulationstation\.emulationstation\*.cfg" ..\..\emulationstation\.emulationstation\
rmdir /S /Q ".\emulationstation"
ping -n 2 127.0.0.1 > nul
echo .

REM This section pulls down the latest PixN Custom Collections...
echo .
echo Updating the PixN Custom Collections...
echo .
ping -n 2 127.0.0.1 > nul
rmdir /S /Q ".\PixN-Collections"
md "..\..\emulationstation\.emulationstation\collections" >nul 2>&1
..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/PixelNostalgia/PixN-Collections.git
move /Y ".\PixN-Collections\*.cfg" ..\..\emulationstation\.emulationstation\collections\
rmdir /S /Q ".\PixN-Collections"
ping -n 2 127.0.0.1 > nul
echo .

REM This section pulls down the latest es-checkversion script...
echo .
echo Updating es-checkversion script...
echo .
ping -n 2 127.0.0.1 > nul
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/es-checkversion-v6.4.cmd -O es-checkversion.cmd
move /Y "es-checkversion.cmd" ..\..\emulationstation\
ping -n 2 127.0.0.1 > nul
echo .

REM This section restores the PixN Update Service artwork...
REM *
REM ***The gamelist.xml file will possibly need updating if the version of RetroBat is upgraded...**
REM *
REM echo Restoring PixN Update Service artwork...
REM ping -n 2 127.0.0.1 > nul
REM wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/RB-es_menu-gamelist.xml -O gamelist.xml
REM ping -n 2 127.0.0.1 > nul
REM move /Y "gamelist.xml" ..\..\system\es_menu\
REM ping -n 2 127.0.0.1 > nul
REM echo .

REM Download and Call the PowerShell script
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Add-PixNService.ps1 -O Add-PixNService.ps1
ping -n 2 127.0.0.1 > nul
powershell -ExecutionPolicy Bypass -File "Add-PixNService.ps1"
ping -n 2 127.0.0.1 > nul
echo .

REM This section adds the PixN Update Service to the system wheel...
REM echo Adds the PixN Update Service to the system wheel...
REM echo .
REM ping -n 2 127.0.0.1 > nul
REM wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/pixn.7z -O pixn.7z
REM ping -n 2 127.0.0.1 > nul
REM @echo on
REM 7z x pixn.7z -aoa -p22446688 -o..\..\roms\
REM ping -n 2 127.0.0.1 > nul
REM echo .
REM Clean up PixN from System Wheel
rmdir /S /Q "..\..\roms\pixn" >nul 2>&1

REM This section applies the PinballFX and Piball M Fix...
echo PinballFX and Piball M Fix...
echo .
ping -n 2 127.0.0.1 > nul
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Pin-Lic.7z -O Pin-Lic.7z
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/7z.exe -O 7z.exe
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/7z.dll -O 7z.dll
ping -n 2 127.0.0.1 > nul
REM @echo on
7z x Pin-Lic.7z -aoa -p22446688 -o.\
echo .
md "%localappdata%\PinballFX"
md "%localappdata%\PinballM"

xcopy PinballFX "%localappdata%\PinballFX" /S /E /D /I /Y
echo Copying files...
xcopy PinballM "%localappdata%\PinballM" /S /E /D /I /Y

robocopy "PinballFX\Saved\SaveGames" "%localappdata%\PinballFX\Saved\SaveGames" /mir /xd 76561197981264163 /w:0 /r:0
robocopy "PinballM\Saved\SaveGames" "%localappdata%\PinballM\Saved\SaveGames" /mir /xd 76561197981264163 /w:0 /r:0

rmdir /S /Q "PinballFX"
rmdir /S /Q "PinballM"
del /Q Pin-Lic.7z
ping -n 2 127.0.0.1 > nul

REM This section applies Zaccaria Pinball config...
REM echo Zaccaria Pinball Config...
echo .
ping -n 2 127.0.0.1 > nul
IF EXIST "ZP-v1" goto SKIP
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/ZP.7z -O ZP.7z
ping -n 2 127.0.0.1 > nul
7z x ZP.7z -aoa -p22446688 -o.\
echo .
ver | find "XP" > nul
    if %ERRORLEVEL% == 0 SET PixN-MyDocs=%USERPROFILE%\My Documents
    if %ERRORLEVEL% == 1 FOR /f "tokens=3" %%x IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Personal"') do (set PixN-MyDocs=%%x)
echo Copying files...
md "%PixN-MyDocs%\Zaccaria_Pinball" >nul 2>&1
echo n | copy /-y "Zaccaria_Pinball" "%PixN-MyDocs%\Zaccaria_Pinball"
ping -n 2 127.0.0.1 > nul
rmdir /S /Q "Zaccaria_Pinball"
del /Q ZP.7z
echo .
ping -n 1 127.0.0.1 > nul
echo ZP-v1 > ZP-v1
:skip

REM This section adds OpenAL32.dll if required...
echo Checking if OpenAL32.dll is required...
echo .
ping -n 2 127.0.0.1 > nul
IF NOT EXIST ..\..\roms\zaccariapinball\ZaccariaPinball.pc\ goto SKIP
IF EXIST ..\..\roms\zaccariapinball\ZaccariaPinball.pc\OpenAL32.dll goto SKIP

wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/OpenAL32.dll -O OpenAL32.dll
ping -n 2 127.0.0.1 > nul
copy OpenAL32.dll ..\..\roms\zaccariapinball\ZaccariaPinball.pc\
echo .
del /Q OpenAL32.dll
:skip

REM This section checks for updated Radio stations...
echo Checking for updated Radio Stations...
echo .
ping -n 2 127.0.0.1 > nul
IF EXIST "Radio-v2" goto SKIP
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/radio.7z.001 -O radio.7z.001
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/radio.7z.002 -O radio.7z.002
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/radio.7z.003 -O radio.7z.003
ping -n 2 127.0.0.1 > nul
7z x radio.7z.001 -aoa -p22446688 -o..\..\roms\radio\
echo .
del /Q radio.7z.001
del /Q radio.7z.002
del /Q radio.7z.003

echo Radio-v2 > Radio-v2
:skip

REM This sections fixes the version of the Archmendes BIOS files...
echo Downloading updated Archmendes BIOS files...
echo .
ping -n 2 127.0.0.1 > nul
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/arch-b.7z -O arch-b.7z
ping -n 2 127.0.0.1 > nul
echo .
7z x arch-b.7z -aoa -p22446688 -o.\
echo .
echo Moving files...
move /Y "aa310.zip" ..\..\bios\
move /Y "archimedes_keyboard.zip" ..\..\bios\
ping -n 2 127.0.0.1 > nul
del /Q arch-b.7z
echo .
ping -n 2 127.0.0.1 > nul

REM This section adds the Skylanders files to the Dolphin Emulator...
echo Adding Skylanders files to the Dolphin Emulator...
echo .
ping -n 2 127.0.0.1 > nul

IF EXIST "Sky-v1" goto SKIP

wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Sky.7z -O Sky.7z
ping -n 2 127.0.0.1 > nul
echo .
7z x Sky.7z -aoa -p22446688 -o.\
md ..\..\emulators\dolphin-emu >nul 2>&1
md ..\..\emulators\dolphin-emu\User >nul 2>&1
echo .
echo Copying files...
xcopy Skylanders ..\..\emulators\dolphin-emu\User\Skylanders\ /S /E /I /Q /H /Y /R
ping -n 2 127.0.0.1 > nul
del /Q Sky.7z
rmdir /S /Q Skylanders >nul 2>&1

echo Sky-v1 > Sky-v1
:skip
echo .
ping -n 2 127.0.0.1 > nul

REM This section checks for the updated Hypseus Emulator...
echo Checking for the updated Hypseus Emulator...
echo .
ping -n 2 127.0.0.1 > nul

IF EXIST "Hypseus-v1" goto SKIP

wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/hypseus.7z.001 -O hypseus.7z.001
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/hypseus.7z.002 -O hypseus.7z.002
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/hypseus.7z.003 -O hypseus.7z.003
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/hypseus.7z.004 -O hypseus.7z.004
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/hypseus.7z.005 -O hypseus.7z.005
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/hypseus.7z.006 -O hypseus.7z.006
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/hypseus.7z.007 -O hypseus.7z.007
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/hypseus.7z.008 -O hypseus.7z.008
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/hypseus.7z.009 -O hypseus.7z.009
ping -n 2 127.0.0.1 > nul
echo .
7z x hypseus.7z.001 -aoa -p22446688 -o.\
md ..\..\emulators\hypseus >nul 2>&1
echo .
echo Copying files...
xcopy hypseus ..\..\emulators\hypseus\ /S /E /I /Q /H /Y /R
ping -n 2 127.0.0.1 > nul
del /Q hypseus.7z.001
del /Q hypseus.7z.002
del /Q hypseus.7z.003
del /Q hypseus.7z.004
del /Q hypseus.7z.005
del /Q hypseus.7z.006
del /Q hypseus.7z.007
del /Q hypseus.7z.008
del /Q hypseus.7z.009
rmdir /S /Q hypseus >nul 2>&1

echo Hypseus-v1 > Hypseus-v1
:skip
echo .

REM This section checks for the updated 3dSen Emulator...
echo Checking for the updated 3dSen Emulator...
echo .
ping -n 2 127.0.0.1 > nul

IF EXIST "3dSen-v1" goto SKIP

wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/3d-N.7z.001 -O 3d-N.7z.001
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/3d-N.7z.002 -O 3d-N.7z.002
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/3d-N.7z.003 -O 3d-N.7z.003
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/3d-N.7z.004 -O 3d-N.7z.004
ping -n 2 127.0.0.1 > nul
echo .
7z x 3d-N.7z.001 -aoa -p22446688 -o.\
md ..\..\emulators\3dsen >nul 2>&1
echo .
echo Copying files...
xcopy 3dsen ..\..\emulators\3dsen\ /S /E /I /Q /H /Y /R
ping -n 2 127.0.0.1 > nul
del /Q 3d-N.7z.001
del /Q 3d-N.7z.002
del /Q 3d-N.7z.003
del /Q 3d-N.7z.004
rmdir /S /Q 3dsen >nul 2>&1

echo 3dSen-v1 > 3dSen-v1
:skip
echo .
ping -n 2 127.0.0.1 > nul

REM This section checks for the updated TeknoParrot Emulator...
echo Checking for the updated TeknoParrot Emulator...
echo .
ping -n 2 127.0.0.1 > nul

IF EXIST "TeknoParrot-v3" goto SKIP

del /Q xUH7WGQ4*.* >nul 2>&1
wget https://pixeldrain.com/api/filesystem/xUH7WGQ4
ren xUH7WGQ4 teknoparrot_jan2025.7z
ping -n 2 127.0.0.1 > nul
echo .
7z x teknoparrot_jan2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\teknoparrot >nul 2>&1
echo .
echo Copying files...
xcopy teknoparrot ..\..\emulators\teknoparrot\ /S /E /I /Q /H /Y /R
ping -n 2 127.0.0.1 > nul
del /Q teknoparrot_jan2025.7z
rmdir /S /Q teknoparrot >nul 2>&1

echo TeknoParrot-v3 > TeknoParrot-v3
:skip
echo .
ping -n 2 127.0.0.1 > nul

REM This section checks for the updated Virtual Pinball Emulator...
echo Checking for the updated Virtual Pinball Emulator...
echo .
ping -n 2 127.0.0.1 > nul

IF EXIST "VPinball-v2" goto SKIP

del /Q tt4eBrw2*.* >nul 2>&1
wget https://pixeldrain.com/api/filesystem/tt4eBrw2
ren tt4eBrw2 vpinball_jan2025.7z
ping -n 2 127.0.0.1 > nul
echo .
7z x vpinball_jan2025.7z -aoa -p22446688 -o.\
md ..\..\emulators\vpinball >nul 2>&1
echo .
echo Copying files...
xcopy vpinball ..\..\emulators\vpinball\ /S /E /I /Q /H /Y /R
ping -n 2 127.0.0.1 > nul
del /Q vpinball_jan2025.7z
rmdir /S /Q vpinball >nul 2>&1

echo VPinball-v2 > VPinball-v2
:skip
echo .
ping -n 2 127.0.0.1 > nul

REM This section checks for the updated Switch Emulators...
echo Checking for the updated Switch Emulators...
echo .
ping -n 2 127.0.0.1 > nul

IF EXIST "Switch-v1" goto SKIP

del /Q sBugmhpq*.* >nul 2>&1
wget https://pixeldrain.com/api/filesystem/sBugmhpq
ren sBugmhpq switch_dec2024.7z
ping -n 2 127.0.0.1 > nul
echo .
7z x switch_dec2024.7z -aoa -p22446688 -o.\
echo .
echo Copying files...
xcopy ryujinx ..\..\emulators\ryujinx\ /S /E /I /Q /H /Y /R
xcopy yuzu ..\..\emulators\yuzu\ /S /E /I /Q /H /Y /R
xcopy suyu ..\..\emulators\suyu\ /S /E /I /Q /H /Y /R
xcopy sudachi ..\..\emulators\sudachi\ /S /E /I /Q /H /Y /R
xcopy swsaves ..\..\saves\switch\ /S /E /I /Q /H /Y /R
ping -n 2 127.0.0.1 > nul
del /Q switch_dec2024.7z
rmdir /S /Q ryujinx >nul 2>&1
rmdir /S /Q yuzu >nul 2>&1
rmdir /S /Q suyu >nul 2>&1
rmdir /S /Q sudachi >nul 2>&1
rmdir /S /Q swsaves >nul 2>&1

echo Switch-v1 > Switch-v1
:skip
echo .
ping -n 2 127.0.0.1 > nul

REM This section checks for the updated Xash3D FWGS Emulator...
REM echo Checking for the updated Xash3D FWGS Emulator...
REM echo .
REM ping -n 2 127.0.0.1 > nul

REM IF EXIST "Xash3D-FWGS-v1" goto SKIP

REM del /Q CXfrB4pN*.* >nul 2>&1
REM wget https://pixeldrain.com/api/filesystem/CXfrB4pN
REM ren CXfrB4pN xash3d-fwgs_oct2024.7z
REM ping -n 2 127.0.0.1 > nul
REM echo .
REM 7z x xash3d-fwgs_oct2024.7z -aoa -p22446688 -o.\
REM md ..\..\emulators\xash3d-fwgs >nul 2>&1
REM echo .
REM echo Copying files...
REM xcopy xash3d-fwgs ..\..\emulators\xash3d-fwgs\ /S /E /I /Q /H /Y /R
REM ping -n 2 127.0.0.1 > nul
REM del /Q xash3d-fwgs_oct2024.7z
REM rmdir /S /Q xash3d-fwgs >nul 2>&1

REM echo Xash3D-FWGS-v1 > Xash3D-FWGS-v1
REM :skip
REM echo .

REM This section downloads a tiny file so we can see how many people are using the Update Service...
del /Q NYcXqrtb*.* >nul 2>&1
del /Q PixN-Stats >nul 2>&1
wget https://pixeldrain.com/api/filesystem/NYcXqrtb
ren NYcXqrtb PixN-Stats
ping -n 2 127.0.0.1 > nul

REM This section enables HD texture packs for the NES HD system...
setlocal

REM Set the working directory to the script's location
REM cd /d "%~dp0"

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Backup the original file
copy "%filePath%" "%filePath%.bak"

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

REM The theme updates section needs to be the last thing to run as it changes the current directory...

REM IF EXIST "Takeown-Run" goto SKIP
REM cd ..\..\emulationstation\.emulationstation\themes
REM takeown /F Carbon-PixN /R /D Y
REM takeown /F ckau-book-PixN /R /D Y
REM takeown /F Hypermax-Plus-PixN /R /D Y
REM cd ..\..\..\emulators\pixn
REM echo Takeown-Run > Takeown-Run
REM :skip

echo .
echo Applying git config...
del /Q "Full Download - Hypermax Plus PixN.bat" >nul 2>&1
del /Q "Full Download - Alekfull-ARTFLIX-PixN.bat" >nul 2>&1
del /Q "Full Download - Carbon-PixN.bat" >nul 2>&1
del /Q "Full Download - Ckau Book PixN.bat" >nul 2>&1
wget "https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Full Download - Hypermax Plus PixN.bat" -O "Full Download - Hypermax Plus PixN.bat" >nul 2>&1
wget "https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Full Download - Alekfull-ARTFLIX-PixN.bat" -O "Full Download - Alekfull-ARTFLIX-PixN.bat" >nul 2>&1
wget "https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Full Download - Carbon-PixN.bat" -O "Full Download - Carbon-PixN.bat" >nul 2>&1
wget "https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Full Download - Ckau Book PixN.bat" -O "Full Download - Ckau Book PixN.bat" >nul 2>&1
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/gitconfig -O gitconfig >nul 2>&1
move /Y gitconfig .\PortableGit\etc\gitconfig >nul 2>&1

echo .
echo Updating Hypermax-Plus-PixN Theme...
cd ..\..\emulationstation\.emulationstation\themes\Hypermax-Plus-PixN
..\..\..\..\emulators\pixn\PortableGit\cmd\git pull
echo .
ping -n 2 127.0.0.1 > nul

rem Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

echo Updating Ckau-Book-PixN Theme...
cd ..\ckau-book-PixN
..\..\..\..\emulators\pixn\PortableGit\cmd\git pull
echo .
ping -n 2 127.0.0.1 > nul

rem Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

echo Updating Carbon-PixN Theme...
cd ..\Carbon-PixN
..\..\..\..\emulators\pixn\PortableGit\cmd\git pull
echo .
ping -n 2 127.0.0.1 > nul

rem Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

rem echo Updating Alekfull-ARTFLIX-PixN Theme...
rem cd ..\Alekfull-ARTFLIX-PixN
rem ..\..\..\..\emulators\pixn\PortableGit\cmd\git pull
rem echo .
rem ping -n 2 127.0.0.1 > nul

rem Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

echo .
echo All done, once this script closes, please restart RetroBat for any changes to take effect... :)
ping -n 5 127.0.0.1 > nul

exit
