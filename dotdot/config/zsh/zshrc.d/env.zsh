# Create venv inside project dir
export PIPENV_VENV_IN_PROJECT=1

# Use bat to highlight manpages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Don't print logs when changing into directory
export DIRENV_LOG_FORMAT=

# Defaults
export EDITOR="nvim"
export PAGER="less"
export LESS="-R"

{%@@ if profile == "work" @@%}
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
{%@@ else @@%}
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
{%@@ endif @@%}
