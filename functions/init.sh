print_usage() {
    echo "usage: ad init [-v|-h]"
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
