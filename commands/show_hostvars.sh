. $CONFIG_DIR/config || exit 1
. $CONFIG_DIR/functions/show_hostvars.sh || exit 1

parse_args $@ || exit 1
load_env || exit 1
validate_env || exit 1
print_host_vars
