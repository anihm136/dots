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

fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!"
    return 1
  fi
  IFS=$'\n' out=("$(rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}" --expect='ctrl-e' --header='edit:ctrl-e')")
  local key=$(head -1 <<< "$out")
  local file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    local filewithnum=$(rg --max-count 1 --vimgrep "$1" "$file" | awk -F : '{ printf "%s:%d\n", $1,$2 }') 
    [ "$key" = ctrl-e ] && echo "${EDITOR:-nvim} ${filewithnum%%:*} +${filewithnum##*:}" && "${EDITOR:-nvim}" "${filewithnum%%:*}" "+${filewithnum##*:}" 
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

egi() {
  if [[ -n "$@" ]]; then
    nvim $@
  else
    local FZF_PREVIEW_CMD='bat --color=always --plain --line-range :$FZF_PREVIEW_LINES {}'
    local IFS=$'\n'
    local files=()
    files=(
      "$(fd --no-ignore-vcs | fzf \
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

dlm() {
  for url in $@; do
    youtube-dl -f "m4a" $url --add-metadata
  done
}

dlmn() {
  for name in $@; do
    youtube-dl -f "m4a" "ytsearch:$name audio" --add-metadata
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
  [[ -z $(pgrep tmux) ]] && direnv exec / tmux new-session -d && sleep 3
  local session=$(tmux ls -F '#S' | fzf -0 --header='Select session to attach to')
  if [[ -n $session ]]; then
    tmux attach -t $session
  fi
}

direnv() { asdf exec direnv "$@"; }

addtool() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions=$(asdf list-all $lang | fzf --tac --no-sort --multi)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do; asdf install $lang $version; done;
    fi
  fi
}

remtool() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions=$(asdf list $lang | fzf -m)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do; asdf uninstall $lang $version; done;
    fi
  fi
}
