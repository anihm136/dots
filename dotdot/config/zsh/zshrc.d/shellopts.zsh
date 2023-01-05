# Shell quoting on paste
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Set shell options
setopt interactivecomments # Enable comments in interactive shell.
