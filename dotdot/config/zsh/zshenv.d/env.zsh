# Path additions
if [ -d "$HOME/.local/bin" ] ; then
	path+=("$HOME/.local/bin")
	path+=("$HOME/.local/bin/scripts")
fi
path+=("$XDG_CONFIG_HOME/emacs/bin")

{%@@ if profile == "work" @@%}
brewprefix=/opt/homebrew
path+=("$brewprefix/bin:$brewprefix/sbin:$PATH")
source "$brewprefix/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
export MANPATH="$brewprefix/share/man:$MANPATH"
unset brewprefix
{%@@ else @@%}
path+=("$HOME/.cargo/bin")
path+=("$NPM_CONFIG_PREFIX/bin")

# Settings
export SUDO_ASKPASS="$HOME/.local/bin/scripts/askpass"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export MSSQL_CLI_TELEMETRY_OPTOUT=1
{%@@ endif @@%}

export PATH
