. $CONFIG_DIR/config || exit 1
. $FUNCTION_DIR/update.sh || exit 1

parse_args $@ || exit 1
validate_args || exit 1
execute clone_roles_repo
execute update_roles
execute write_playbook
execute write_inventory
execute write_ansible_cfg
echo "Updated files"
echo "Check 'git status' and 'git diff' to review changes."
