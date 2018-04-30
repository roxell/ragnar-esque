# Ragnar Bisection

## Design

### Build

- Rebuild kernel (use build-kernel and linaro's docker container)
- Insert kernel into existing OE build output based on machine type

Parameters:
- Kernel git url
- Machine

### Bisection

- LAVA for running tests

Parameters - Everything from 'Build', plus:
- good commit
- bad commit
- lava test case (in some format TBD)


## Image types per board

Below is the list of supported boards and the example files that are passed to
LAVA.

x15:
- userdata: rpb-console-image-am57xx-evm-20180427145356-17.rootfs.img.gz

db410c
- boot: boot--4.16+git0+d804f93aa2-r0-dragonboard-410c-20180427144900-17-17.img
- rootfs: rpb-console-image-dragonboard-410c-20180427144900-17.rootfs.img.gz

hikey-6220
- ptable: ptable-linux-8g.img
- boot: boot-0.0+AUTOINC+06e4def583-fb1158a365-r0-hikey-20180427152124-17.uefi.img
- system: rpb-console-image-hikey-20180427152124-17.rootfs.img.gz

juno:
- dtb: Image--4.16+git0+d804f93aa2-r0-juno-r2-20180427145541-17.dtb
- kernel: Image--4.16+git0+d804f93aa2-r0-juno-20180427145541-17.bin
- nfsrootfs: rpb-console-image-juno-20180427145541-17.rootfs.tar.xz

x86_64
- kernel: bzImage--4.16+git0+d804f93aa2-r0-intel-core2-32-20180427152152-17.bin
- nfsrootfs: rpb-console-image-intel-core2-32-20180427152152-17.rootfs.tar.xz

