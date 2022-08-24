#!/bin/sh

set -e

# REPLACE VARIABLES IN CONFIG FILE
if ! test -f "/etc/pulseway/config-template.xml"; then
	echo "You must mount your config.xml to '/etc/pulseway/config-template.xml'"
	exit 1
fi
envsubst < "/etc/pulseway/config-template.xml" > "/etc/pulseway/config.xml"

if [ "$1" = "run" ]; then
	# START PULSEWAY
	sudo /etc/init.d/pulseway start

	# MONITOR PULSEWAY
	if pgrep pulsewayd > /dev/null; then
		echo "`date` - Pulseway running . . ."
	fi
	while pgrep pulsewayd > /dev/null; do
		sleep 1;
	done
	echo "Looks like pulseway is no longer running. Exiting . . ."
	exit 1
fi

exec "$@"
