#!/usr/bin/env bash

set -e

# Install kubectl
sudo snap install kubectl --classic

# Install helm
sudo snap install helm --classic

# Install k9s
sudo snap install k9s --classic
sudo ln -s /snap/k9s/current/bin/k9s /snap/bin/k9s # Ensure k9s is available in PATH