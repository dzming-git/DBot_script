@echo off
set PYTHON_PATH="Z:\dbot_env\python.exe"
set DIR1="Y:\DBot\DBot_SDK\example\DBot_SDK"
set DIR2="Y:\DBot\DBot_platform\DBot_SDK"

start "" /D "sync_update" cmd /K "title sync_update & %PYTHON_PATH% main.py %DIR1% %DIR2%"