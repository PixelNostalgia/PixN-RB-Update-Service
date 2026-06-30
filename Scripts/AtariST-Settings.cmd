@echo off
title Setting options for the AtariST pack...
REM Text color code for Light Green is A
set "colorCode=A"
color %colorCode%
echo.
echo Setting options for the AtariST pack...
echo.

REM This section sets options for the AtariST pack (1of6)...
setlocal

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Execute Windows PowerShell in Bypass mode
powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command ^
    "$path = '%filePath%'; " ^
    "try { " ^
    "    [xml]$xml = Get-Content -LiteralPath $path; " ^
    "    if ($xml.config -eq $null) { throw 'Root <config> node not found' } " ^
    "    @($xml.config.string | Where-Object { $_.name -eq 'atarist.core' }) | ForEach-Object { [void]$xml.config.RemoveChild($_) }; " ^
    "    $newNode = $xml.CreateElement('string'); " ^
    "    [void]$newNode.SetAttribute('name','atarist.core'); " ^
    "    [void]$newNode.SetAttribute('value','hatarib'); " ^
    "    [void]$xml.config.AppendChild($newNode); " ^
    "    $xml.Save($path); " ^
    "} catch { " ^
    "    Write-Host 'Error occurred:' $_.Exception.Message; " ^
    "    exit 1; " ^
    "}"

endlocal
REM *******************************************************************************************************************************************************************************************

REM This section sets options for the AtariST pack (2of6)...
setlocal

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Execute Windows PowerShell in Bypass mode
powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command ^
    "$path = '%filePath%'; " ^
    "try { " ^
    "    [xml]$xml = Get-Content -LiteralPath $path; " ^
    "    if ($xml.config -eq $null) { throw 'Root <config> node not found' } " ^
    "    @($xml.config.string | Where-Object { $_.name -eq 'atarist.emulator' }) | ForEach-Object { [void]$xml.config.RemoveChild($_) }; " ^
    "    $newNode = $xml.CreateElement('string'); " ^
    "    [void]$newNode.SetAttribute('name','atarist.emulator'); " ^
    "    [void]$newNode.SetAttribute('value','libretro'); " ^
    "    [void]$xml.config.AppendChild($newNode); " ^
    "    $xml.Save($path); " ^
    "} catch { " ^
    "    Write-Host 'Error occurred:' $_.Exception.Message; " ^
    "    exit 1; " ^
    "}"

endlocal
REM *******************************************************************************************************************************************************************************************

REM This section sets options for the AtariST pack (3of6)...
setlocal

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Execute Windows PowerShell in Bypass mode
powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command ^
    "$path = '%filePath%'; " ^
    "try { " ^
    "    [xml]$xml = Get-Content -LiteralPath $path; " ^
    "    if ($xml.config -eq $null) { throw 'Root <config> node not found' } " ^
    "    @($xml.config.string | Where-Object { $_.name -eq 'atarist.hatarib_machine' }) | ForEach-Object { [void]$xml.config.RemoveChild($_) }; " ^
    "    $newNode = $xml.CreateElement('string'); " ^
    "    [void]$newNode.SetAttribute('name','atarist.hatarib_machine'); " ^
    "    [void]$newNode.SetAttribute('value','3'); " ^
    "    [void]$xml.config.AppendChild($newNode); " ^
    "    $xml.Save($path); " ^
    "} catch { " ^
    "    Write-Host 'Error occurred:' $_.Exception.Message; " ^
    "    exit 1; " ^
    "}"

endlocal
REM *******************************************************************************************************************************************************************************************

REM This section sets options for the AtariST pack (4of6)...
setlocal

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Execute Windows PowerShell in Bypass mode
powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command ^
    "$path = '%filePath%'; " ^
    "try { " ^
    "    [xml]$xml = Get-Content -LiteralPath $path; " ^
    "    if ($xml.config -eq $null) { throw 'Root <config> node not found' } " ^
    "    @($xml.config.string | Where-Object { $_.name -eq 'atarist.hatarib_memory' }) | ForEach-Object { [void]$xml.config.RemoveChild($_) }; " ^
    "    $newNode = $xml.CreateElement('string'); " ^
    "    [void]$newNode.SetAttribute('name','atarist.hatarib_memory'); " ^
    "    [void]$newNode.SetAttribute('value','14336'); " ^
    "    [void]$xml.config.AppendChild($newNode); " ^
    "    $xml.Save($path); " ^
    "} catch { " ^
    "    Write-Host 'Error occurred:' $_.Exception.Message; " ^
    "    exit 1; " ^
    "}"

endlocal
REM *******************************************************************************************************************************************************************************************

REM This section sets options for the AtariST pack (5of6)...
setlocal

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Execute Windows PowerShell in Bypass mode
powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command ^
    "$path = '%filePath%'; " ^
    "try { " ^
    "    [xml]$xml = Get-Content -LiteralPath $path; " ^
    "    if ($xml.config -eq $null) { throw 'Root <config> node not found' } " ^
    "    @($xml.config.string | Where-Object { $_.name -eq 'atarist.hatarib_statusbar' }) | ForEach-Object { [void]$xml.config.RemoveChild($_) }; " ^
    "    $newNode = $xml.CreateElement('string'); " ^
    "    [void]$newNode.SetAttribute('name','atarist.hatarib_statusbar'); " ^
    "    [void]$newNode.SetAttribute('value','2'); " ^
    "    [void]$xml.config.AppendChild($newNode); " ^
    "    $xml.Save($path); " ^
    "} catch { " ^
    "    Write-Host 'Error occurred:' $_.Exception.Message; " ^
    "    exit 1; " ^
    "}"

endlocal
REM *******************************************************************************************************************************************************************************************

REM This section sets options for the AtariST pack (6of6)...
setlocal

REM Set variable for the file path (relative to the script's location)
set "filePath=..\..\emulationstation\.emulationstation\es_settings.cfg"

REM Execute Windows PowerShell in Bypass mode
powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command ^
    "$path = '%filePath%'; " ^
    "try { " ^
    "    [xml]$xml = Get-Content -LiteralPath $path; " ^
    "    if ($xml.config -eq $null) { throw 'Root <config> node not found' } " ^
    "    @($xml.config.string | Where-Object { $_.name -eq 'atarist.hatarib_tos' }) | ForEach-Object { [void]$xml.config.RemoveChild($_) }; " ^
    "    $newNode = $xml.CreateElement('string'); " ^
    "    [void]$newNode.SetAttribute('name','atarist.hatarib_tos'); " ^
    "    [void]$newNode.SetAttribute('value','etos1024k'); " ^
    "    [void]$xml.config.AppendChild($newNode); " ^
    "    $xml.Save($path); " ^
    "} catch { " ^
    "    Write-Host 'Error occurred:' $_.Exception.Message; " ^
    "    exit 1; " ^
    "}"

endlocal
REM *******************************************************************************************************************************************************************************************
