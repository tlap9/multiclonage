#!/usr/bin/env bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Install OpenCode
curl -fsSL https://opencode.ai/install | bash

# Install Plannotator plugin for OpenCode
curl -fsSL https://plannotator.ai/install.sh | bash

ln -sf "${DIR}/configs/opencode/opencode.json" "${HOME}/.config/opencode/opencode.json"
ln -sf "${DIR}/configs/opencode/tui.json" "${HOME}/.config/opencode/tui.json"