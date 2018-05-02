# Ragnar-esque
A project that build and deploy's kernels on various HWs.

### Setup symlinks
```
$ ./install.sh
```

Setup the artifact dir. if not creating an .ragnar.rc file
the artifact dir will be in ${HOME}/ragnar-artifacts
```
$ echo 'TOP="${HOME}/src/kernel"' > ${HOME}/.ragnar.rc
```

### Supported HWs today:

 - hikey
 - am57xx-evm
 - dragonboard-410c (build)

### pre-req clone linux kernel.
example:
```
$ mkdir kernel/
$ git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
$ cd linux
$ git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
$ git remote add stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
$ git remote update
$ cd ..
$ /usr/share/doc/git/contrib/workdir/git-new-workdir ~/bin/
$ chmod +x ~/bin/git-new-workdir
$ git-new-workdir linux stable-4.14
$ cd stable-4.14
$ git checkout -b linux-4.14.y stable/linux-4.14.y
```

### Building with build-kernel
example:

```
$ cd <path>/kernel/linux-4.14
$ build-kernel -k linux-stable-4.14 -m hikey

find the name from the k flag here:
http://snapshots.linaro.org/openembedded/lkft/morty/hikey/rpb/
the m flag are from:
http://snapshots.linaro.org/openembedded/lkft/morty/
```

### Deploy with deploy-kernel
example:

```
$ deploy-kernel -i <ip> -m hikey
```
