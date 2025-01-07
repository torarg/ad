## 0.0.6
- use 'include_role' instead of 'import_role' in playbook tasks.

## 0.0.5
- add ``-s`` silent flag to run command

## 0.0.4
- refactor repo and Makefile
- improve shell completions
- add 'show-hostvars' command
- add 'push-roles' command to push deployment-local changes upstream
- add pycache patterns to default .gitignore contents

## 0.0.3
- add optional shell completion support for ksh
- improve usage
- add "show-{hosts,groups,groupvars,roles}" commands
- drop deployment arguments and only support ``-f``
- support relative paths for ``-f`` without explicit "./"

## 0.0.2
- add 'ansible_common_remote_group' to group_vars/ansible_deployment
- add ssh key permission check

## 0.0.1
- initial release
