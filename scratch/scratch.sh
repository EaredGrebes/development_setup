#!/bin/bash

virtual_env_name=sf_cet


virtualenv_dir=~/.config/virtualenvs/${virtual_env_name}
source $virtualenv_dir/bin/activate
echo "loading python virtual env:"
which python
