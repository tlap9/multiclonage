#!/usr/bin/env bash

set -e

curl -fsSL https://vicinae.com/install.sh | sudo bash

systemctl --user enable vicinae --now