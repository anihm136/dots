{%@@ if profile == "work" @@%}
source /opt/homebrew/Cellar/fzf/0.35.1/shell/completion.zsh
{%@@ else @@%}
autoload -Uz bashcompinit && bashcompinit
eval "$(register-python-argcomplete pipx)"

eval $(register-python-argcomplete ansible)
eval $(register-python-argcomplete ansible-config)
eval $(register-python-argcomplete ansible-console)
eval $(register-python-argcomplete ansible-doc)
eval $(register-python-argcomplete ansible-galaxy)
eval $(register-python-argcomplete ansible-inventory)
eval $(register-python-argcomplete ansible-playbook)
eval $(register-python-argcomplete ansible-pull)
eval $(register-python-argcomplete ansible-vault)

complete -C '/sbin/aws_completer' aws

source /usr/share/fzf/completion.zsh
{%@@ endif @@%}
