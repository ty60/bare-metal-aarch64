#!/bin/bash


set -eu

DEBUG_MODE=false
while getopts ":d" opt; do
    case ${opt} in
        d)
            DEBUG_MODE=true
            ;;
        *)
            echo "Unknown option"
            exit 1
            ;;
    esac
done

make

if [[ ${DEBUG_MODE} == true ]]; then
    DEBUG_OPT="\
        -gdb tcp::12345 \
        -S
    "

    if [[ -f cmd.gdb ]]; then
        tmux split-window -h "gdb-multiarch -q -x cmd.gdb"
    else
        tmux split-window -h "gdb-multiarch -q"
    fi
    # TODO: do something better to get pane indexes
    org_pane_index=$(tmux list-pane | head -1 | cut -d ':' -f 1)
    gdb_pane_index=$(tmux list-pane | tail -1 | cut -d ':' -f 1)
    tmux select-pane -t ${org_pane_index}
else
    DEBUG_OPT=""
fi

qemu-system-aarch64 \
    -cpu cortex-a57 \
    -M virt \
    -kernel kernel \
    -nographic \
    ${DEBUG_OPT}

if [[ ${DEBUG_MODE} == true ]] && [[ $(tmux list-pane | wc -l) -ge 2 ]]; then
    tmux kill-pane -t ${gdb_pane_index}
fi
