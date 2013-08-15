#!/bin/sh

### BEGIN INIT INFO
# Provides:		rk903-bluetooth
# Required-Start:	$remote_fs
# Required-Stop:	$remote_fs
# Should-Start:	
# Should-Stop:
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	RK903 bluetooth support
# Description:		Starts brcm_patchram_plus daemon needed by RK903
#           chip for bluetooth.
### END INIT INFO

PATH=/sbin:/bin:/usr/sbin:/usr/bin
DAEMON_SBIN=/usr/sbin/brcm_patchram_plus
DAEMON_DEFS=/etc/default/rk903-bluetooth
PATCHRAM=
NAME=rk903-bluetooth
DESC="bluetooth support"

[ -x "$DAEMON_SBIN" ] || exit 0
[ -s "$DAEMON_DEFS" ] && . $DAEMON_DEFS
[ "$(cat /sys/class/rfkill/rfkill0/type)" = bluetooth ] || exit 0

[ -z "$PATCHRAM" ] && PATCHRAM="/etc/bluetooth/$(cat /sys/class/rfkill/rfkill0/name).hcd"
DAEMON_OPTS="--patchram $PATCHRAM --no2bytes --tosleep 50000 --baudrate 1500000 --enable_lpm --enable_hci /dev/ttyS0"

. /lib/lsb/init-functions

do_start()
{
	log_daemon_msg "Starting $DESC" "$NAME"
    if [ -f "$PATCHRAM" ]; then
        echo 0 >/sys/class/rfkill/rfkill0/soft
        sleep 1
        start-stop-daemon --start --oknodo --background --exec "$DAEMON_SBIN" \
            -- $DAEMON_OPTS >/dev/null
        log_end_msg "$?"
    else
        log_failure_msg "Missing patchram file $PATCHRAM"
    fi
}

do_stop()
{
	log_daemon_msg "Stopping $DESC" "$NAME"
	start-stop-daemon --stop --oknodo --exec "$DAEMON_SBIN"
	echo 1 >/sys/class/rfkill/rfkill0/soft
	log_end_msg "$?"
}

case "$1" in
  start)
    do_start
	;;
  stop)
    do_stop
	;;
  restart)
  	do_stop
	sleep 1
	do_start
	;;
  status)
	status_of_proc "$DAEMON_SBIN" "$NAME"
	exit $?
	;;
  *)
	N=/etc/init.d/$NAME
	echo "Usage: $N {start|stop|restart|status}" >&2
	exit 1
	;;
esac

exit 0
