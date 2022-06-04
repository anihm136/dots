# Create venv inside project dir
export PIPENV_VENV_IN_PROJECT=1

# Use bat to highlight manpages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# FZF settings
export FZF_DEFAULT_OPTS="--height 40% --reverse"
export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -500' --preview-window right:60% --select-1"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .venv --exclude .ccls-cache --exclude .steam/"
export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude .git --exclude node_modules --exclude .venv --exclude .ccls-cache --exclude .steam/"

# Don't print logs when changing into directory
export DIRENV_LOG_FORMAT=

# Default editor
export EDITOR="nvim"
