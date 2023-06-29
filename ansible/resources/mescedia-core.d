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

SERVICE_NAME="mescedia-core"
BASE_DIR="/usr/local/src/mescedia/mescedia-core"
PID_PATH_NAME="/var/run/mescedia-core.pid"

start_it() {
	echo "starting $SERVICE_NAME ..."
    if [ ! -f $PID_PATH_NAME ]; then
        /bin/bash -c "cd $BASE_DIR && mvn camel:run" >> /dev/null 2>&1 &
        echo $! > $PID_PATH_NAME
        echo "$SERVICE_NAME started ..."
    else
		PID=$(cat $PID_PATH_NAME);
		if ps -p $PID > /dev/null
		then
			echo "$SERVICE_NAME is already running ..."
		else
            /bin/bash -c "cd $BASE_DIR && mvn camel:run" >> /dev/null 2>&1 &
            echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
		fi
    fi
}

stop_it() {
	if [ -f $PID_PATH_NAME ]; then
        PID=$(cat $PID_PATH_NAME);
        echo "$SERVICE_NAME stoping ..."
        kill $PID;
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
