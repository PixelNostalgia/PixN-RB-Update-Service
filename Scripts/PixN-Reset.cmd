@echo off
rem Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

echo.
echo This will make the PixN Update Service apply ALL updates on the next run...
echo.
echo Are you sure.....?
echo.
pause >nul 2>&1
echo Press 'Y' to continue or ctrl-c to exit.....
echo.
echo.
echo Clearing status files...
echo.

del /Q *-v? >nul 2>&1
del /Q "rb-7.3+bios_11-08-2025" >nul 2>&1
del /Q "rb-7.3+emulators_11-08-2025" >nul 2>&1

ping -n 3 127.0.0.1 > nul

:END
echo.
echo All done, the PixN Update Service will apply ALL updates on the next run...
ping -n 5 127.0.0.1 > nul

exit