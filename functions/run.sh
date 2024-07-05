#!/bin/bash

print_usage() {
    echo "ad run [ansible-playbook args ...]"
}

parse_args() {
    VERBOSE=0
    case "${1}" in
        -h) print_usage && return 1 ;;
    esac
    return 0
}

run() {
    ansible-playbook playbook.yml $@
}
