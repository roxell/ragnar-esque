# setup symlinks
$ ./install.sh

# Supported HWs today:

 - hikey
 - am57xx-evm

# pre-req clone linux kernel.
example:
$ mkdir kernel/
$ git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
$ cd linux
$ git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
$ git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
$ git remote update
$ cd ..
$ git-new-workdir linux stable-4.14
$ cd stable-4.14
$ git checkout -b linux-4.14.y stable/linux-4.14.y

# Building with build-kernel
example:

$ cd <path>/kernel/linux-4.14
$ build-kernel -k linux-stable-4.14 -m hikey

find the name from the k flag here:
http://snapshots.linaro.org/openembedded/lkft/morty/hikey/rpb/
the m flag are from:
http://snapshots.linaro.org/openembedded/lkft/morty/

# Deploy with deploy-kernel
example:

$ cd <path>/kernel
$ deploy-kernel -i <ip> -m hikey
