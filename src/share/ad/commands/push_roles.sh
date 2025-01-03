. $CONFIG_DIR/config || exit 1
. $FUNCTION_DIR/common.sh || exit 1
. $FUNCTION_DIR/push.sh || exit 1

parse_args "$@" || exit 1
load_env || exit 1
validate_env || exit 1

execute refresh_roles_repo
execute copy_changes_to_repo
execute commit_changes "$commit_message"
execute push_changes
