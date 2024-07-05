print_usage() {
    echo "ad show-hosts [-h]"
}

print_hosts() {
    echo "HOSTS"
    for host in $HOSTS; do
        echo $host;
    done
}
