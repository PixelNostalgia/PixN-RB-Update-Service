#requires -version 3.0
param(
    [string]$BaseDir,
    [int]$DelayMilliseconds = 900
)

$ErrorActionPreference = 'Stop'
$LogFile = $null

try {
    if ([string]::IsNullOrWhiteSpace($BaseDir)) {
        $ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
        $BaseDir   = Split-Path -Parent $ScriptDir
    }

    # Clean up any stray quotes/spaces and normalize the base path
    $BaseDir = $BaseDir.Trim().Trim('"')
    $BaseDir = [System.IO.Path]::GetFullPath($BaseDir)

    $LogDir  = Join-Path $BaseDir 'logs'
    $LogFile = Join-Path $LogDir  'Send-F11Fullscreen.log'

    if (-not (Test-Path -LiteralPath $LogDir)) {
        New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
    }

    # Overwrite log on each run
    $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Set-Content -LiteralPath $LogFile -Value "[$stamp] Starting Send-F11Fullscreen.ps1"

    function Write-Log {
        param([string]$Message)
        $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
        Add-Content -LiteralPath $LogFile -Value "[$stamp] $Message"
    }

    Write-Log "BaseDir: $BaseDir"
    Write-Log "DelayMilliseconds: $DelayMilliseconds"

    Add-Type @"
using System;
using System.Runtime.InteropServices;

public static class PixNNativeMethods
{
    [DllImport("kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();

    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool SetForegroundWindow(IntPtr hWnd);

    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
}
"@

    Add-Type -AssemblyName System.Windows.Forms

    $consoleHandle = [PixNNativeMethods]::GetConsoleWindow()
    if ($consoleHandle -eq [IntPtr]::Zero) {
        throw 'Console window handle not found'
    }

    Write-Log ("Console handle: {0}" -f $consoleHandle)

    # Restore/activate the current console window, then send F11.
    [void][PixNNativeMethods]::ShowWindowAsync($consoleHandle, 9) # SW_RESTORE
    Start-Sleep -Milliseconds $DelayMilliseconds
    [void][PixNNativeMethods]::SetForegroundWindow($consoleHandle)
    Start-Sleep -Milliseconds 100
    [System.Windows.Forms.SendKeys]::SendWait('{F11}')
    Start-Sleep -Milliseconds 900

    Write-Log 'F11 sent successfully'
    exit 0
}
catch {
    try {
        if ($LogFile) {
            $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
            Add-Content -LiteralPath $LogFile -Value "[$stamp] ERROR: $($_.Exception.Message)"
        }
    }
    catch {}

    Write-Host "ERROR: $($_.Exception.Message)"
    exit 1
}
