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

## virtualbox

good for prototyping dev environments (can't use gpu tho)
https://www.oracle.com/virtualization/technologies/vm/downloads/virtualbox-downloads.html

some dependencies?
```
$ sudo apt-get install libqt5sql5 libqt5help5 libqt5xml5
$ sudo apt install /Downloads/virtualbox-7.0_7.0.4-154605_Ubuntu_focal_amd64.deb
```

