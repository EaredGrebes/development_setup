#!/bin/bash

#set -ex

# configuration
python_version=3.8
virtual_env_name=py38_test1
requirements_file="py37_cv_requirements_v1.txt"

# change into the directory of this file
DIR=$(dirname $0)
pushd $DIR

virtualenv_dir=~/.config/virtualenvs/${virtual_env_name}

# If the virtualenv already exists, just update requirements.
if [ -e "$virtualenv_dir" ]; then
    echo "$virtualenv_dir already exists. We'll just update requirements."
else
    # conditionally install python if it doesn't exist
    ./install_python.sh "$python_version"

    # then make virtualenv
    /usr/bin/python${python_version} -m venv "$virtualenv_dir"

    # pip also needs an upgrade, for some requirements (hardcoded version here for now)
    $virtualenv_dir/bin/pip install --upgrade pip
fi

# Now install requirements.
$virtualenv_dir/bin/pip install -r $requirements_file


popd

