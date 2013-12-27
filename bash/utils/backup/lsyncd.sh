#!/bin/bash

DAEMON=/usr/bin/lsyncd
CONFFILE=$HOME/.config/lsyncd.conf

if test -x $DAEMON ; then
    . /lib/lsb/init-functions
    
    set -e

    log_daemon_msg "Starting lsyncd daemon" "lsyncd"
    if pidof -x lsyncd > /dev/null; then
        log_progress_msg "apparently already running"
        log_end_msg 1
        exit 0
    fi

    if start-stop-daemon --start --quiet --user $USER \
        --exec $DAEMON -- $CONFFILE; then
        rc=0
        sleep 1
        if ! pidof -x lsyncd > /dev/null; then
            log_failure_ms "lsyncd daemon failed to start"
            rc=1
        fi
    else
        rc=1
    fi

    if [ $rc -eq 0 ]; then
        log_end_msg 0
    else
        log_end_msg 1
    fi
else
    echo "$DAEMON n'est pas exécutable."
fi
