. $CONFIG_DIR/config || exit 1
. $CONFIG_DIR/functions/run.sh || exit 1

run $@ || exit 1
