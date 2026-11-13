@echo off
setlocal EnableDelayedExpansion

rem Output file, saved next to this batch file
set "outfile=%~dp0PixN-RB-Folder.txt"

rem Folder this batch file is launched from (drop the trailing backslash)
set "folder=%~dp0"
set "folder=%folder:~0,-1%"

rem Step 1: record the folder path in the text file
>"%outfile%" echo %folder%

rem Step 2: read it back and remove \emulationstation\.emulationstation\scripts\start from the end
set "line="
set /p line=<"%outfile%"

set "suffix=\emulationstation\.emulationstation\scripts\start"
set "suffixlen=49"

if /i "!line:~-%suffixlen%!"=="%suffix%" (
    set "line=!line:~0,-%suffixlen%!"
)

rem Step 3: write the trimmed path back to the file
>"%outfile%" echo !line!

endlocal

set /p PixN-RB-Folder=<"%~dp0PixN-RB-Folder.txt"

setx PixN-RB-Folder "%PixN-RB-Folder%"
