export FZF_DEFAULT_OPTS="--height 40% --reverse"
export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -500' --preview-window right:60% --select-1"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .venv --exclude .ccls-cache --exclude .steam/"
export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude .git --exclude node_modules --exclude .venv --exclude .ccls-cache --exclude .steam/"

# Colorscheme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
 --color=fg:#e0def4,bg:#191725,hl:#6e6a86
 --color=fg+:#908caa,bg+:#1f1d2e,hl+:#908caa
 --color=info:#9ccfd8,prompt:#f6c177,pointer:#c4a7e7
 --color=marker:#ebbcba,spinner:#eb6f92,header:#ebbcba"
