<#
Fix-RetrobatShortname.ps1
- Default target: ..\..\roms\*\gamelist.xml (relative to this script folder)
- Removes: <sortname>...</sortname> (and <sortname />)
- Adds flag comment: <!-- Shortname Fixed --> (safely after XML declaration)
- Skips files already flagged
- ALWAYS makes a timestamped backup if changes are made
- Logs actions to: .\logs\Fix-Gamelists_yyyyMMdd_HHmmss.log
- Supports: -WhatIf
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    # Optional override if you ever want it:
    # e.g. -RomsRoot "D:\RetroBat\roms"
    [string]$RomsRoot,

    [string]$FlagComment = "<!-- Shortname Fixed -->"
)

function Get-TextEncodingFromBom {
    param([byte[]]$Bytes)

    if ($Bytes.Length -ge 3 -and $Bytes[0] -eq 0xEF -and $Bytes[1] -eq 0xBB -and $Bytes[2] -eq 0xBF) {
        return New-Object System.Text.UTF8Encoding($true)  # UTF-8 with BOM
    }
    if ($Bytes.Length -ge 2 -and $Bytes[0] -eq 0xFF -and $Bytes[1] -eq 0xFE) {
        return New-Object System.Text.UnicodeEncoding($false, $true) # UTF-16 LE with BOM
    }
    if ($Bytes.Length -ge 2 -and $Bytes[0] -eq 0xFE -and $Bytes[1] -eq 0xFF) {
        return New-Object System.Text.UnicodeEncoding($true, $true)  # UTF-16 BE with BOM
    }

    # Typical gamelist.xml case: UTF-8 without BOM
    return New-Object System.Text.UTF8Encoding($false)
}

# --- Determine base dir (script folder preferred; fallback to current folder) ---
$baseDir = if ($PSScriptRoot -and (Test-Path $PSScriptRoot)) { $PSScriptRoot } else { (Get-Location).Path }

# --- Determine RetroBat roms root ---
if (-not $RomsRoot -or [string]::IsNullOrWhiteSpace($RomsRoot)) {
    # Running from ...\RetroBat\emulators\pixn  =>  roms is ..\..\roms
    $RomsRoot = Join-Path $baseDir "..\..\roms"
}
try {
    $RomsRoot = (Resolve-Path -LiteralPath $RomsRoot).Path
} catch {
    throw "RomsRoot not found: $RomsRoot  (baseDir=$baseDir). Are you running from ...\RetroBat\emulators\pixn ?"
}

# --- Logging setup ---
$logsDir  = Join-Path $baseDir "logs"
if (-not (Test-Path $logsDir)) { New-Item -Path $logsDir -ItemType Directory -Force | Out-Null }

$runStamp = Get-Date -Format "yyyyMMdd_HHmmss"
$logPath  = Join-Path $logsDir ("Fix-Gamelists_{0}.log" -f $runStamp)

function Write-Log {
    param([string]$Message)
    $line = "{0}  {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $Message
    Add-Content -LiteralPath $logPath -Value $line -Encoding UTF8
}

Write-Log "=== START ==="
Write-Log ("BaseDir={0}" -f $baseDir)
Write-Log ("RomsRoot={0}" -f $RomsRoot)
Write-Log ("FlagComment={0}" -f $FlagComment)
Write-Log ("WhatIf={0}" -f ([bool]$WhatIfPreference))

# --- Build regex for flag detection ---
$flagInner = $FlagComment -replace '^\s*<!--\s*', '' -replace '\s*-->\s*$', ''
$flagLineRx = "(?m)^\s*(?:\uFEFF)?<!--\s*" + [regex]::Escape($flagInner) + "\s*-->\s*$"

# --- Find gamelist.xml files (exactly roms\<system>\gamelist.xml) ---
$files = Get-ChildItem -Path (Join-Path $RomsRoot "*\gamelist.xml") -File -ErrorAction SilentlyContinue

if (-not $files) {
    Write-Log "No gamelist.xml files found under roms\*\gamelist.xml"
    Write-Warning "No gamelist.xml files found under: $RomsRoot\*\gamelist.xml"
    return
}

$stats = [ordered]@{ Total = 0; Updated = 0; Skipped = 0; Failed = 0 }

foreach ($f in $files) {
    $stats.Total++

    try {
        $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
        $enc   = Get-TextEncodingFromBom -Bytes $bytes
        $text  = $enc.GetString($bytes)

        # Skip if already flagged
        if ([regex]::IsMatch($text, $flagLineRx)) {
            $stats.Skipped++
            Write-Log ("SKIP (flagged)  {0}" -f $f.FullName)
            continue
        }

        $nl = if ($text -match "`r`n") { "`r`n" } else { "`n" }

        # Count sortname occurrences in original
        $sortMatches = [regex]::Matches($text, '(?s)<sortname\b[^>]*?(?:/>|>.*?</sortname>)')
        $sortCount   = $sortMatches.Count

        $new = $text

        # 1) Remove whole <sortname> lines (most common formatting)
        $new = [regex]::Replace(
            $new,
            '(?ms)^[ \t]*<sortname\b[^>]*?(?:/>|>.*?</sortname>)\s*\r?\n?',
            ''
        )

        # 2) Remove any remaining inline <sortname> blocks
        $new = [regex]::Replace(
            $new,
            '(?s)<sortname\b[^>]*?(?:/>|>.*?</sortname>)',
            ''
        )

        # Add flag comment safely AFTER XML declaration if present
        if ($new -match "^\uFEFF?<\?xml") {

            $mLine = [regex]::Match(
                $new,
                "^\uFEFF?<\?xml[^?]*\?>[ \t]*\r?\n",
                [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
            )

            if ($mLine.Success) {
                $new = $new.Insert($mLine.Length, $FlagComment + $nl)
            }
            else {
                $m = [regex]::Match(
                    $new,
                    "^\uFEFF?<\?xml[^?]*\?>",
                    [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
                )
                $new = $new.Insert($m.Length, $nl + $FlagComment + $nl)
            }
        }
        else {
            # No XML declaration: a top-level comment is fine
            $new = $FlagComment + $nl + $new
        }

        if ($new -eq $text) {
            # This would be unusual (since we add a flag), but handle it anyway
            Write-Log ("NOCHANGE        {0}" -f $f.FullName)
            continue
        }

        # Backup name is unique per run
        $backupPath = "{0}.bak.{1}" -f $f.FullName, $runStamp

        $actionLabel = "UPDATED"
        if (-not $PSCmdlet.ShouldProcess($f.FullName, "Backup + update gamelist.xml")) {
            $actionLabel = "WOULD UPDATE"
        }
        else {
            # Write backup + updated content using original encoding
            [System.IO.File]::WriteAllText($backupPath, $text, $enc)
            [System.IO.File]::WriteAllText($f.FullName,  $new,  $enc)
            $stats.Updated++
        }

        Write-Log ("{0}  {1}  removedSortname={2}  backup={3}" -f $actionLabel, $f.FullName, $sortCount, $backupPath)
    }
    catch {
        $stats.Failed++
        Write-Log ("FAILED          {0}  error={1}" -f $f.FullName, $_.Exception.Message)
        Write-Warning ("Failed: {0} - {1}" -f $f.FullName, $_.Exception.Message)
    }
}

Write-Log ("=== END === Total={0} Updated={1} Skipped={2} Failed={3}" -f $stats.Total, $stats.Updated, $stats.Skipped, $stats.Failed)
Write-Host ("Done. Log: {0}" -f $logPath)
Write-Host ("Total={0} Updated={1} Skipped={2} Failed={3}" -f $stats.Total, $stats.Updated, $stats.Skipped, $stats.Failed)