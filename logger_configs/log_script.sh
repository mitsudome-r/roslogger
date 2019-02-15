#!/bin/sh

cd ~/.ros/log

latest=$(basename $(readlink latest))

#get list of directories except latest log directory
list_dir=$(ls */ -d | grep -v "${latest}\|latest")

#get size of given directory in MB
size=$(du $list_dir -m | awk '{sum+=$1;}END{print sum}') 

#rotate if size is over 100MB
if [ $size -gt 100 ]; then
	tar -cvf log.tar $list_dir
	rm $list_dir -R
	/usr/sbin/logrotate -f /etc/logrotate.d/roslog_directories
fi
