#!/usr/bin/env bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

sudo snap install --classic zellij

mkdir -p "${HOME}/.config/zellij"

ln -sf "${DIR}/configs/zellij/config.kdl" "${HOME}/.config/zellij/config.kdl"
