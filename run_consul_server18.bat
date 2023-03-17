@echo off

start  cmd /K "title consul & consul agent -config-file=consul_config/server18.json"
