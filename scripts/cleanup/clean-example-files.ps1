$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$DefaultFilesDir = Join-Path $ScriptDir "default-files"
$ManifestPath = Join-Path $DefaultFilesDir "cleanup-manifest.txt"

function Write-Log {
    param([string]$Message)
    Write-Host "[clean-example-files] $Message"
}

function Throw-ProjectError {
    param([string]$Message)
    throw "[clean-example-files][ERROR] $Message"
}

function Confirm-Action {
    param([string]$Prompt)

    $response = Read-Host "$Prompt [y/N]"
    return $response -match '^(y|yes)$'
}

function Test-ProjectRoot {
    if (-not (Test-Path "composer.json")) {
        Throw-ProjectError "This script must be run from the project root (missing composer.json)."
    }

    if (-not (Test-Path "assets")) {
        Throw-ProjectError "Missing assets directory."
    }

    if (-not (Test-Path $DefaultFilesDir)) {
        Throw-ProjectError "Default files directory not found: $DefaultFilesDir"
    }

    if (-not (Test-Path $ManifestPath)) {
        Throw-ProjectError "Cleanup manifest not found: $ManifestPath"
    }
}

function Remove-IfExists {
    param([string]$PathToRemove)

    if (Test-Path $PathToRemove) {
        Remove-Item $PathToRemove -Recurse -Force
        Write-Log "Removed: $PathToRemove"
    }
    else {
        Write-Log "Skipped (not found): $PathToRemove"
    }
}

function Clear-Directory {
    param([string]$Path)

    if (Test-Path $Path) {
        Get-ChildItem -Path $Path -Force | Remove-Item -Recurse -Force
        Write-Log "Cleared contents: $Path"
    }
    else {
        Write-Log "Skipped clear (not found): $Path"
    }
}

function Ensure-Directory {
    param([string]$Path)

    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Log "Created directory: $Path"
    }
    else {
        Write-Log "Directory already exists: $Path"
    }
}

function Copy-RequiredFile {
    param(
        [string]$SourceRelative,
        [string]$Destination
    )

    $Source = Join-Path $DefaultFilesDir $SourceRelative

    if (-not (Test-Path $Source)) {
        Throw-ProjectError "Missing default file: $Source"
    }

    $destinationDirectory = Split-Path -Parent $Destination
    if ($destinationDirectory -and -not (Test-Path $destinationDirectory)) {
        New-Item -ItemType Directory -Path $destinationDirectory -Force | Out-Null
    }

    Copy-Item $Source $Destination -Force
    Write-Log "Restored: $Destination"
}

function Read-CleanupManifest {
    param([string]$Path)

    $result = @{
        remove  = New-Object System.Collections.Generic.List[string]
        clear   = New-Object System.Collections.Generic.List[string]
        mkdir   = New-Object System.Collections.Generic.List[string]
        restore = New-Object System.Collections.Generic.List[object]
    }

    $currentSection = ""

    foreach ($rawLine in Get-Content $Path) {
        $line = $rawLine.Trim()

        if (-not $line -or $line.StartsWith("#")) {
            continue
        }

        if ($line -match '^\[(.+)\]$') {
            $currentSection = $matches[1].ToLower()
            continue
        }

        switch ($currentSection) {
            "remove" {
                $result.remove.Add($line)
            }
            "clear" {
                $result.clear.Add($line)
            }
            "mkdir" {
                $result.mkdir.Add($line)
            }
            "restore" {
                if ($line -notmatch '^(.*?)\s*=>\s*(.*?)$') {
                    Throw-ProjectError "Invalid restore entry in manifest: $line"
                }

                $result.restore.Add([PSCustomObject]@{
                    Source      = $matches[1].Trim()
                    Destination = $matches[2].Trim()
                })
            }
            default {
                Throw-ProjectError "Unknown or missing section in manifest near line: $line"
            }
        }
    }

    return $result
}

Test-ProjectRoot
$manifest = Read-CleanupManifest $ManifestPath

Write-Log "This script will remove example files and restore minimal defaults."

Write-Host "Items that will be removed:"
foreach ($item in $manifest.remove) {
    Write-Host "  - $item"
}
foreach ($item in $manifest.clear) {
    Write-Host "  - $item/*"
}

if ($manifest.restore.Count -gt 0) {
    Write-Host ""
    Write-Host "Files that will be restored:"
    foreach ($entry in $manifest.restore) {
        Write-Host "  - $($entry.Destination)"
    }
}

Write-Host ""

if (-not (Confirm-Action "Do you want to continue?")) {
    Write-Log "Operation cancelled."
    exit 0
}

foreach ($item in $manifest.remove) {
    Remove-IfExists $item
}

foreach ($item in $manifest.mkdir) {
    Ensure-Directory $item
}

foreach ($item in $manifest.clear) {
    Ensure-Directory $item
    Clear-Directory $item
}

foreach ($entry in $manifest.restore) {
    Copy-RequiredFile $entry.Source $entry.Destination
}

Write-Log "Cleanup complete."