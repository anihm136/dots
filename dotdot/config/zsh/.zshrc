# zmodload zsh/zprof
module_path+=( "/home/anihm136/.local/share/zi/zmodules/zpmod/Src" )
zmodload zi/zpmod

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Plugin framework
source $ZDOTDIR/zi.sh

# Source files from config dirs and files
for f in $ZDOTDIR/zshrc.d/**/*.zsh(N); do [ -r "$f" ] && source "$f"; done

# Load p10k theme
[[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source "$ZDOTDIR/.p10k.zsh"

# Load aliases
# Aliases are placed in $HOME so that bash can also use them
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# Load command-not-found handler
{%@@ if profile != "anihm2" @@%}
[[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh
{%@@ endif @@%}
# zprof
