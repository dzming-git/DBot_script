@echo off

REM 获取本机IP地址
for /f "tokens=2 delims=:" %%f in ('ipconfig ^| find "IPv4 Address"') do set "IP=%%f"
set "IP=%IP: =%"

echo Starting Consul agent on %IP%...


start  cmd /K "title consul & consul agent -server -bind=%IP% -bootstrap-expect=2 -data-dir=C:\consul-data -ui"
