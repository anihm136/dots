# Path additions
path+=("$HOME/.cargo/bin")
path+=("$NPM_CONFIG_PREFIX/bin")
path+=("$XDG_CONFIG_HOME/emacs/bin")
if [ -d "$HOME/.local/bin" ] ; then
	path+=("$HOME/.local/bin")
	path+=("$HOME/.local/bin/scripts")
	path+=("$HOME/.local/bin/scripts/scripts_personal")
fi
export PATH

# Settings
export SUDO_ASKPASS="{{@@ home @@}}/.local/bin/scripts/scripts_personal/askpass"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export MSSQL_CLI_TELEMETRY_OPTOUT=1

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
