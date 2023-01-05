#! /usr/bin/env zsh

typeset -Ag ZI

# Set install location
ZI[HOME_DIR]="$XDG_DATA_HOME/zi"
ZI[BIN_DIR]="${ZI[HOME_DIR]}/bin"
ZI[ZCOMPDUMP_PATH]="$XDG_CACHE_HOME/zsh/zcompdump"

source "${ZI[BIN_DIR]}/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# Install plugins
# Theme
zi ice depth"1"
zi light romkatv/powerlevel10k
# Completions
zi ice wait lucid as"completion"
zi light zsh-users/zsh-completions
zi ice wait lucid as"completion" blockf
zi snippet OMZP::fd/_fd
zi ice wait lucid as"completion" blockf
zi snippet OMZP::ripgrep/_ripgrep
zi ice wait lucid as"completion" blockf
zi snippet OMZP::pip/_pip
zi ice wait lucid as"completion" blockf
zi snippet ${ASDF_DIR}/completions/_asdf
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
zi snippet OMZP::web-search
zi ice wait lucid
zi load wfxr/forgit
# Directory settings
zi ice wait lucid
zi snippet PZTM::directory
# Syntax highlighting
zi light z-shell/F-Sy-H
