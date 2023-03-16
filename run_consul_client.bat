@echo off

set CONSUL_SERVER_IP="192.168.163.136"

start  cmd /K "title consul & consul agent -join=%CONSUL_SERVER_IP% -data-dir=C:\consul-data -ui"
