#!/bin/sh

#setup logrotate configs
sed -e "s/username/${SUDO_USER}/g" roslog  > /etc/logrotate.d/roslog
sed -e "s/username/${SUDO_USER}/g" roslog_directories > /etc/logrotate.d/roslog_directories

#set up cron
crontmpfile="/tmp/crontmp.txt"

crontab -u ${SUDO_USER} -l > ${crontmpfile} 2>/dev/null

f=$(cat ${crontmpfile} | grep '/etc/logrotate.d/roslog')
if [ ${#f} -eq 0 ]; then
	#set cron if not set yet
	echo " * * * * * /usr/sbin/logrotate /etc/logrotate.d/roslog" >> ${crontmpfile}
else
	#update cron if already set
	f=$(echo "$f" | sed 's/\*/\\*/g')
	sed -i -e "s:${f}: * * * * * /usr/sbin/logrotate /etc/logrotate.d/roslog:g" ${crontmpfile}
fi

f=$(cat ${crontmpfile} | grep 'log_script.sh')
if [ ${#f} -eq 0 ]; then
	#set cron if not set yet
	echo " * * * * * sh ~/roslogger/logger_configs/log_script.sh" >> ${crontmpfile}
else
	#update cron if already set
	f=$(echo "$f" | sed 's/\*/\\*/g')
	sed -i -e "s:${f}: * * * * * sh ~/roslogger/logger_configs/log_script.sh:g" ${crontmpfile}
fi

crontab -u ${SUDO_USER} ${crontmpfile} -i
rm ${crontmpfile}
