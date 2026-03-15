#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_FILES_DIR="$SCRIPT_DIR/default-files"
MANIFEST_PATH="$DEFAULT_FILES_DIR/cleanup-manifest.txt"

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
    [[ -f "$MANIFEST_PATH" ]] || error "Cleanup manifest not found: $MANIFEST_PATH"
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

clear_directory() {
    local dir="$1"

    if [[ -d "$dir" ]]; then
        find "$dir" -mindepth 1 -exec rm -rf {} +
        log "Cleared contents: $dir"
    else
        log "Skipped clear (not found): $dir"
    fi
}

ensure_directory() {
    local dir="$1"
    mkdir -p "$dir"
    log "Ensured directory exists: $dir"
}

copy_required_file() {
    local source_relative="$1"
    local destination="$2"
    local source="$DEFAULT_FILES_DIR/$source_relative"

    [[ -f "$source" ]] || error "Missing default file: $source"

    mkdir -p "$(dirname "$destination")"
    cp "$source" "$destination"

    log "Restored: $destination"
}

REMOVE_ITEMS=()
CLEAR_ITEMS=()
MKDIR_ITEMS=()
RESTORE_ITEMS=()

read_manifest() {
    local current_section=""

    while IFS= read -r raw_line || [[ -n "$raw_line" ]]; do
        local line
        line="$(echo "$raw_line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"

        [[ -z "$line" || "$line" =~ ^# ]] && continue

        if [[ "$line" =~ ^\[(.+)\]$ ]]; then
            current_section="${BASH_REMATCH[1],,}"
            continue
        fi

        case "$current_section" in
            remove)
                REMOVE_ITEMS+=("$line")
                ;;
            clear)
                CLEAR_ITEMS+=("$line")
                ;;
            mkdir)
                MKDIR_ITEMS+=("$line")
                ;;
            restore)
                [[ "$line" == *"=>"* ]] || error "Invalid restore entry in manifest: $line"
                RESTORE_ITEMS+=("$line")
                ;;
            *)
                error "Unknown or missing section in manifest near line: $line"
                ;;
        esac
    done < "$MANIFEST_PATH"
}

check_project_root
read_manifest

log "This script will remove example files and restore minimal defaults."
echo "Items that will be removed:"
for item in "${REMOVE_ITEMS[@]}"; do
    echo "  - $item"
done
for item in "${CLEAR_ITEMS[@]}"; do
    echo "  - $item/*"
done

if [[ ${#RESTORE_ITEMS[@]} -gt 0 ]]; then
    echo ""
    echo "Files that will be restored:"
    for entry in "${RESTORE_ITEMS[@]}"; do
        destination_part="${entry#*=>}"
        destination_part="$(echo "$destination_part" | sed 's/^[[:space:]]*//')"
        echo "  - $destination_part"
    done
fi

echo ""

if ! confirm "Do you want to continue?"; then
    log "Operation cancelled."
    exit 0
fi

for item in "${REMOVE_ITEMS[@]}"; do
    remove_if_exists "$item"
done

for item in "${MKDIR_ITEMS[@]}"; do
    ensure_directory "$item"
done

for item in "${CLEAR_ITEMS[@]}"; do
    ensure_directory "$item"
    clear_directory "$item"
done

for entry in "${RESTORE_ITEMS[@]}"; do
    source_part="${entry%%=>*}"
    destination_part="${entry#*=>}"

    source_part="$(echo "$source_part" | sed 's/[[:space:]]*$//')"
    destination_part="$(echo "$destination_part" | sed 's/^[[:space:]]*//')"

    copy_required_file "$source_part" "$destination_part"
done

log "Cleanup complete."