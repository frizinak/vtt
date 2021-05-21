===============================================================================
            VTT | Vim Terminal Tweaks | Virtual Terminal Tranquility
===============================================================================

INTRODUCTION

Tries to fix some weirdness in |:terminal|. In particular when using |nvim|
and provides a simple working dir syncing tool (bash+python+nvim)

INSTALLATION

`Plugin 'frizinak/vtt'`

For cwd syncing:
    Add the following to your shell config (.bashrc / .zshrc / ...).
    Make sure the vtt_dir path is correct

    `vtt_dir="$HOME/.config/nvim/bundle/vtt";`
    `source "$vtt_dir/utils/nvim-cd-sync.sh";`

