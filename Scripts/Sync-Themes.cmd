@echo off
title PixN Update Service...
cd ..
pushd %1

REM Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

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