@echo off

set start_port=5700
set end_port=5710
set APP_NAME="DBot"

:: 添加TCP入站规则
netsh advfirewall firewall add rule name="%APP_NAME%-TCP-In" dir=in action=allow protocol=TCP localport=%start_port%-%end_port%

:: 添加TCP出站规则
netsh advfirewall firewall add rule name="%APP_NAME%-TCP-Out" dir=out action=allow protocol=TCP localport=%start_port%-%end_port%

:: 添加UDP入站规则
netsh advfirewall firewall add rule name="%APP_NAME%-UDP-In" dir=in action=allow protocol=UDP localport=%start_port%-%end_port%

:: 添加UDP出站规则
netsh advfirewall firewall add rule name="%APP_NAME%-UDP-Out" dir=out action=allow protocol=UDP localport=%start_port%-%end_port%

:: 添加TCP入站规则
netsh advfirewall firewall add rule name="Consul-TCP-In" dir=in action=allow protocol=TCP localport=8500

:: 添加TCP出站规则
netsh advfirewall firewall add rule name="Consul-TCP-Out" dir=out action=allow protocol=TCP localport=8500

:: 添加UDP入站规则
netsh advfirewall firewall add rule name="Consul-UDP-In" dir=in action=allow protocol=UDP localport=8500

:: 添加UDP出站规则
netsh advfirewall firewall add rule name="Consul-UDP-Out" dir=out action=allow protocol=UDP localport=8500