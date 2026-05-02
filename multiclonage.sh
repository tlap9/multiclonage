#!/usr/bin/env bash
set -ex
ROOT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

sudo apt-get update
sudo apt-get upgrade -y

categories="system tool app"
for category in $categories; do
    for x in "$ROOT_DIR/$category"/*.sh; do
        [ -e "$x" ] || continue
        bash "$x"
    done
done
