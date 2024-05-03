get_group_from_role() {
    echo $1 | sed 's|/|_|g'
}

execute() {
    if [[ $VERBOSE -eq 0 ]]; then
        $@ > /dev/null || exit 1
    else
        $@ || exit 1
    fi
}

cleanup() {
    for path in "$DEPLOYMENT_FILES"; do
        rm -fr $path
    done
}

update_roles() {
        rm -fr $ROLES_DIR/*
    for role in "${ROLES[@]}"; do
        role_dir="${ROLES_DIR}/${role}"
        group_name=$(get_group_from_role $role)
        group_vars_file=$GROUP_VARS_DIR/$group_name
        mkdir -p $role_dir
        cp -r $GIT_DIR/$role/* $role_dir/
        if [ -f "$GROUP_VARS_DIR/$group_name" ]; then
            merged_vars="$(yq -y -s '.[0] * .[1]' <(cat $GIT_DIR/$role/defaults/*) $group_vars_file)"
            echo "$merged_vars" > $group_vars_file
        else
            cat $GIT_DIR/$role/defaults/* | yq -y > $GROUP_VARS_DIR/$group_name
        fi
    echo "ansible_ssh_private_key_file: ./.ssh/ansible_ssh_key" > $GROUP_VARS_DIR/ansible_deployment
    echo "ansible_ssh_public_key_file: ./.ssh/ansible_ssh_key.pub" >> $GROUP_VARS_DIR/ansible_deployment
    echo "ansible_user: $SSH_USER" >> $GROUP_VARS_DIR/ansible_deployment
    done
}

write_playbook() {
    cp $PLAYBOOK_TEMPLATE $PLAYBOOK_PATH
    for role in "${ROLES[@]}"; do
        group_name=$(get_group_from_role $role)
        role_name=${role}
        export group_name role_name
        cat $TASK_TEMPLATE | envsubst >> $PLAYBOOK_PATH
    done
}

write_inventory() {
    cp $INVENTORY_TEMPLATE $INVENTORY_HOSTS_FILE
    [ ! -f $INVENTORY_CUSTOM_FILE ] && touch $INVENTORY_CUSTOM_FILE

    echo "" > $SSH_CONFIG
    for host in ${HOSTS[@]}; do
        hostname="$(echo $host | cut -d ':' -f 1)"
        host_ip="$(echo $host | cut -s -d ':' -f 2)"

        echo "Host $hostname" >> $SSH_CONFIG
        echo "  User $SSH_USER" >> $SSH_CONFIG
        echo "$hostname" >> $INVENTORY_HOSTS_FILE

        if [ -n "$host_ip" ]; then
            echo "  Hostname $host_ip" >> $SSH_CONFIG
        elif [ -n "$host_ip" ] && [ -f $HOST_VARS_DIR/$hostname ]; then
            merged_vars="$(yq -y -s '.[0] * .[1]' <(echo ansible_host: $host_ip) $HOST_VARS_DIR/$hostname)"
            echo "$merged_vars" > $HOST_VARS_DIR/$hostname
        elif [ -n "$host_ip" ] && [ ! -f $HOST_VARS_DIR/$hostname ]; then
            echo "ansible_host: $host_ip" > $HOST_VARS_DIR/$hostname
        fi
    done

    rm $INVENTORY_GROUPS_FILE
    for role in "${ROLES[@]}"; do
        group_name=$(get_group_from_role $role)
        if grep "$group_name" $INVENTORY_CUSTOM_FILE; then
            continue
        fi
        export group_name 
        cat $INVENTORY_GROUP_TEMPLATE | envsubst >> $INVENTORY_GROUPS_FILE
    done
}

write_ansible_cfg() {
    echo "[defaults]" > $ANSIBLE_CFG_PATH
    echo "inventory = inventory/hosts.ini, inventory/groups.ini, inventory/custom.ini" >> $ANSIBLE_CFG_PATH
    echo "interpreter_python = auto_silent" >> $ANSIBLE_CFG_PATH
}

clone_roles_repo() {
    rm -rf $GIT_DIR
    git clone --quiet --depth 1 --branch $GIT_BRANCH $GIT_URL $GIT_DIR > /dev/null
}
