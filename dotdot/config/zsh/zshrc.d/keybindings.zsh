# Use emacs key bindings
bindkey -e

# [PageUp] - Up a line of history
bindkey -M emacs "${terminfo[kpp]}" up-history
# [PageDown] - Down a line of history
bindkey -M emacs "${terminfo[knp]}" down-history

# Start typing + [Up-Arrow] - find history forward
bindkey '^[[A' up-line-or-search
# Start typing + [Down-Arrow] - find history backward
bindkey '^[[B' down-line-or-search

# [Home] - Go to beginning of line
bindkey -M emacs "${terminfo[khome]}" beginning-of-line
# [End] - Go to end of line
bindkey -M emacs "${terminfo[kend]}"  end-of-line
# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word

# [Shift-Tab] - move through the completion menu backwards
bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char
# [Delete] - delete forward
bindkey -M emacs "${terminfo[kdch1]}" delete-char
# [Ctrl-Delete] - delete whole forward-word
bindkey -M emacs '^[[3;5~' kill-word

# [Space] - don't do history expansion
bindkey ' ' magic-space

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# file rename magic
bindkey "^[m" copy-prev-shell-word

# bindkey -s '^X^Z' '%-^M'
#bindkey '^X^N' accept-and-infer-next-history

zi ice wait lucid
zi snippet "https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh"
