# Load aliases
# Aliases are placed in $HOME so that bash can also use them
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

alias dotdrop='(){(cd ~/.dots || exit; pipenv run ./dotdrop.sh $@) ;}'

alias -g '...'='../..'
alias -g '....'='../../..'
alias -g '.....'='../../../..'
alias -g '......'='../../../../..'

# Git aliases
function gsetup() {
	local main
	if git branch | grep -w 'main' > /dev/null 2>&1; then
		main="main"
	else
		main="master"
	fi
	git switch "$main"
	git config remote.pushDefault "${1:-"origin"}"
	git branch --set-upstream-to="${2:-"upstream"}/$main"
}

function gwork() {
	if [[ $# -ne 1 ]]; then
		echo "Usage: gwork <new-branch>"
		return 1
	fi
	local branch="$1"
	local upstream="origin/$(git_current_branch)"
	git switch -c "$branch"
	git push origin "$(git_current_branch)"
	git branch --set-upstream-to="$upstream"
}

alias g='git'

alias gaa='git add --all'

alias gbr='git branch'
alias gbrd='git branch -d'
alias gbrD='git branch -D'
alias gbru='git branch --set-upstream-to origin/$(git_current_branch)'
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
alias gcmsg='git commit -m'
alias gsw='git switch'
alias gcount='git shortlog -sn'

alias gfetch='git fetch'
alias gfetcha='git fetch --all --prune'

function ggf() {
	[[ "$#" != 1 ]] && local b="$(git_current_branch)"
	git push --force origin "${b:=$1}"
}
function ggfl() {
	[[ "$#" != 1 ]] && local b="$(git_current_branch)"
	git push --force-with-lease origin "${b:=$1}"
}

# function ggl() {
# 	if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
# 		git pull origin "${*}"
# 	else
# 		[[ "$#" == 0 ]] && local b="$(git_current_branch)"
# 		git pull origin "${b:=$1}"
# 	fi
# }

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

# function ggu() {
# 	[[ "$#" != 1 ]] && local b="$(git_current_branch)"
# 	git pull --rebase origin "${b:=$1}"
# }

alias gpull='git pull'
alias glg='git log --stat'
alias glgg='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset" --abbrev-commit --date=relative'
alias glo='git log --oneline --decorate'
alias gmerge='git merge'
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
