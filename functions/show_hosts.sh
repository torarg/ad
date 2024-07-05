print_usage() {
    echo "ad show-hosts [-h]"
}

parse_args() {
    case "${1}" in
        "" ) ;;
        -h) print_usage && return 1 ;;
        *) echo "error: invalid argument" && return 1 ;;
    esac
    return 0
}

print_hosts() {
    echo "HOSTS"
    for host in $HOSTS; do
        echo $host;
    done
}
