let g:vim_search_pulse_mode = 'pattern'
let g:vim_search_pulse_disable_auto_mappings = 1

map *  <Plug>(asterisk-z*)<Plug>(pulse)
map #  <Plug>(asterisk-z#)<Plug>(pulse)
map g* <Plug>(asterisk-gz*)<Plug>(pulse)
map g# <Plug>(asterisk-gz#)<Plug>(pulse)
nmap n n<Plug>Pulse
nmap N N<Plug>Pulse
