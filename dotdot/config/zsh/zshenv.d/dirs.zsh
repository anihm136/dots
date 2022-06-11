# Send stuff to XDG dirs
# Android studio
export ANDROID_HOME="$XDG_DATA_HOME"/android
# AWS CLI
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials       
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
# Cargo
export CARGO_HOME="$XDG_DATA_HOME"/cargo
# Cuda
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
# Gnupg
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
# Go
export GOPATH="$XDG_DATA_HOME"/go
# Libice
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
# Mysql
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history
# Less
export LESSHISTFILE="$XDG_DATA_HOME/less/history"
# GTK
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/.gtkrc-2.0"
# Antibody
export ANTIBODY_HOME="$XDG_DATA_HOME/antibody"
# Ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
# NPM
export NPM_CONFIG_PREFIX="$HOME/dev/node"
# ASDF
export ASDF_DIR="/opt/asdf-vm"
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/asdfrc"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
