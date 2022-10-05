@echo off
:setpasswd
echo SET PASSWORD FOR USER '%USERNAME%'
set /p Input=PASSWD:
if /I "%Input%"=="" goto invalidpassword
goto installation
:invalidpassword
echo INVALID PASSWORD, CAN'T BE BLANK
goto setpasswd
:installation
rem [32m Building Docker container and importing to WSL [0m
docker build --build-arg USER=%USERNAME% --build-arg PASSWD=%Input% -t workspace -f resources\Dockerfile .
docker run --name workspace workspace
docker export --output="workspace.tar.gz" workspace
docker container rm workspace
docker rmi workspace

rem [32m Setting the WSL version to 2 and importing the new distro [0m
wsl --set-default-version 2
wsl --import workspace .\installDir .\workspace.tar.gz
wsl --set-default workspace

rem [32m Cleaning up build files [0m
del workspace.tar.gz
