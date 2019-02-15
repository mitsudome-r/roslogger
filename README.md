# roslogger

## Description
This allows you to rotate stdout/stderr output of roslaunch.<br>
Note: This only works if output is set to "log" in launch files.

## How to setup
1. Install config files for log rotation<br>
`$ sudo sh roslogger_configs/install.sh`<br>

2. put roslaunch directory in catkin workspace

3. compile by catkin_make

4. Start any launch file (Make sure that all nodes have output="log")
