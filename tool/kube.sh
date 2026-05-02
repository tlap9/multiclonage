#!/usr/bin/env bash

set -e

# Install kubectl
sudo snap install kubectl --classic

# Install helm
sudo snap install helm --classic

# Install k9s
sudo snap install k9s --classic 