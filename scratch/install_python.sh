#!/bin/bash

# this script takes an argument for the python version (example 3.7), and 
# conditionally install python 

python_version=$1

tmp=/usr/bin/python$python_version

if [ -f "$tmp" ]; then  
    echo "$tmp already exists"
else
    echo "$tmp does not exist, installing"
    sudo apt install python$python_version
    sudo apt install python$python_version-venv # needed to get pip in the venv
fi
