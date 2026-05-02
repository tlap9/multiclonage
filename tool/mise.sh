#!/usr/bin/env bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

sudo snap install mise --classic

mkdir -p "${HOME}/.config/mise"

ln -sf "${DIR}/configs/mise/mise.toml" "${HOME}/.config/mise/mise.toml"

mise install