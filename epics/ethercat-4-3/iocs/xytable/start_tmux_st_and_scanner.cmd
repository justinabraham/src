#! /bin/sh
### BEGIN INIT INFO
# Provides:          startioc
# Required-Start:    ethercat
# Required-Stop:     ethercat
# Default-Start:     3 5
# Default-Stop:      0 1 2 6
# Short-Description: Manager script for epics and ethercat services
# Description:       epics-EtherCat starting script
### END INIT INFO

case "$1" in
  start)
    /etc/init.d/ethercat start
    echo "ethercat started "
    sleep 10
    cd /epics/ethercat-4-3/iocs/lerib_safety
    tmux new -s SCANNER -d ./run &
    echo "scanner started "
    echo "IOC started "
    ;;
  stop)
    tmux kill-session -t SCANNER
    echo "IOC stopped"
    echo "Scanner Stopper"
    ;;
  *)
    echo "Usage: /etc/init.d/startioc {start|stop}"
    exit 1
    ;;
esac

exit 0

