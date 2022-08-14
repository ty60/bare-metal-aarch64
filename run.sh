#!/bin/bash


set -eu


function usage {
    cat << EOF
    run.sh [-d] kernel_name
EOF
}

DEBUG_MODE=false
while getopts ":dh" opt; do
    case ${opt} in
        d)
            DEBUG_MODE=true
            ;;
        h)
            usage
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done

shift $(($OPTIND - 1))
kernel_name=${1}

if [[ ! -d ${kernel_name} ]]; then
    echo "unknown kernel ${kernel_name}"
    exit 1
fi

make -C ${kernel_name}

if [[ ${DEBUG_MODE} == true ]]; then
    DEBUG_OPT="\
        -gdb tcp::12345 \
        -S
    "

    if [[ -f ${kernel_name}/cmd.gdb ]]; then
        tmux split-window -h "gdb-multiarch -q -x ${kernel_name}/cmd.gdb"
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
    -kernel ${kernel_name}/kernel \
    -nographic \
    ${DEBUG_OPT}

if [[ ${DEBUG_MODE} == true ]] && [[ $(tmux list-pane | wc -l) -ge 2 ]]; then
    tmux kill-pane -t ${gdb_pane_index}
fi
