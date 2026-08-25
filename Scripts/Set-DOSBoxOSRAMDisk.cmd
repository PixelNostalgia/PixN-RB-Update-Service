@echo off
title Setting options for the Windows 98 pack...
REM Text color code for Light Green is A
set "colorCode=A"
color %colorCode%
echo.
echo Setting options for the Windows 98 pack...
echo.
ping -n 2 127.0.0.1 >nul

setlocal

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Execute Windows PowerShell in Bypass mode
powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command ^
    "$path = '%filePath%'; " ^
    "try { " ^
    "    [xml]$xml = Get-Content -LiteralPath $path; " ^
    "    if ($xml.config -eq $null) { throw 'Root <config> node not found' } " ^
    "    @($xml.config.string | Where-Object { $_.name -eq 'dos.dosbox_pure_bootos_ramdisk' }) | ForEach-Object { [void]$xml.config.RemoveChild($_) }; " ^
    "    $newNode = $xml.CreateElement('string'); " ^
    "    [void]$newNode.SetAttribute('name','dos.dosbox_pure_bootos_ramdisk'); " ^
    "    [void]$newNode.SetAttribute('value','true'); " ^
    "    [void]$xml.config.AppendChild($newNode); " ^
    "    $xml.Save($path); " ^
    "} catch { " ^
    "    Write-Host 'Error occurred:' $_.Exception.Message; " ^
    "    exit 1; " ^
    "}"

endlocal
REM *******************************************************************************************************************************************************************************************
exit