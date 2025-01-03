print_usage() {
    echo "ad push-roles [-hv] -m message"
}

parse_args() {
    VERBOSE=0
    while getopts hvm: flag; do
        case "${flag}" in
            v) VERBOSE=1 ;;
            h) print_usage && return 1 ;;
            m) commit_message="${OPTARG}" ;;
            ?) echo "error: invalid option -- $OPTARG" >&2 && return 1 ;;
        esac
    done
    shift $(($OPTIND - 1))
    [ -n "$1" ] && echo "error: invalid argument -- $@" >&2 && return 1
    [ -z "$commit_message" ] && echo "missing argument: '-m'" && return 1
    return 0
}

role_repo() {
    cd ${GIT_DIR}
    git "$@"
    cd -
}

refresh_roles_repo() {
    role_repo pull
}

copy_changes_to_repo() {
    cp -r ${ROLES_DIR}/* ${GIT_DIR}/
}

commit_changes() {
    role_repo add .
    msg="$@"
    role_repo commit -m "$msg"
}

push_changes() {
    role_repo push
}
