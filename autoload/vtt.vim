let s:ocpo = &cpo
set cpo&vim

if !exists('*VTTOnTermBuffer')
  function VTTOnTermBuffer()
  endfunction
endif

if !exists('*VTTOnNonTermBuffer')
  function VTTOnNonTermBuffer()
  endfunction
endif

fun s:setTerm()
    if match(expand('%:p'), has('nvim') ? '^term\:\/\/' : '^!') >= 0
        call function(get(g:, 'vtt_on_term_buffer', 'VTTOnTermBuffer'))()
        return
    endif

    call function(get(g:, 'vtt_on_non_term_buffer', 'VTTOnNonTermBuffer'))()
endfun

fun s:onTermExit(job_id, code, event)
    call s:onTermExitVim(a:job_id, a:code)
endfun

fun s:onTermExitVim(job_id, code)
    quit
endfun

fun s:term()
    let l:buf = get(g:, 'vtt_buf', '')
    if l:buf != ''
        return bufname(l:buf)
    endif

    return ''
endfun

" Start a terminal or switch to an old one
fun vtt#Term()
    if (&buftype == 'terminal')
        return
    endif

    let l:name = s:term()
    if l:name != ''
        exe 'buffer' l:name
        return
    endif

    let l:exe = get(g:, 'vtt_shell', $SHELL)
    if has('nvim')
        call termopen(l:exe, {'on_exit': function('s:onTermExit')})
        let g:vtt_buf = bufname()
        return
    endif

    call term_start(l:exe, {'curwin': 1, 'exit_cb': function('s:onTermExitVim')})
    let g:vtt_buf = bufname()
endfun

fun vtt#BottomTerm()
    if &buftype == 'terminal'
        return
    endif
    exe ':botright ' get(g:, 'vtt_bottom_term_height', 15) 'split +call\ vtt#Term\(\)'
endfun

fun s:wq()
    write
    bd
endfun

fun vtt#abbrev(cmd)
    if getcmdtype() != ':'
        return a:cmd
    endif

    let l:w = match(a:cmd, 'w') >= 0
    let l:a = match(a:cmd, 'a') >= 0
    let l:q = match(a:cmd, 'q') >= 0
    let l:exe = ''
    if l:w
        let l:exe = l:exe . 'w'
        if l:a
            let l:exe = l:exe . 'a'
        endif
        exe l:exe
    endif

    if !l:q
        return ''
    endif

    if l:a
        return '%bd'
    endif

    if winnr('$') > 1
        return 'q'
    endif

    return 'bd'
endfun

if has('nvim')
    au TermOpen * if &buftype == 'terminal' |
        \ startinsert |
        \ call s:setTerm() |
        \ endif
endif

autocmd BufEnter,BufFilePost * call s:setTerm()

" Fixes inactive cursor if your term supports it.
" Stops insert mode and restores it when we gain focus again.
if has('nvim') && get(g:, 'vtt_fix_inactive_cursor', 1)
    let s:toggleInsert=0
    autocmd FocusLost * let s:toggleInsert=0 | let s:m = mode() | if s:m == 'i' || s:m == 't' | stopinsert | let s:toggleInsert=1 | endif
    autocmd FocusGained * if s:toggleInsert | startinsert | endif
endif

if has('nvim') && get(g:, 'vtt_no_kill_term', 0)
    for k in ['q', 'qa', 'wq', 'wqa']
        exe 'cabbrev' k '<c-r>=vtt#abbrev("' k '")<cr>'
    endfor
endif

let &cpo = s:ocpo
unlet s:ocpo
