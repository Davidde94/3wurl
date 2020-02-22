#!/bin/bash

source ~/.bashrc
git fetch --all
git reset --hard origin/master
swift package resolve
swift build -c release
sudo service banterurl restart
