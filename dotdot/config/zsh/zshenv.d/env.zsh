# Path additions
path+=("$HOME/.cargo/bin")
path+=("$NPM_CONFIG_PREFIX/bin")
path+=("$XDG_CONFIG_HOME/emacs/bin")
if [ -d "$HOME/.local/bin" ] ; then
	path+=("$HOME/.local/bin")
	path+=("$HOME/.local/bin/scripts")
fi
export PATH

# Settings
export SUDO_ASKPASS="$HOME/.local/bin/scripts/askpass"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export MSSQL_CLI_TELEMETRY_OPTOUT=1
