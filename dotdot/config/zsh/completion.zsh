autoload -Uz bashcompinit && bashcompinit
{%@@ if profile == "work" @@%}
source "$(brew --prefix)/Cellar/fzf/$(fzf --version | cut -d ' ' -f 1)/shell/completion.zsh"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
complete -o nospace -C /opt/homebrew/bin/terraform terraform
{%@@ else @@%}
zi ice id-as"pipx_completion" has"pipx" \
  eval"register-python-argcomplete pipx" run-atpull
zi light z-shell/null

zi ice id-as"ansible_completion" has"ansible" \
  eval"register-python-argcomplete ansible" run-atpull
zi light z-shell/null
zi ice id-as"ansible_vault_completion" has"ansible" \
  eval"register-python-argcomplete ansible-vault" run-atpull
zi light z-shell/null
zi ice id-as"ansible_config_completion" has"ansible" \
  eval"register-python-argcomplete ansible-config" run-atpull
zi light z-shell/null
zi ice id-as"ansible_console_completion" has"ansible" \
  eval"register-python-argcomplete ansible-console" run-atpull
zi light z-shell/null
zi ice id-as"ansible_doc_completion" has"ansible" \
  eval"register-python-argcomplete ansible-doc" run-atpull
zi light z-shell/null
zi ice id-as"ansible_galaxy_completion" has"ansible" \
  eval"register-python-argcomplete ansible-galaxy" run-atpull
zi light z-shell/null
zi ice id-as"ansible_inventory_completion" has"ansible" \
  eval"register-python-argcomplete ansible-inventory" run-atpull
zi light z-shell/null
zi ice id-as"ansible_playbook_completion" has"ansible" \
  eval"register-python-argcomplete ansible-playbook" run-atpull
zi light z-shell/null
zi ice id-as"ansible_pull_completion" has"ansible" \
  eval"register-python-argcomplete ansible-pull" run-atpull
zi light z-shell/null

complete -C '/sbin/aws_completer' aws

source /usr/share/fzf/completion.zsh
{%@@ endif @@%}
