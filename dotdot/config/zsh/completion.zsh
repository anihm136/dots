autoload -Uz bashcompinit && bashcompinit
{%@@ if profile == "work" @@%}
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
complete -o nospace -C /opt/homebrew/bin/terraform terraform
{%@@ else @@%}

# Pipx
zi ice id-as"pipx_completion" has"pipx" \
  eval"register-python-argcomplete pipx"
zi light z-shell/null

# Ansible
zi ice id-as"ansible_completion" has"ansible" \
  eval"register-python-argcomplete ansible"
zi light z-shell/null
zi ice id-as"ansible_vault_completion" has"ansible" \
  eval"register-python-argcomplete ansible-vault"
zi light z-shell/null
zi ice id-as"ansible_config_completion" has"ansible" \
  eval"register-python-argcomplete ansible-config"
zi light z-shell/null
zi ice id-as"ansible_console_completion" has"ansible" \
  eval"register-python-argcomplete ansible-console"
zi light z-shell/null
zi ice id-as"ansible_doc_completion" has"ansible" \
  eval"register-python-argcomplete ansible-doc" run-atpull
zi light z-shell/null
zi ice id-as"ansible_galaxy_completion" has"ansible" \
  eval"register-python-argcomplete ansible-galaxy"
zi light z-shell/null
zi ice id-as"ansible_inventory_completion" has"ansible" \
  eval"register-python-argcomplete ansible-inventory"
zi light z-shell/null
zi ice id-as"ansible_playbook_completion" has"ansible" \
  eval"register-python-argcomplete ansible-playbook"
zi light z-shell/null
zi ice id-as"ansible_pull_completion" has"ansible" \
  eval"register-python-argcomplete ansible-pull"
zi light z-shell/null

# Git LFS
zi ice id-as"git_lfs_completion" \
	has"git-lfs" \
	as"completion" \
	nocompile \
	atclone"git-lfs completion zsh > _git-lfs" \
	atpull"%atclone" \
	run-atpull
zi light z-shell/null

# AWS CLI
complete -C '/sbin/aws_completer' aws

# FZF
zi ice wait lucid
zi snippet "https://github.com/junegunn/fzf/blob/master/shell/completion.zsh"
{%@@ endif @@%}
