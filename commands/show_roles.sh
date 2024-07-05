. $CONFIG_DIR/config || exit 1

load_env || exit 1
validate_env || exit 1

echo "ROLES"
for role in $ROLES; do
    echo $role;
done
