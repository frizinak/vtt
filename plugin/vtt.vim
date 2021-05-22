if exists('g:loaded_vim_terminal_tweaks')
    \ || (!exists('*termopen') && !exists('*term_start'))
    finish
endif
let g:loaded_vim_terminal_tweaks = 1

if !exists(':Term')
    command -nargs=? Term call vtt#Term('<args>')
endif

if !exists(':BottomTerm')
    command BottomTerm call vtt#BottomTerm()
endif

if get(g:, 'vtt_map_escesc', 0) && exists(':tnoremap')
    tnoremap <Esc><Esc> <C-\><C-n>
endif

