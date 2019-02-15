#!/bin/sh

#setup logrotate configs
sed -e "s/username/${SUDO_USER}/g" roslog  > /tmp/roslog
sed -e "s/username/${SUDO_USER}/g" roslog_directories > /tmp/roslog_directories
cp /tmp/roslog /etc/logrotate.d/roslog
cp /tmp/roslog_directories /etc/logrotate.d/roslog_directories
rm /tmp/roslog /tmp/roslog_directories

#set up cron
crontmpfile="/tmp/crontmp.txt"
sed_tmp="/tmp/sed_tmp.txt"

crontab -l > ${crontmpfile}

f=$(cat ${crontmpfile} | grep '/etc/logrotate.d/roslog')
if [ ${#f} -eq 0 ]; then
	#set cron if not set yet
	echo " * * * * * /usr/sbin/logrotate /etc/logrotate.d/roslog" >> ${crontmpfile}
else
	#update cron if already set 
	f=$(echo "$f" | sed 's/\*/\\*/g')
	sed -e "s:${f}: * * * * * /usr/sbin/logrotate /etc/logrotate.d/roslog:g" ${crontmpfile} > ${sed_tmp}
	cp ${sed_tmp} ${crontmpfile}
fi

f=$(cat ${crontmpfile} | grep 'log_script.sh')
if [ ${#f} -eq 0 ]; then
	#set cron if not set yet
	echo " 0 0 * * * sh ~/roslogger/logger_configs/log_script.sh" >> ${crontmpfile}
else
	#update cron if already set 
	f=$(echo "$f" | sed 's/\*/\\*/g')	
	sed -e "s:${f}: * * * * * sh ~/roslogger/logger_configs/log_script.sh:g" ${crontmpfile}  > ${sed_tmp}
	cp ${sed_tmp} ${crontmpfile}
fi

crontab -u ${SUDO_USER} ${crontmpfile} -i
rm ${crontmpfile}
rm ${sed_tmp}

