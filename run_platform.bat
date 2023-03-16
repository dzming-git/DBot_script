@echo off
set PYTHON_PATH="Z:\dbot_env\python.exe"

start "" /D "Y:\DBot\DBot_platform" cmd /K "title DBot_platform & %PYTHON_PATH% -m app.server"