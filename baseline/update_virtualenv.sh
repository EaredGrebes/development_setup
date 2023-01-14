#!/bin/bash
set -ex

# change into the directory of this file
DIR=$(dirname $0)
SCRIPT_DIR=$(dirname $(realpath $0))
LIB_DIR=$(realpath $SCRIPT_DIR/../../../../src/Starfish)

pushd $DIR

virtualenv_dir=~/.config/virtualenvs/sf

# Now install requirements.
$virtualenv_dir/bin/pip install -r "$SCRIPT_DIR/requirements_local.txt"
$virtualenv_dir/bin/pip install -r "$LIB_DIR/sflib/sflib/requirements_sflib.txt"

popd

