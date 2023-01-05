# Include dotfiles in glob matching
setopt globdots
setopt extendedglob
# Exclude . and .. in glob matching
zstyle ':completion:*' special-dirs false
