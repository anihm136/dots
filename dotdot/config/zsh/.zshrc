export EDITOR="nvim"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTSIZE=1000
SAVEHIST=1000
HISTFILE="$XDG_CACHE_HOME/zsh/history"
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"
DISABLE_MAGIC_FUNCTIONS="true"

for f in $ZDOTDIR/zshrc.d/**/*.zsh(N); do [ -r "$f" ] && source "$f"; done
[[ -f ${ASDF_DIR}/asdf.sh ]] && source ${ASDF_DIR}/asdf.sh
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# Linux antibody file
fpath+=("$XDG_DATA_HOME/zsh/completion")
export FPATH
ZSH="$ANTIBODY_HOME"/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh
source "$ZDOTDIR/zsh_plugins.sh"

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

setopt globdots
zstyle ':completion:*' special-dirs false
setopt extendedglob
unalias z 2> /dev/null

eval "$(asdf exec direnv hook zsh)"
eval "$(pipenv --completion)"
eval "$(register-python-argcomplete pipx)"
if (command -v perl && command -v cpanm) >/dev/null 2>&1; then
  test -d "$HOME/perl5/lib/perl5" && eval $(perl -I "$HOME/perl5/lib/perl5" -Mlocal::lib)
fi

catch_signal_usr1() {
  trap catch_signal_usr1 USR1
  nvim -c "SLoad reload"
}
trap catch_signal_usr1 USR1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh
