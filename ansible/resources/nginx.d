#!/bin/sh
# init.d script with LSB support.
### BEGIN INIT INFO
# Provides:          SERVICE_NAME
# Required-Start:    $network $local_fs $remote_fs $syslog 
# Required-Stop:     
# Should-Start:      $named
# Should-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6      
# Short-Description: 
# Description:       
### END INIT INFO
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

SERVICE_NAME="nginx"
PID_PATH_NAME="/var/run/nginx.pid"

start_it() {
	echo "starting $SERVICE_NAME ..."
    if [ ! -f $PID_PATH_NAME ]; then
        /usr/local/sbin/nginx
        ps ax | grep "/usr/local/sbin/nginx" | grep -v "grep" | awk {' print $1 '} > $PID_PATH_NAME
        echo "$SERVICE_NAME started ..."
    else
		PID=$(cat $PID_PATH_NAME);
		if ps -p $PID > /dev/null
		then
			echo "$SERVICE_NAME is already running ..."
		else
            /usr/local/sbin/nginx
            ps ax | grep "/usr/local/sbin/nginx" | grep -v "grep" | awk {' print $1 '} > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
		fi
    fi
}

stop_it() {
	if [ -f $PID_PATH_NAME ]; then
        PID=$(cat $PID_PATH_NAME);
        echo "$SERVICE_NAME stoping ..."
        kill -TERM $PID;
        echo "$SERVICE_NAME stopped ..."
        rm $PID_PATH_NAME
    else
        echo "$SERVICE_NAME is not running ..."
    fi
}


restart_it() {
	if [ -f $PID_PATH_NAME ]; then
        stop_it
		start_it
    else
        echo "$SERVICE_NAME is not running ..."
    fi
}


case "$1" in
  start)
	 start_it            
        ;;
  stop)
	stop_it
        ;;
  restart)
	restart_it
		;;

  *)
        N=/etc/init.d/$NAME
        echo "Usage: $N {start|stop|restart}" >&2
        exit 1
        ;;
esac

exit 0
