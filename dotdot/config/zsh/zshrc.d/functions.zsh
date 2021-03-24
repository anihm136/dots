cf() {
  local file


  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
    if [[ -d $file ]]
    then
      cd -- $file
    else
      cd -- ${file:h}
    fi
  fi
}

#
# # ext - archive extractor
# # usage: ext <file>
ext ()
{
  if [[ -f $1 ]] || [[ -z $1(#qN) ]] ; then
    local ext_path=$(dirname $1)
    case $1 in
      *.tar.bz2)   tar xjf $1 -C $ext_path    ;;
      *.tar.gz)    tar xzf $1 -C $ext_path    ;;
      *.tar.xz)    tar xf $1 -C $ext_path   ;;
      *.bz2)       bunzip2 $1            ;;
      *.rar)       unrar x $1 $ext_path      ;;
      *.gz)        gunzip $1             ;;
      *.tar)       tar xf $1 -C $ext_path    ;;
      *.tbz2)      tar xjf $1 -C $ext_path    ;;
      *.tgz)       tar xzf $1 -C $ext_path    ;;
      *.zip)       unzip $1 -d $ext_path     ;;
      *.Z)         uncompress $1         ;;
      *.7z)        7z x $1 -o $ext_path      ;;
      *)           echo "'$1' cannot be extracted via ext()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!"
    return 1
  fi
  IFS=$'\n' out=("$(rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}" --expect='ctrl-e' --header='edit:ctrl-e')")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-e ] && ${EDITOR:-nvim} "$file"
  fi
}

e() {
  if [[ -n "$@" ]]; then
    nvim $@
  else
    local FZF_PREVIEW_CMD='bat --color=always --plain --line-range :$FZF_PREVIEW_LINES {}'
    local IFS=$'\n'
    local files=()
    files=(
      "$(fzf \
            --query="$1" \
            --multi \
            --preview="${FZF_PREVIEW_CMD}" \
            --preview-window='right:hidden:wrap' \
            --bind=ctrl-v:toggle-preview \
            --bind=ctrl-x:toggle-sort \
            --header='(view:ctrl-v) (sort:ctrl-x)'
      )"
    ) || return
    local args=("${(f)files}")
    ${EDITOR:-nvim} ${args[@]}
  fi
}

z() {
  cd "$(_z -l "$*" 2>&1 | fzf --select-1 +s --tac --query "${*##-* }" | sed 's/^\S* *//')"
}

mcp() {
  local fro=()
  local to=()
  local flags=()
  local dest=false
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -d)
        dest=true
        ;;
      -*)
        flags+=("$1")
        ;;
      *)
        if [[ $dest == true ]]; then
          to+=("${(q)1}")
        else
          fro+=($1)
        fi
        ;;
    esac
    shift
  done
  echo $to | xargs -n 1 cp $flags $fro
}

mmv() {
  local fro=()
  local to=()
  local flags=()
  local dest=false
  local args=$@
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -d)
        dest=true
        ;;
      -*)
        flags+=("$1")
        ;;
      *)
        if [[ $dest == true ]]; then
          to+=("${(q)1}")
        else
          fro+=($1)
        fi
        ;;
    esac
    shift
  done
  mcp $args && rm $fro
}

dlm() {
  for url in $@; do
    youtube-dl -f "m4a" $url --add-metadata
  done
}

codi() {
  local syntax="${1:-python}"
  shift
  nvim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

tm() {
  local session=$(tmux ls -F '#S' | fzf -0 --header='Select session to attach to')
  if [[ -n $session ]]; then
    tmux attach -t $session
  fi
}

direnv() { asdf exec direnv "$@"; }
