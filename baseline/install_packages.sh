#!/bin/bash

set -ex

python_version=$1
[ "$python_version" == "" ] && python_version="foo"

# based on https://linuxize.com/post/how-to-install-python-3-7-on-ubuntu-18-04/
# sudo apt update
# sudo apt install software-properties-common
# sudo add-apt-repository ppa:deadsnakes/ppa

sudo apt install python$python_version
sudo apt install python$python_version-venv # needed to get pip in the venv
