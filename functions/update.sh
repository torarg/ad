print_usage() {
    echo "usage: ad update -r GIT_REPO_URL -b BRANCH_OR_TAG -g GPG_USER ROLES ..."
    echo "       ad update -f ENV_FILE"
}

parse_args() {
    while getopts r:b:f:h flag; do
        case "${flag}" in
            r) GIT_URL=$OPTARG ;;
            b) GIT_BRANCH=$OPTARG ;;
            f) ENV_FILE=$OPTARG ;;
            g) GPG_USER=$OPTARG ;;
            h) print_usage && return 1 ;;
        esac
    done
    shift $((OPTIND - 1))
    ROLES="${@}"

    [ -n "$ENV_FILE" ] && [ -f $ENV_FILE ] && . $ENV_FILE
    return 0
}

validate_args() {
    if [ -z "$GIT_URL" ] || [ -z "$GIT_BRANCH" ] || [ -z "$ROLES" ] || [ -z "$GPG_USER" ]; then
        print_usage
        return 1
    fi
}
