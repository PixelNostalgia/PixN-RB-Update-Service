#requires -version 3.0
param(
    [string]$BaseDir,
    [int]$MinimumFreeSpaceMB = 2048
)

$ErrorActionPreference = 'Stop'
$LogFile = $null

try {
    $ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

    if ([string]::IsNullOrWhiteSpace($BaseDir)) {
        # Normal expected layout:
        #   <RetroBat folder>\emulators\pixn\Scripts\Set-DOSBoxPureBootOSFreeSpace.ps1
        # BaseDir should be:
        #   <RetroBat folder>\emulators\pixn
        $BaseDir = Split-Path -Parent $ScriptDir
    }

    # Clean up any stray quotes/spaces and normalize the base path
    $BaseDir = $BaseDir.Trim().Trim('"')
    $BaseDir = [System.IO.Path]::GetFullPath($BaseDir)

    # If someone accidentally passes the Scripts folder as BaseDir,
    # normalize it back to the PixN base folder.
    if ((Split-Path -Leaf $BaseDir) -ieq 'Scripts') {
        $BaseDir = Split-Path -Parent $BaseDir
        $BaseDir = [System.IO.Path]::GetFullPath($BaseDir)
    }

    $ScriptsDir = Join-Path $BaseDir 'Scripts'
    $LogDir     = Join-Path $ScriptsDir 'Logs'
    $LogFile    = Join-Path $LogDir 'Set-DOSBoxPureBootOSFreeSpace.log'

    if (-not (Test-Path -LiteralPath $LogDir)) {
        New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
    }

    # Overwrite log on each run
    $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Set-Content -LiteralPath $LogFile -Value "[$stamp] Starting Set-DOSBoxPureBootOSFreeSpace.ps1"

    function Write-Log {
        param([string]$Message)

        $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
        Add-Content -LiteralPath $LogFile -Value "[$stamp] $Message"
    }

    Write-Log "ScriptDir: $ScriptDir"
    Write-Log "BaseDir: $BaseDir"
    Write-Log "ScriptsDir: $ScriptsDir"
    Write-Log "LogDir: $LogDir"
    Write-Log "MinimumFreeSpaceMB: $MinimumFreeSpaceMB"

    if ($MinimumFreeSpaceMB -lt 2048) {
        Write-Log "MinimumFreeSpaceMB was lower than 2048. Forcing desired value to 2048."
        $MinimumFreeSpaceMB = 2048
    }

    # Expected layout:
    #   BaseDir    = <RetroBat folder>\emulators\pixn
    #   ConfigPath = <RetroBat folder>\emulators\retroarch\retroarch-core-options.cfg
    $ConfigPath = Join-Path $BaseDir '..\retroarch\retroarch-core-options.cfg'
    $ConfigPath = [System.IO.Path]::GetFullPath($ConfigPath)

    Write-Log "ConfigPath: $ConfigPath"

    if (-not (Test-Path -LiteralPath $ConfigPath)) {
        throw "Config file not found: $ConfigPath"
    }

    $OptionName   = 'dosbox_pure_bootos_dfreespace'
    $DesiredValue = $MinimumFreeSpaceMB
    $DesiredLine  = '{0} = "{1}"' -f $OptionName, $DesiredValue

    # RetroArch core options are plain text key/value lines, not XML.
    # Treat lines beginning with # or ; as comments and ignore them.
    $OptionPattern = '^\s*(?![#;])' + [regex]::Escape($OptionName) + '\s*=\s*(?<raw>.*?)\s*$'

    $Lines = @([System.IO.File]::ReadAllLines($ConfigPath))
    $OptionMatches = @()

    for ($i = 0; $i -lt $Lines.Count; $i++) {
        $match = [regex]::Match($Lines[$i], $OptionPattern)

        if ($match.Success) {
            $rawValue = $match.Groups['raw'].Value.Trim()
            $cleanValue = $rawValue.Trim('"').Trim("'").Trim()
            $parsedValue = 0
            $isNumeric = [int]::TryParse($cleanValue, [ref]$parsedValue)

            $OptionMatches += New-Object PSObject -Property @{
                Index     = $i
                RawValue  = $rawValue
                IsNumeric = $isNumeric
                Value     = $parsedValue
            }
        }
    }

    if ($OptionMatches.Count -eq 0) {
        Write-Log "$OptionName was not found. Adding: $DesiredLine"

        $Lines = @($Lines) + $DesiredLine
        [System.IO.File]::WriteAllLines($ConfigPath, $Lines, [System.Text.Encoding]::Default)

        Write-Log "$OptionName added successfully"
        exit 0
    }

    # If duplicate active entries exist, use the last active entry as the effective RetroArch option.
    $EffectiveMatch = $OptionMatches[$OptionMatches.Count - 1]

    if ($OptionMatches.Count -eq 1) {
        Write-Log "Found 1 active $OptionName entry"
    }
    else {
        Write-Log "Found $($OptionMatches.Count) active $OptionName entries"
    }

    Write-Log "Effective line index: $($EffectiveMatch.Index)"
    Write-Log "Effective raw value: $($EffectiveMatch.RawValue)"

    if ($EffectiveMatch.IsNumeric -and $EffectiveMatch.Value -ge $DesiredValue) {
        Write-Log "$OptionName is already set to $($EffectiveMatch.Value), which is greater than or equal to $DesiredValue. No change needed."
        exit 0
    }

    if ($EffectiveMatch.IsNumeric) {
        Write-Log "$OptionName is set to $($EffectiveMatch.Value), which is lower than $DesiredValue. Updating to $DesiredValue."
    }
    else {
        Write-Log "$OptionName value is not numeric. Updating to $DesiredValue."
    }

    $Lines[$EffectiveMatch.Index] = $DesiredLine
    [System.IO.File]::WriteAllLines($ConfigPath, $Lines, [System.Text.Encoding]::Default)

    Write-Log "$OptionName updated successfully"
    exit 0
}
catch {
    try {
        if ($LogFile) {
            $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
            Add-Content -LiteralPath $LogFile -Value "[$stamp] ERROR: $($_.Exception.Message)"
        }
    } catch {}

    Write-Host "ERROR: $($_.Exception.Message)"
    exit 1
}
