#!/usr/bin/env bash
set -euo pipefail

# Output green message prefixed with [+]
_info() { echo -e "\e[92m[+] ${1:-}\e[0m"; }

GITHUB="https://github.com"
FONT_DIR="${HOME}/.local/share/fonts"
VERSION="v0.100"
FONT_FILE="PaperMono-Regular.otf"
LEGACY_TTF="PaperMono-Regular.ttf"
SNAP_APPS=("code" "code-insiders" "codium")

install_font_in_dir() {
  local target_dir="$1"

  _info "Creating fonts directory at $target_dir"
  mkdir -p "$target_dir"

  _info "Installing Paper Mono font in $target_dir"
  wget -qO "$target_dir/$FONT_FILE" "${GITHUB}/paper-design/paper-mono/releases/download/${VERSION}/${FONT_FILE}"

  if [ -f "$target_dir/$LEGACY_TTF" ]; then
    _info "Removing legacy $LEGACY_TTF from $target_dir"
    rm -f "$target_dir/$LEGACY_TTF"
  fi

  _info "Refreshing font cache for $target_dir"
  fc-cache -f "$target_dir"
}

install_font_in_dir "$FONT_DIR"

# Install for snap-packaged editors (VS Code / VS Code Insiders / VSCodium)
for app in "${SNAP_APPS[@]}"; do
  snap_fonts_dir="${HOME}/snap/${app}/current/.local/share/fonts"
  if [ -d "${HOME}/snap/${app}" ]; then
    install_font_in_dir "$snap_fonts_dir"
  fi
done
