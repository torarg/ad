#!/bin/bash

print_usage() {
    echo "ad run [ansible-playbook args ...]"
}

parse_args() {
    while getopts :h flag; do
        case "${flag}" in
            h) print_usage && return 1 ;;
            ?) ;;
        esac
    done
    return 0
}

run() {
    ansible-playbook playbook.yml $@
}
