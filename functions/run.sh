#!/bin/bash

run() {
    ansible-playbook playbook.yml $@
}
