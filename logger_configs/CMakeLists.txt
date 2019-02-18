cmake_minimum_required(VERSION 2.8.3)
project(logger_configs)

catkin_package()
execute_process(
  COMMAND "sudo" "sh" "install.sh"
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
