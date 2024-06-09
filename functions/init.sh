print_usage() {
    echo "usage: ad init -r GIT_REPO_URL -b BRANCH_OR_TAG -g GPG_USER ROLES ..."
    echo "       ad init -f ENV_FILE"
}

parse_args() {
    VERBOSE=0
    while getopts r:b:f:h flag; do
        case "${flag}" in
            r) GIT_URL=$OPTARG ;;
            b) GIT_BRANCH=$OPTARG ;;
            f) ENV_FILE=$(realpath $OPTARG) ;;
            g) GPG_USER=$OPTARG ;;
            v) VERBOSE=1 ;;
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

create_dirs() {
    mkdir $GIT_DIR
    mkdir $ROLES_DIR
    mkdir $GROUP_VARS_DIR
    mkdir $HOST_VARS_DIR
    mkdir $SSH_DIR
    mkdir $INVENTORY_PATH
}

initialize_deployment_repo() {
    echo ".roles/" > .gitignore
    echo "inventory/** filter=git-crypt diff=git-crypt" > $GITATTRIBUTES_FILE
    echo "host_vars/** filter=git-crypt diff=git-crypt" >> $GITATTRIBUTES_FILE
    echo "group_vars/** filter=git-crypt diff=git-crypt" >> $GITATTRIBUTES_FILE
    echo ".ssh/** filter=git-crypt diff=git-crypt" >> $GITATTRIBUTES_FILE

    git init > /dev/null || return 1
    git add .gitignore $GITATTRIBUTES_FILE
    git commit -m "add git configuration"
    git-crypt init || return 1
    git-crypt add-gpg-user $GPG_USER || exit 1
    git add . || return 1
    git commit -m 'add initial deployment files' || return 1
}

create_ssh_keypair() {
    ssh-keygen -q -P "" -f $SSH_KEY_FILE
}
