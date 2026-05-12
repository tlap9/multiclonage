export HISTFILE="${HOME}/.histfile"
export HISTSIZE=10000
export SAVEHIST=10000
export LSCOLORS=Gxfxcxdxbxegedabagacad

# Go config
export GOPATH="${HOME}/go"
export GOBIN="${GOPATH}/bin"

# snapd config if installed
if [[ -d /var/lib/snapd ]]; then
  export PATH="/snap/bin:${PATH}"
fi

export PATH="${HOME}/bin:${PATH}"
export PATH="${GOBIN}:${PATH}"
export PATH="${HOME}/data/scripts:${PATH}:${HOME}/scripts:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="${HOME}/snap/multipass/common/bin:${PATH}"
export PATH="${HOME}/.opencode/bin:${PATH}"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH=$PATH:/snap/bin

# pnpm
export PNPM_HOME="/home/itla2990/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
