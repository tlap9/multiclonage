#!/usr/bin/env bash

set -e
# Output green message prefixed with [+]
_info() { echo -e "\e[92m[+] ${1:-}\e[0m"; }

GITHUB="https://github.com"
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Step 1 : Packages installation
export DEBIAN_FRONTEND="noninteractive"

_info "Installing packages from the archives"
sudo apt-get install -y \
		unzip \
		git \
		htop \
		curl \
		wget \
		jq \
		zsh \
		vim \
        bat \
        fzf \
		direnv

# Starship is only available through apt for Ubuntu 25.04+, while Zenbook FT is on 24.04 we install it through the official install script which is compatible with both versions
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Zoxide advice is to use the install script instead of snap
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Step 2 : Shell configuration

# Set default shells
if command -v zsh >/dev/null; then
	shell_path="$(command -v zsh)"
	target_user="${SUDO_USER:-$USER}"

	# For SSSD/LDAP users, chsh fails because there is no local /etc/passwd entry.
	# We detect that case and set a per-user override via SSSD instead.
	if getent passwd "$target_user" >/dev/null && ! grep -q "^${target_user}:" /etc/passwd; then
		_info "Setting SSSD shell override for '$target_user'"
		sudo sss_override user-add -s "$shell_path" "$target_user"
		sudo systemctl restart sssd
	fi

	if grep -q "^${target_user}:" /etc/passwd; then
		_info "Changing default shell to zsh for '$target_user'"
		sudo chsh -s "$shell_path" "$target_user"
	else
		_info "Skipping chsh for '$target_user' (no local /etc/passwd entry)"
	fi
fi

mkdir -p "${HOME}/.config"

# zsh config
_info "Linking zsh configs"
ln -sf "${DIR}/configs/zsh/.zshrc" "${HOME}/.zshrc"
ln -sf "${DIR}/configs/zsh/.zshenv" "${HOME}/.zshenv"
ln -sfn "${DIR}/configs/zsh/.zsh_config" "${HOME}/.zsh_config"
mkdir -p "${HOME}/.zsh_config"

if [[ ! -d ${HOME}/.oh-my-zsh ]]; then
	_info "Cloning oh-my-zsh"
	git clone --depth 1 "${GITHUB}/ohmyzsh/ohmyzsh" "${HOME}/.oh-my-zsh"
fi

if [[ ! -d ${HOME}/.zsh_config/zsh-autosuggestions ]]; then
	_info "Cloning zsh-autosuggestions from Github"
	git clone "${GITHUB}/zsh-users/zsh-autosuggestions" "$HOME/.zsh_config/zsh-autosuggestions"
fi

if [[ ! -d ${HOME}/.zsh_config/zsh-syntax-highlighting ]]; then
	_info "Cloning zsh-syntax-highlighting from Github"
	git clone "${GITHUB}/zsh-users/zsh-syntax-highlighting" "$HOME/.zsh_config/zsh-syntax-highlighting"
fi

### Work plugin conf - this is pretty specific, so delete it if you don't need it
LIFT_SOURCE_PATH="$HOME/.local/share/pipx/venvs/liftcli"
if [[ -d "$LIFT_SOURCE_PATH" ]]; then
	_info "Linking liftcli to zsh plugins"
	lift_plugin_source="$LIFT_SOURCE_PATH/shell/oh-my-zsh/lift.plugin.zsh"
	lift_plugin_target="${HOME}/.oh-my-zsh/custom/plugins/lift/lift.plugin.zsh"
	mkdir -p "${HOME}/.oh-my-zsh/custom/plugins/lift"
	rm -f "${HOME}/.oh-my-zsh/plugins/lift"
	if [[ -e "$lift_plugin_target" ]] && [[ "$(readlink -f "$lift_plugin_source")" == "$(readlink -f "$lift_plugin_target")" ]]; then
		_info "liftcli plugin already linked, skipping"
	else
		ln -sfn "$lift_plugin_source" "$lift_plugin_target"
	fi
else
	_info "liftcli not found at $LIFT_SOURCE_PATH, skipping plugin link"
fi
###

# starship config
_info "Linking starship configs"
ln -sf "${DIR}/configs/starship/starship.toml" "${HOME}/.config/starship.toml"

# git config
_info "Linking git configs"
ln -sf "${DIR}/configs/git/.gitconfig" "${HOME}/.gitconfig"
ln -sf "${DIR}/configs/git/.gitignore" "${HOME}/.gitignore"

# misc config
mkdir -p "${HOME}/.ssh"