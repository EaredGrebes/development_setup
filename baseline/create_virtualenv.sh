#!/bin/bash
set -ex

# change into the directory of this file
DIR=$(dirname $0)
SCRIPT_DIR=$(dirname $(realpath $0))
LIB_DIR=$(realpath $SCRIPT_DIR/../../../../src/Starfish)

pushd $DIR

# Basilisk needs py3.7
python_version=3.7

virtualenv_dir=~/.config/virtualenvs/sf

# If the virtualenv already exists, just update requirements.
if [ -e "$virtualenv_dir" ]; then
    echo "$virtualenv_dir already exists. We'll just update requirements."
else

    # check distro and use right python exe to make virtualenv
    uname_out=$(uname -a)
    if [[ $uname_out == *"Linux"* ]]; then
        # install system packages first
        ./install_packages.sh "$python_version"
        # then make virtualenv
        /usr/bin/python${python_version} -m venv "$virtualenv_dir"
    elif [[ $uname_out == *"Darwin"* ]]; then
        # /Library/Frameworks/Python.framework/Versions/$python_version/bin/python$python_version -m venv "$virtualenv_dir"
        the_python=$(which python$python_version)
        $the_python -m venv "$virtualenv_dir"
    # todo: add winblows support :)
    else
        echo "$uname_out not supported"
        exit
    fi

    # pip also needs an upgrade, for some requirements (hardcoded version here for now)
    $virtualenv_dir/bin/pip install --upgrade pip
fi

# Now install requirements.
$virtualenv_dir/bin/pip install -r "$SCRIPT_DIR/requirements_local.txt"
$virtualenv_dir/bin/pip install -r "$LIB_DIR/sflib/sflib/requirements_sflib.txt"

popd

