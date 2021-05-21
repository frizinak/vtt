#! /bin/env sh

__vtt_nvim_cd_sync_prompt_wrapper () {
    if [ "$PWD" != "$old_pwd" ]; then
        "$vtt_nvimcmd" "exe 'cd' fnameescape('$PWD')"
    fi
    old_pwd="$PWD"
    "$old_prompt"
}

__vtt_nvim_cd_sync_init() {
    if [ -z $vtt_dir ]; then
        return
    fi
    vtt_nvimcmd="$vtt_dir/utils/nvim-cmd"

    if [ ! -x "$vtt_nvimcmd" ]; then
        chmod +x "$vtt_nvimcmd"
    fi

    old_pwd="$PWD"
    old_prompt="$PROMPT_COMMAND"
    export PROMPT_COMMAND=__vtt_nvim_cd_sync_prompt_wrapper
}

__vtt_nvim_cd_sync_init
