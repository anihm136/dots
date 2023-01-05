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

# Defaults
export EDITOR="nvim"
export PAGER="less"
export LESS="-R"

{%@@ if profile == "work" @@%}
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
{%@@ else @@%}
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
{%@@ endif @@%}
