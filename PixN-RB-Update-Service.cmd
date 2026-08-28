@echo off
title PixN Update Service...
setlocal

pushd "%~dp0" >nul 2>&1 || goto BadPath
if /i not "%CD:~-15%"=="\emulators\pixn" goto BadPath
if not exist "..\..\RetroBat.exe" goto BadPath

rem Version 2.0
rem Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

:VBSDynamicBuild
SET TempVBSFile=%temp%\~tmpSendKeysTemp.vbs
IF EXIST "%TempVBSFile%" DEL /F /Q "%TempVBSFile%"
ECHO Set WshShell = WScript.CreateObject("WScript.Shell") >>"%TempVBSFile%"
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"
ECHO WshShell.SendKeys "{F11}"                            >>"%TempVBSFile%"
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"

CSCRIPT //nologo "%TempVBSFile%"

echo.
echo Updating the script...
echo.
ping -n 2 127.0.0.1 > nul
curl --insecure -O https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/PixN-RB-Update-Service-Payload.cmd
ping -n 2 127.0.0.1 > nul
echo.
start /wait PixN-RB-Update-Service-Payload.cmd
exit

:BadPath
color 0E
echo.
echo Make sure this is being run from your RetroBat\emulators\pixn folder.
echo.
pause
exit /b 1