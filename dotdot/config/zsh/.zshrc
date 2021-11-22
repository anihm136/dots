# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set command history size
HISTSIZE=1000
SAVEHIST=1000
# Set history file location
HISTFILE="$XDG_CACHE_HOME/zsh/history"
# Set completion cache location
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"
# Disable 'magic functions' i.e, bracketed paste. This is for OMZ
DISABLE_MAGIC_FUNCTIONS="true"
# Disable omz auto-update
DISABLE_AUTO_UPDATE=true

# Load zsh run-help module
autoload -Uz run-help
autoload -Uz run-help-git run-help-ip run-help-openssl run-help-p4 run-help-sudo run-help-svk run-help-svn
(( ${+aliases[run-help]} )) && unalias run-help

# Source files from config dirs and files
for f in $ZDOTDIR/zshrc.d/**/*.zsh(N); do [ -r "$f" ] && source "$f"; done

# Load ASDF
[[ -f ${ASDF_DIR}/asdf.sh ]] && source ${ASDF_DIR}/asdf.sh

# Load aliases
# Aliases are placed in $HOME so that bash can also use them
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# Add fpath for custom completions
fpath+=("${XDG_DATA_HOME}/zsh/completion")
export FPATH

# Load antibody plugins
ZSH="${ANTIBODY_HOME}/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
source "$ZDOTDIR/zsh_plugins.sh"

# Completion definitions for git aliases
compdef _git ggu=git-checkout
compdef _git ggpnp=git-checkout
compdef _git ggp=git-checkout
compdef _git ggl=git-checkout
compdef _git ggfl=git-checkout
compdef _git ggf=git-checkout

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('{{@@ home @@}}/.local/share/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "{{@@ home @@}}/.local/share/miniconda3/etc/profile.d/conda.sh" ]; then
        . "{{@@ home @@}}/.local/share/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="{{@@ home @@}}/.local/share/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Include dotfiles in glob matching
setopt globdots
# Exclude . and .. in glob matching
zstyle ':completion:*' special-dirs false
# Enable extended glob support (negation etc.)
setopt extendedglob

# Load completions and hooks for various tools
eval "$(asdf exec direnv hook zsh)"
eval "$(pipenv --completion)"
eval "$(register-python-argcomplete pipx)"
eval "$(zoxide init --cmd j --hook pwd zsh)"
if (command -v perl && command -v cpanm) >/dev/null 2>&1; then
  [[ -d "$HOME/perl5/lib/perl5" ]] && eval $(perl -I "$HOME/perl5/lib/perl5" -Mlocal::lib)
fi

# Signal handler for reloading neovim
catch_signal_usr1() {
  trap catch_signal_usr1 USR1
  nvim -c ":LoadSession!"
}
trap catch_signal_usr1 USR1

# Signal handler for recognizing commands as soon as they are installed
TRAPUSR2() {
  rehash
}

# Load p10k theme
[[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source "$ZDOTDIR/.p10k.zsh"

# Load fzf helpers
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# Load command-not-found handler
source /usr/share/doc/pkgfile/command-not-found.zsh

# Set $JAVA_HOME using ASDF
source "$ASDF_DATA_DIR/plugins/java/set-java-home.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/anihm136/build/gcloud/google-cloud-sdk/path.zsh.inc' ]; then . '/home/anihm136/build/gcloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/anihm136/build/gcloud/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/anihm136/build/gcloud/google-cloud-sdk/completion.zsh.inc'; fi
