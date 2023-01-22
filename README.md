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
https://developer.nvidia.com/cuda-11-4-2-download-archive?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=runfile_local

``` $ sudo sh cuda_12.0.0_525.60.13_linux.run ```

add this to .bashrc:
```
export PATH=/usr/local/cuda-11.4/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-11.4/lib64:$LD_LIBRARY_PATH
```

cudnn:
download tar:
https://developer.nvidia.com/rdp/cudnn-download

```
$ tar -xzvf cudnn-11.4-linux-x64-v8.2.4.15.tgz
$ sudo cp cuda/include/cudnn*.h /usr/local/cuda/include
$ sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
$ sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
```

some dependencies for cuda opengl examples:
```
sudo apt-get install freeglut3 freeglut3-dev
```

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

check for existing ssh keys (should only have 1):
```
$ ls -al ~/.ssh
```

add key to machine want to login to:
```
$ ssh-copy-id bilbo@10.42.0.1
```

nfs on host:

show drives: ```lsblk```

first mount drive
```
$ sudo mount /dev/nvme0n1p1 /mnt/cp3_1
$ sudo mount /dev/sdb1 /mnt/ssd1
```

to unmount
```
$ sudo umount /dev/nvme0n1p1
```

to mount at boot:
```
$ cd ~
$   sudo nano /etc/fstab
```

add lines:
```
/dev/nvme0n1p1 /mnt/cp3_1  ext4 defaults 0 0
/dev/sdb1 /mnt/ssd1 ext4 defaults 0 0

```
install and start nfs
```
$ sudo apt install nfs-kernel-server
$ sudo systemctl start nfs-kernel-server.service
```

to check or restart nfs server on host machine:
```
$ sudo systemctl status nfs-kernel-server
$ sudo systemctl restart nfs-kernel-server
```
to set nfs to autostart on boot:
```
$ update-rc.d nfs-kernel-server enable
```
add nfs mounts
```
$ sudo nano /etc/exports
```
add these lines:
```
/mnt/cp5_2tb 10.42.0.142/24(rw,sync,no_subtree_check)
/mnt/ssd1 10.42.0.142/24(rw,sync,no_subtree_check)
```



apply changes to the file
```
$ sudo exportfs -a
```

nfs on client:
```
$ sudo apt install nfs-common
$ sudo mkdir /mnt/cp3_1 
$ sudo mount 10.42.0.1:/mnt/cp3_1 /mnt/cp3_1
```
to mount nfs on boot, add these lines to ```/etc/fstab```

```
10.42.0.1:/mnt/cp3_1 /mnt/cp3_1 nfs rsize=8192,wsize=8192,timeo=14,intr
10.42.0.1:/mnt/ssd1 /mnt/ssd1 nfs rsize=8192,wsize=8192,timeo=14,intr
```

## python environments with virtualenv

install pip and virtualenv
```
$ sudo apt update
$ sudo apt install python3-pip
$ pip install virtualenv
```
install other python versions from source (required for installing python libraries required for opencv)

download: https://www.python.org/downloads/

```
$ sudo tar xzf Python-3.9.16.tgz
$ cd Python-3.9.16
$ sudo ./configure --enable-optimizations
$ sudo make install
```
don't forget to restore any missing sim links
```
$ sudo ln -sf /usr/bin/python3.8 /usr/bin/python3
$ sudo ln -sf /usr/bin/python3.8 /usr/bin/python
```

use script to generate a python virtual environment
```
$ ./development_setup/scratch/create_virtualenv.sh
```
add alias to .bashrc
```alias my_env='source ~/.config/virtualenvs/*env_name*/bin/activate'```

## pytorch

current release: https://pytorch.org/
```
pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116
```
```
python test/torch_test.py
```

## open3d

```
$ pip install -U pip>=20.3
$ pip install open3d==0.16.0
```

## cupy

https://docs.cupy.dev/en/stable/install.html

```
$ python -m pip install -U setuptools pip
$ pip install cupy-cuda114
```
in python:
```
import cupy as cp
a = cp.zeros(10000)
```

## miniconda

https://conda.io/projects/conda/en/stable/user-guide/install/linux.html

download:
https://docs.conda.io/en/latest/miniconda.html#linux-installers

don't run conda init
```
$ bash Miniconda3-py38_22.11.1-1-Linux-x86_64.sh
$ eval "$(/home/bilbo/miniconda3/bin/conda shell.bash hook)"
$ conda update conda
$ conda install spyder=5.3.3
```

## Eigen
```
$ sudo apt install libeigen3-dev
```

## opencv

https://pyimagesearch.com/2018/08/15/how-to-install-opencv-4-on-ubuntu/


```
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo apt-get install build-essential cmake unzip pkg-config
$ sudo apt-get install libjpeg-dev libpng-dev libtiff-dev
$ sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
$ sudo apt-get install libxvidcore-dev libx264-dev
$ sudo apt-get install libgtk-3-dev
$ sudo apt-get install libatlas-base-dev gfortran
$ sudo apt-get install python3-dev
```

optional:

```
$ sudo apt-get install libfreeimage3 libfreeimage-dev
$ sudo apt-get install -y libhdf5-dev
$ sudo apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
$ sudo apt-get install libglfw3
$ sudo apt-get install libglfw3-dev
$ sudo apt-get install libglew-dev
$ sudo apt-get install libglm-dev
```
maybe not necessary
```$ sudo apt-get install libboost-all-dev```

sticking with 4.5.2 for now, clone these repos:
https://github.com/opencv/opencv/tree/4.5.2
https://github.com/opencv/opencv_contrib/tree/4.5.2

```
$ mkdir build
$ cd build
```
run from build directory:

```
cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_CXX_STANDARD=17 \
-D CMAKE_INSTALL_PREFIX=/usr/lcoal \
-D WITH_TBB=ON \
-D BUILD_TIFF=ON \
-D ENABLE_FAST_MATH=1 \
-D CUDA_FAST_MATH=1 \
-D WITH_CUBLAS=1 \
-D WITH_CUDA=ON \
-D WITH_CUDNN=ON \
-D OPENCV_DNN_CUDA=OFF \
-D WITH_V4L=ON \
-D WITH_QT=OFF \
-D WITH_OPENGL=ON \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D BUILD_NEW_PYTHON_SUPPORT=ON \
-D HAVE_opencv_python3=ON \
-D BUILD_opencv_python3=ON \
-D PYTHON_EXECUTABLE=$(which python3) \
-D OPENCV_PYTHON3_INSTALL_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
-D OPENCV_ENABLE_NONFREE=ON \
-D BUILD_EXAMPLES=ON ..
```
```
$ make -j8
$ sudo make install
$ sudo ldconfig
```

maybe have to do some sym link stuff






