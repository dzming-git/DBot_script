@echo off

start cmd /c "run_consul_dev.bat"
start cmd /c "run_cqhttp.bat"

set DIR0="Y:\DBot\DBot_SDK\DBot_SDK"
set DIR1="Y:\DBot\DBot_SDK\example"
set DIR2="Y:\DBot\DBot_platform"

if exist %DIR1%\DBot_SDK (
set /p overwrite="A folder named DBot_SDK already exists in %DIR1%. Do you want to overwrite it? (Y/N)"
if /i "%overwrite%"=="Y" (
rmdir /s /q %DIR1%\DBot_SDK
xcopy /E /I %DIR0% %DIR1%\DBot_SDK
)
) else (
xcopy /E /I %DIR0% %DIR1%\DBot_SDK
)

if exist %DIR2%\DBot_SDK (
set /p overwrite="A folder named DBot_SDK already exists in %DIR2%. Do you want to overwrite it? (Y/N)"
if /i "%overwrite%"=="Y" (
rmdir /s /q %DIR2%\DBot_SDK
xcopy /E /I %DIR0% %DIR2%\DBot_SDK
)
) else (
xcopy /E /I %DIR0% %DIR2%\DBot_SDK
)


start cmd /c "code %DIR1%"
start cmd /c "code %DIR2%"

start cmd /c "sync_update.bat"