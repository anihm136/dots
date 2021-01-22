#!/usr/env zsh
# Git aliases
function current_branch() {
	git_current_branch
}

alias g='git'

alias gaa='git add --all'
alias gap='git apply'

alias gbr='git branch'
alias gbra='git branch -a'
alias gbrd='git branch -d'
alias gbrD='git branch -D'
alias gbl='git blame -b -w'
alias gbrnm='git branch --no-merged'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gcam='git commit -a -m'
alias gcb='git checkout -b'
alias gcf='git config --list'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gsw='git switch'
alias gcount='git shortlog -sn'

alias gfetch='git fetch'
alias gfetcha='git fetch --all --prune'
alias gfetcho='git fetch origin'

function ggf() {
	[[ "$#" != 1 ]] && local b="$(git_current_branch)"
	git push --force origin "${b:=$1}"
}
function ggfl() {
	[[ "$#" != 1 ]] && local b="$(git_current_branch)"
	git push --force-with-lease origin "${b:=$1}"
}

function ggl() {
	if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
		git pull origin "${*}"
	else
		[[ "$#" == 0 ]] && local b="$(git_current_branch)"
		git pull origin "${b:=$1}"
	fi
}

function ggp() {
	if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
		git push origin "${*}"
	else
		[[ "$#" == 0 ]] && local b="$(git_current_branch)"
		git push origin "${b:=$1}"
	fi
}

function ggpnp() {
	if [[ "$#" == 0 ]]; then
		ggl && ggp
	else
		ggl "${*}" && ggp "${*}"
	fi
}

function ggu() {
	[[ "$#" != 1 ]] && local b="$(git_current_branch)"
	git pull --rebase origin "${b:=$1}"
}

alias gpull='git pull'
alias glg='git log --stat'
alias glgg='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset" --abbrev-commit --date=relative'
alias glo='git log --oneline --decorate'
alias gmerge='git merge'
alias gmergea='git merge --abort'
alias gpush='git push'
alias grem='git remote'
alias grema='git remote add'
alias greb='git rebase'
alias greba='git rebase --abort'
alias grebc='git rebase --continue'
alias grebi='git rebase -i'
alias grebs='git rebase --skip'
alias grev='git revert'
alias gst='git status'

autoload -Uz is-at-least
is-at-least 2.13 "$(git --version 2>/dev/null | awk '{print $3}')" \
	&& alias gsta='git stash push' \
	|| alias gsta='git stash save'

alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
