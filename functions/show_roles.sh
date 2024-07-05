print_usage() {
    echo "ad show-roles [-h]"
}

parse_args() {
    case "${1}" in
        "" ) ;;
        -h) print_usage && return 1 ;;
        *) echo "error: invalid argument" && return 1 ;;
    esac
    return 0
}

print_roles() {
    echo "ROLES"
    for role in $ROLES; do
        echo $role;
    done
}
