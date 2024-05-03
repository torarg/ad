# about
ad is my opioniated approach on managing ansible deployments.
It creates an almost ready to use ansible deployment directory
by 
- writing an inventory based on given hosts
- creating host groups for each given role (all hosts are in all groups by default)
- writing a playbook which
    - imports all given roles
    - each role will only be run if the host is part of the corresponding group
    - also the group name is added as tag to the import task
- pulling a list of given roles from a git repository
- copy role defaults to corresponding group_vars
- writing a new ssh keypair to the deployment directory
- writing a new ssh config to the deployment directory
- initiating a git repository in the deployment directory
- use git-crypt to encrypt secret and inventory files
