#!/bin/sh

cd ~/.ros/log

latest=$(basename $(readlink latest))

#get list of directories except latest log directory
list_dir=$(ls */ -d | grep -v "${latest}\|latest")

#compress directories except latest log
if [ "${list_dir}" ]; then
	tar -zcvf log.tar.gz $list_dir
	rm $list_dir -R
fi

/usr/sbin/logrotate -f /etc/logrotate.d/roslog_directories
