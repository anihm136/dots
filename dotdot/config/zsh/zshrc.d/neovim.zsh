# Signal handler for reloading neovim
catch_signal_usr1() {
  trap catch_signal_usr1 USR1
  nvim -c ":SessionManager! load_last_session"
}
trap catch_signal_usr1 USR1
