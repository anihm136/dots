#! /usr/bin/env zsh

typeset -Ag ZI

# Set install location
ZI[HOME_DIR]="$XDG_DATA_HOME/zi"
ZI[BIN_DIR]="${ZI[HOME_DIR]}/bin"
ZI[ZCOMPDUMP_PATH]="$XDG_CACHE_HOME/zsh/zcompdump"

source "${ZI[BIN_DIR]}/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

source "${ZDOTDIR}/plugins.zsh"
