#!/usr/bin/env bash

CONFIG_DIR="/etc/ad"
. $CONFIG_DIR/config || exit 1

cleanup || exit 1
