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
            --bind='ctrl-v:toggle-preview' \
            --bind='ctrl-g:reload(fd --no-ignore-vcs)' \
            --bind="ctrl-r:reload(${FZF_DEFAULT_COMMAND})" \
            --header='(view:ctrl-v) (reload:ctrl-r) (view ignored:ctrl-g)'
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

swapfiles() {
  local TMPFILE=$(mktemp)
  mv "$1" "$TMPFILE" && mv "$2" "$1" && mv "$TMPFILE" "$2"
}

take() {
  mkdir -p $@ && cd ${@:$#}
}

open() {
  local open_cmd

  case "$OSTYPE" in
    darwin*)  open_cmd='open' ;;
    linux*)   open_cmd='nohup xdg-open' ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  /usr/bin/env ${=open_cmd} "$@" &>/dev/null
}
