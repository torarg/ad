. $CONFIG_DIR/config || exit 1
. $CONFIG_DIR/functions/show_groups.sh || exit 1

parse_args $@ || exit 1
load_env || exit 1
validate_env || exit 1

print_list $(get_group_from_role "$ROLES")
