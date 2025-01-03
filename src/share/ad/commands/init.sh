. $CONFIG_DIR/config || exit 1
. $FUNCTION_DIR/init.sh || exit 1

parse_args $@ || exit 1
load_env || exit 1
validate_env || exit 1

execute create_dirs
execute clone_roles_repo
execute update_roles
execute write_playbook
execute write_inventory
execute write_ansible_cfg
execute create_ssh_keypair
execute initialize_deployment_repo
