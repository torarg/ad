print_usage() {
    echo "ad show-groupvars [-hjn] [group]"
}

parse_args() {
    only_names=0
    json_output=0
    scope="./group_vars/*"
    while getopts :hjn flag; do
        case "${flag}" in
            j) json_output=1 ;;
            n) only_names=1 ;;
            h) print_usage && return 1 ;;
            ?) echo "error: invalid option -- $OPTARG" >&2 && return 1 ;;
        esac
    done
    shift $(($OPTIND - 1))
    if [ -n "$2" ]; then
        scope="./group_vars/{$(echo $@ | sed 's/ /,/g')}"
    elif [ -n "$1" ]; then
        scope="./group_vars/$1"
    fi
    return 0
}

print_group_vars() {
    command="cat $scope"
    if [ $json_output -eq 1 ]; then
        command="$command | yq"
    fi
    if [ $only_names -eq 1 ]; then
        command="$command | egrep '^[0-9a-zA-Z_]+:.*$' | cut -f 1 -d ':'"
    fi
    /bin/sh -c "$command"
}
