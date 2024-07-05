. $CONFIG_DIR/config || exit 1

load_env || exit 1
validate_env || exit 1

echo "HOSTS"
for host in $HOSTS; do
    echo $host
done
