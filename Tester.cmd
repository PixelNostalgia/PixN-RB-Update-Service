REM This section removes old EPIC and Steam shortcuts...
echo Removing old EPIC and Steam shortcuts...
echo.
REM IF EXIST "epic-steam-check-v1" goto GOTPS
wget https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/Remove-Epic-Steam-Shortcuts.ps1 -O Remove-Epic-Steam-Shortcuts.ps1
if %ERRORLEVEL% neq 0 (
    echo Download Failed! - Skipping...
    %handle_error%
	goto SKIP
) else (
    echo.
	echo Download Completed Successfully...
	echo.
)
REM echo epic-steam-check-v1 > epic-steam-check-v1
:GOTPS
ping -n 1 127.0.0.1 > nul
powershell -ExecutionPolicy Bypass -File "Remove-Epic-Steam-Shortcuts.ps1"
echo.
ping -n 1 127.0.0.1 > nul
:SKIP
echo.

pause
