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
    local prompt="$1"
    read -r -p "$prompt [y/N]: " response
    case "$response" in
        [yY]|[yY][eE][sS]) return 0 ;;
        *) return 1 ;;
    esac
}

check_project_root() {
    [[ -f "composer.json" ]] || error "This script must be run from the project root (missing composer.json)."
    [[ -d "assets" ]] || error "This script must be run from the project root (missing assets directory)."
    [[ -d "templates" ]] || error "This script must be run from the project root (missing templates directory)."
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

main() {
    check_project_root

    log "This script will remove example frontend/template files and restore minimal defaults."
    log "Items that will be removed:"
    echo "  - assets/app.ts"
    echo "  - assets/images/*"
    echo "  - assets/scripts/*"
    echo "  - assets/styles/*"
    echo "  - templates/*"
    echo

    if ! confirm "Do you want to continue?"; then
        log "Operation cancelled."
        exit 0
    fi

    remove_if_exists "assets/app.ts"
    remove_if_exists "assets/images"
    remove_if_exists "assets/scripts"
    remove_if_exists "assets/styles"
    remove_if_exists "templates"

    mkdir -p "assets/styles"
    mkdir -p "templates"

    copy_required_file "$DEFAULT_FILES_DIR/assets/app.ts" "assets/app.ts"
    copy_required_file "$DEFAULT_FILES_DIR/assets/styles/app.scss" "assets/styles/app.scss"
    copy_required_file "$DEFAULT_FILES_DIR/templates/base.html.twig" "templates/base.html.twig"

    log "Cleanup complete."
}

main "$@"