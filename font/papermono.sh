#!/usr/bin/env bash
set -e

# Output green message prefixed with [+]
_info() { echo -e "\e[92m[+] ${1:-}\e[0m"; }

GITHUB="https://github.com"
FONT_DIR="${HOME}/.local/share/fonts"

# Fonts directory
_info "Creating fonts directory at $FONT_DIR"
mkdir -p "$FONT_DIR"

# Install Paper Mono font
_info "Installing Paper Mono font"
wget -qO- "${GITHUB}/paper-design/paper-mono/releases/tag/v0.100/PaperMono-Regular.ttf" | tee "$FONT_DIR/PaperMono-Regular.ttf" > /dev/null
