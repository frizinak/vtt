# VTT | Vim Terminal Tweaks | Virtual Terminal Tranquility

## INTRODUCTION

Tries to fix some weirdness in `:terminal` (in particular when using `nvim`)
and provides a simple working dir syncing tool (bash+python+nvim)

In its current state it feels stable enough to use nvim as
my main terminal emulator.

## INSTALLATION

`Plugin 'frizinak/vtt'`

For cwd syncing:
    Add the following to your shell config (.bashrc / .zshrc / ...).
    Make sure the vtt_dir path is correct

    `vtt_dir="$HOME/.config/nvim/bundle/vtt";`
    `source "$vtt_dir/utils/nvim-cd-sync.sh";`

To prevent nesting vim instances:

    `EDITOR=$HOME/.config/nvim/bundle/vtt/utils/nvim-cmd edit-wait`

    or add an executable bash script to your path like:

    ```
    #! /bin/env sh

    if [ -z $NVIM ]; then
        /usr/bin/nvim "$@"
        exit $?
    fi

    "$HOME/.vim/vtt/utils/nvim-cmd" edit-wait "$1"
    ```

## SUGGESTED USAGE

Launch (n)vim with '+Term'

in your `$MYVIMRC`: ($YOURVIMRC ?)
```
noremap S :BottomTerm<cr>
let g:vtt_map_escesc = 1
let g:vtt_no_kill_term = 1

fun VTTOnTermBuffer()
    setlocal norelativenumber
    setlocal nonumber
    setlocal laststatus=0
    setlocal bufhidden="hide"
    setlocal hidden
endfun

fun VTTOnNonTermBuffer()
    setlocal relativenumber
    setlocal laststatus=2
    setlocal number
endfun
```

