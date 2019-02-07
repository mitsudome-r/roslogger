# roslogger

## Description
This allows you to rotate stdout/stderr output of roslaunch.<br>
Note: This only works if output is set to "log" in launch files.

## How to setup
1. copy logger_configs/roslog into /etc/logrotate.d/roslog<br>
`$ sudo cp logger_configs/roslog /etc/logrotate.d/roslog`<br>
`$ sudo cp logger_configs/roslog_daily /etc/logrotate.d/roslog_daily`

2. modify user name in roslog and roslog_daily. (change all "mitsudome-r" to your user name )<br>
`sudo vi /etc/logrotate.d/roslog`<br>
`sudo vi /etc/logrotate.d/roslog_daily`

3. setup cron.<br>
`$ crontab -e`
```
 * * * * * /usr/sbin/logrotate /etc/logrotate.d/roslog
 0 0 * * * sh ~/roslogger/logger_configs/log_script.sh
```

4. put roslaunch directory in catkin workspace

5. compile by catkin_make

6. Start any launch file (Make sure that all nodes have output="log")
