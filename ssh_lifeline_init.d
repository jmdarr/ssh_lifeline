#!/bin/bash
# chkconfig: 2345 20 80
# description: ssh_lifeline - an autossh-based reverse ssh tunnel
#  Hahaha, hidden steps, baby! Perform the steps below... if you dare:
#    1. Set up ssh key auth for your ssh connection.
#    2. Use the following template, plus any other options you
#       wish, in the ssh config file for the user making the
#       ssh connection:
#       * NOTE * fields are denoted by <> and are revelant to
#                variables below. script assumes you use port
#                22 for ssh, change if you need
#        | Host <ssh_hostname>
#        |   HostName            your_remote_server
#        |   User                your_ssh_user
#        |   Port                22
#        |   IdentityFile        path_to_your_id_key_file
#        |   RemoteForward       remote_port_for_ssh_tunnel localhost:22
#        |   ServerAliveInterval 30
#        |   ServerAliveCountMax 3
#
# Source function library.
. /etc/rc.d/init.d/functions

# You configure these:
ssh_hostname="<ssh_hostname>"
autossh="<path_to_autossh>"
# I configure these:
prog="ssh_lifeline"
exec=$(basename $autossh)
options="-M 0 -f -T -N ${ssh_hostname}"
pidfile=${PIDFILE:-/var/run/${prog}}
lockfile=${LOCKFILE:-/var/run/${prog}}
# TEAMWORK MAKES THE DREAM WORK!

# AUTOSSH_GATETIME
# How long ssh must be up before we consider it a successful connection.
# Default is 30 seconds. If set to 0, then this behaviour is disabled,
# and as well, autossh will retry even on failure of first attempt to
# run ssh.
export AUTOSSH_GATETIME=0

start() {
    echo -n $"Starting $prog: "
    daemon --pidfile=${pidfile} ${autossh} ${options}
    retval=$?
    echo
    [ $retval = 0 ] && touch ${lockfile}
    return $retval
}

stop() {
    echo -n $"Stopping $prog: "
    killproc $exec
    retval=$?
    echo
    [ $retval -eq 0 ] && rm -f ${lockfile}
    return $retval
}

restart() {
    stop
    start
}

case "$1" in
    start|stop|restart)
       $1
       ;;
    status)
       status $exec
       ;;
    *)
       echo "Usage: $0 {start|stop|status|restart}"
       exit 2
esac

exit 0

