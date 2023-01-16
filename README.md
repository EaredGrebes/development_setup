# development_setup
A place to store documentation related to seting up an ubuntu 20.04 development environment.

## git
```
$ sudo apt install git
```

generatings ssh key for github:
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

```
$ ssh-keygen -t ed25519
$ eval "$(ssh-agent -s)"
$ ssh-add ~/.ssh/id_ed25519
```

add ssh key to github:
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account

```
$ cat ~/.ssh/id_ed25519.pub
```

clone repo:
```
$ git clone git@github.com:EaredGrebes/development_setup.git
```

## Nvidia cuda

the most bug-free for ml and ubuntu 2004
```
$ sudo apt install nvidia-driver-470
```

developer toolkit, but select runfile option (UNSELECT DRIVER):
https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04

``` $ sudo sh cuda_12.0.0_525.60.13_linux.run ```

add this to .bashrc:
```
export PATH=/usr/local/cuda-12.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.0/lib64:$LD_LIBRARY_PATH
```
cudnn, just download and run the .deb installer, use email alexs4@uw.edu: https://developer.nvidia.com/rdp/cudnn-download

## virtualbox

good for prototyping dev environments (can't use gpu tho)
https://www.oracle.com/virtualization/technologies/vm/downloads/virtualbox-downloads.html

on guest machine:
```
$ sudo apt install virtualbox-guest-utils
$ sudo adduser [username] vboxsf
```
then add folder in virtualbox gui tool

## ubuntu 20.04

different workspaces:
```
$ sudo apt install gnome-tweaks
$ gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
```

## python environments with virtualenv

install pip and virtualenv
```
$ sudo apt update
$ sudo apt install python3-pip
$ pip install virtualenv
```
use script to generate a python virtual environment
```
$ ./development_setup/scratch/create_virtualenv.sh
```
add alias to .bashrc
```alias my_env='source ~/.config/virtualenvs/*env_name*/bin/activate'```

## pytorch

current release: https://pytorch.org/
```pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116```

in python
```
import torch
torch.cuda.is_available()
torch.cuda.get_device_name(0)

## open3d

```
$ pip install -U pip>=20.3
$ pip install open3d=0.16.0
```

## cupy

```
$ python -m pip install -U setuptools pip
```


## miniconda








