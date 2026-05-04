export STARSHIP_CONFIG="$HOME/.config/starship.toml"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

# Custom zsh env
[[ -f "${HOME}/.zsh_config/env.zsh" ]] && source ~/.zsh_config/env.zsh
# Custom zsh plugins
[[ -f "${HOME}/.zsh_config/plugins.zsh" ]] && source ~/.zsh_config/plugins.zsh
[[ -d "${ZSH}" ]] && source "${ZSH}/oh-my-zsh.sh"
# Custom zsh config
[[ -f "${HOME}/.zsh_config/config.zsh" ]] && source ~/.zsh_config/config.zsh
# Custom zsh functions
[[ -f "${HOME}/.zsh_config/functions.zsh" ]] && source ~/.zsh_config/functions.zsh
# Custom zsh aliases
[[ -f "${HOME}/.zsh_config/aliases.zsh" ]] && source ~/.zsh_config/aliases.zsh

eval "$(starship init zsh)"
eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

source $HOME/.zsh_config/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh_config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh