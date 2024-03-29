# zmodload zsh/zprof
{%@@ if profile != "work" @@%}
module_path+=( "{{@@ home @@}}/.local/share/zi/zmodules/zpmod/Src" )
zmodload zi/zpmod
{%@@ endif @@%}

# Plugin framework
source $ZDOTDIR/zi.sh

# Source files from config dirs and files
for f in $ZDOTDIR/zshrc.d/**/*.zsh(N); do [ -r "$f" ] && source "$f"; done

# Load p10k theme
[[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source "$ZDOTDIR/.p10k.zsh"

{%@@ if profile != "work" @@%}
# Load command-not-found handler
[[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh
{%@@ endif @@%}
# zprof
