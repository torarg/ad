print_usage() {
    echo "ad run [-sh] -- [ansible-playbook args ...]"
}

run() {
    while getopts sh flag; do
        case "${flag}" in
            h) print_usage && return 0 ;;
            s) silent=1 ;;
            ?) print_usage && return 1 ;;
        esac
    done
    shift $(($OPTIND - 1))

    cmd=$(echo "ansible-playbook playbook.yml $@")

    if [ "$silent" -eq "1" ]; then
        output="$($cmd)"
        rc=$?
        [ "$rc" -ne "0" ] && echo "$output"
    else
        $cmd
        rc=$?
    fi
    exit $rc
}
