#!/bin/sh
set -Eeo pipefail

# Apache gets grumpy about PID files pre-existing
rm -f /run/httpd/httpd.pid

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- httpd "$@"
fi

if [ "$1" = 'httpd' ]; then
	shift # "haproxy"
	# if the user wants "haproxy", let's add a couple useful flags
	#   -W  -- "master-worker mode" (similar to the old "haproxy-systemd-wrapper"; allows for reload via "SIGUSR2")
	#   -db -- disables background mode
	set -- httpd -DFOREGROUND "$@"
fi

exec "$@"

# exec httpd -DFOREGROUND "$@"