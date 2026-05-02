#!/usr/bin/env bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

sudo snap install ghostty --classic

mkdir -p "${HOME}/.config/ghostty"

cp -f "${DIR}/configs/ghostty/config.ghostty" "${HOME}/.config/ghostty/config.ghostty"