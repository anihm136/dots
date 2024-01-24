# Annexes
zi ice atinit'Z_A_USECOMP=1'
zi light z-shell/z-a-eval

# Theme
zi ice depth"1"
zi light romkatv/powerlevel10k

# Completions
zi ice wait lucid
zi light zsh-users/zsh-completions
zi ice wait lucid as"completion" blockf
zi snippet OMZP::pip/_pip
zi ice wait lucid
zi snippet $ZDOTDIR/completion.zsh
zi ice wait lucid atload"zicompinit_fast; zicdreplay"
zi snippet PZTM::completion

# Autosuggestions
zi ice wait lucid atload'_zsh_autosuggest_start'
zi light zsh-users/zsh-autosuggestions

# Utilities
zi ice wait lucid
zi snippet OMZP::sudo
zi ice wait lucid
zi load wfxr/forgit

# Syntax highlighting
zi light z-shell/F-Sy-H
