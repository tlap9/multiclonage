# Ensure PATH and env are available in all zsh sessions
if [[ -f "${HOME}/.zsh_config/env.zsh" ]]; then
  source "${HOME}/.zsh_config/env.zsh"
fi
