#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_FILES_DIR="$SCRIPT_DIR/default-files"

log() {
    echo "[clean-example-files] $1"
}

error() {
    echo "[clean-example-files][ERROR] $1" >&2
    exit 1
}

confirm() {
    read -r -p "$1 [y/N]: " response
    [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
}

check_project_root() {
    [[ -f "composer.json" ]] || error "Run this script from the project root (missing composer.json)"
    [[ -d "$DEFAULT_FILES_DIR" ]] || error "Default files directory not found: $DEFAULT_FILES_DIR"
}

remove_if_exists() {
    local path="$1"

    if [[ -e "$path" ]]; then
        rm -rf "$path"
        log "Removed: $path"
    else
        log "Skipped (not found): $path"
    fi
}

copy_required_file() {
    local source="$1"
    local destination="$2"

    [[ -f "$source" ]] || error "Missing default file: $source"

    mkdir -p "$(dirname "$destination")"
    cp "$source" "$destination"

    log "Restored: $destination"
}

check_project_root

log "This script will remove example files and restore minimal defaults."
echo "Items that will be removed:"
echo "  - assets/app.ts"
echo "  - assets/scripts/"
echo "  - assets/styles/"
echo "  - templates/"
echo "  - src/Controller/example/"
echo ""

if ! confirm "Do you want to continue?"; then
    log "Operation cancelled."
    exit 0
fi

remove_if_exists "assets/app.ts"
remove_if_exists "assets/scripts"
remove_if_exists "assets/styles"
remove_if_exists "templates"
remove_if_exists "src/Controller/example"

mkdir -p assets/styles
mkdir -p templates
mkdir -p assets/images

copy_required_file "$DEFAULT_FILES_DIR/assets/app.ts" "assets/app.ts"
copy_required_file "$DEFAULT_FILES_DIR/assets/styles/app.scss" "assets/styles/app.scss"
copy_required_file "$DEFAULT_FILES_DIR/templates/base.html.twig" "templates/base.html.twig"

log "Cleanup complete."