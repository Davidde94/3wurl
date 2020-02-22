#!/bin/bash

# setup the path
PATH="$PATH:/usr/local/bin/swift/usr/bin"

# download the code
git fetch --all
git reset --hard origin/master

# compile and run
swift package resolve
swift build -c release
sudo service banterurl restart
