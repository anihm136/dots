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
