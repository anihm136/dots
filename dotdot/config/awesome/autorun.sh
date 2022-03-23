#!/usr/bin/env bash

## run (only once) processes which spawn with the same name
function run {
   if (command -v $1 && ! pgrep $1); then
     $@&
   fi
}

function run2 {
   if (command -v $1 && ! pgrep $2); then
     $1&
   fi
}

run tilda

{%@@ if profile == "sorcery" @@%}
run thunderbird
run slack
# run teams
run2 discord Discord
run element-desktop
# run signal-desktop
run whatsapp
run instagram
run zulip
# run2 telegram-desktop telegram-deskto
{%@@ endif @@%}
