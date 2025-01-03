. $CONFIG_DIR/config || exit 1
. $CONFIG_DIR/functions/clean.sh || exit 1

parse_args $@ || exit 1
load_env || exit 1
validate_env || exit 1
cleanup || exit 1
