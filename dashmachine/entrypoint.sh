#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"

exec gunicorn --bind 0.0.0.0:5000 wsgi:app
