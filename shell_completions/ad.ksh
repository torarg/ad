# Load this file in your ~/.kshrc, e.g.:
#   . /usr/local/share/ad/shell_completions/ad.ksh
COMPLETION_PATH=/usr/local/share/ad/shell_completions/ad.ksh

# surpress stderr when using ad to generate autocompletion output
adq() {
    ad $@ 2> /dev/null
}

# alias for cd to reload completions on each directory change
# this is used to support autocompletion for deployment related objects like hosts.
alias cd=". ${COMPLETION_PATH}; cd"

# first level completion: commands
set -A complete_ad_1 -- init update run clean show-roles show-hosts show-groups show-groupvars
# second level completion: options and groups
set -A complete_ad_2 -- -l -t -h -v -n -j $(adq show-groups)
# third and following level completion: hosts, groups, options
set -A complete_ad -- $(adq show-hosts && adq show-groups) -l -t -e
