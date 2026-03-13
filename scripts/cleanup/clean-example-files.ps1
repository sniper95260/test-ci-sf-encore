$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$DefaultFilesDir = Join-Path $ScriptDir "default-files"

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
        Throw-ProjectError "This script must be run from the project root (missing assets directory)."
    }

    if (-not (Test-Path "templates")) {
        Throw-ProjectError "This script must be run from the project root (missing templates directory)."
    }

    if (-not (Test-Path $DefaultFilesDir)) {
        Throw-ProjectError "Default files directory not found: $DefaultFilesDir"
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

function Copy-RequiredFile {
    param(
        [string]$Source,
        [string]$Destination
    )

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

Test-ProjectRoot

Write-Log "This script will remove example frontend/template files and restore minimal defaults."
Write-Log "Items that will be removed:"
Write-Host "  - assets/app.ts"
Write-Host "  - assets/images/*"
Write-Host "  - assets/scripts/*"
Write-Host "  - assets/styles/*"
Write-Host "  - templates/*"
Write-Host ""

if (-not (Confirm-Action "Do you want to continue?")) {
    Write-Log "Operation cancelled."
    exit 0
}

Remove-IfExists "assets/app.ts"
Remove-IfExists "assets/images"
Remove-IfExists "assets/scripts"
Remove-IfExists "assets/styles"
Remove-IfExists "templates"

New-Item -ItemType Directory -Path "assets/styles" -Force | Out-Null
New-Item -ItemType Directory -Path "templates" -Force | Out-Null

Copy-RequiredFile (Join-Path $DefaultFilesDir "assets/app.ts") "assets/app.ts"
Copy-RequiredFile (Join-Path $DefaultFilesDir "assets/styles/app.scss") "assets/styles/app.scss"
Copy-RequiredFile (Join-Path $DefaultFilesDir "templates/base.html.twig") "templates/base.html.twig"

Write-Log "Cleanup complete."