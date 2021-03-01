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

## run (only once) processes which spawn with different name
if (command -v gnome-keyring-daemon && ! pgrep gnome-keyring-d); then
 eval $(gnome-keyring-daemon --start)
 export SSH_AUTH_SOCK
fi
if (command -v start-pulseaudio-x11 && ! pgrep pulseaudio); then
    start-pulseaudio-x11 &
fi

run blueberry-tray
run nm-applet
run tilda
run mocp -S

run thunderbird
run slack
run teams
run element-desktop
run signal-desktop
run2 telegram-desktop telegram-deskto
run2 "discord" "Discord"
run2 "whatsapp-nativefier" "WhatsApp"
run2 "instagram-nativefier" "Instagram"
