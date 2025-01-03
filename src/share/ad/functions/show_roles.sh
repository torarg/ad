print_usage() {
    echo "ad show-roles [-h]"
}

print_roles() {
    echo "ROLES"
    for role in $ROLES; do
        echo $role;
    done
}
