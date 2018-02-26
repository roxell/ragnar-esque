#!/bin/bash

TOOLCHAIN_RELEASE="${TOOLCHAIN_RELEASE:-2017.11-rc1}"
exact_toolchain_version="7.2-${TOOLCHAIN_RELEASE}"
exact_toolchain_version_filename="7.2.1-${TOOLCHAIN_RELEASE}"
toolchain_base_url="http://snapshots.linaro.org/components/toolchain/binaries"
ARCH=arm64

usage()
{
    echo -e "\ta, ARCH, default: ${ARCH}"
    echo -e "\tr, TOOLCHAIN_RELEASE: set toolchain release, default: ${TOOLCHAIN_RELEASE}"
    echo -e "\t\t\t   Only used when ARCH is given!"
    echo -e "\t\t\t   Linaros toolchain releases are located here:"
    echo -e "\t\t\t   ${toolchain_base_url}/${exact_toolchain_version}/"
}

find_toolchain_to_download()
{
    toolchain_url="${toolchain_base_url}/${exact_toolchain_version}/arm-linux-gnueabihf/gcc-linaro-${exact_toolchain_version_filename}-x86_64_arm-linux-gnueabihf.tar.xz"
    [[ ${ARCH} == "arm64" ]] && toolchain_url="${toolchain_base_url}/${exact_toolchain_version}/aarch64-linux-gnu/gcc-linaro-${exact_toolchain_version_filename}-x86_64_aarch64-linux-gnu.tar.xz"
    echo $toolchain_url
    export tcbindir="${tcbindir:-$HOME/$ARCH-tc-${TOOLCHAIN_RELEASE}/bin}"
    mkdir -p $(dirname ${tcbindir})
}

install_custom_toolchain()
{
    test -d ${tcbindir} && return 0
    test -z "${toolchain_url}" && return 0
    toolchain=`basename ${toolchain_url}`
    test -f ${toolchain} || curl -sSOL ${toolchain_url}
    mkdir -p `dirname ${tcbindir}`
    unxz ${toolchain}
    toolchain=${toolchain%.xz}
    tar --strip-components=1 -C `dirname ${tcbindir}` -xf ${toolchain}
    if [[ $? -ne 0 ]]; then
        echo "NO toolchain to extract..."
        exit 1
    fi
}

setup_compiler_prefix()
{
    export PATH="${tcbindir}:$PATH"
    if [ "${ARCH}" = "arm" ]; then
      compiler_prefix="arm-linux-gnueabihf"
    elif [ "$ARCH" = "arm64" ]; then
      compiler_prefix="aarch64-linux-gnu"
    fi

    [[ -n ${compiler_prefix} ]] && export CROSS_COMPILE=${compiler_prefix}-
}

toolchain_prepare()
{
    [[ -z ${ARCH} ]] && return
    [[ ${ARCH} == "x86_32" ]] && return

    find_toolchain_to_download
    install_custom_toolchain
    setup_compiler_prefix
    [[ -n ${compiler_prefix} ]] && export CROSS_HOST="--host=${compiler_prefix}"
}

tc_cleanup(){
        rm -rf ${ROOT_DIR}/gcc-linaro-*
}

while getopts "a:r:h" arg; do
    case $arg in
        a)
            ARCH="$OPTARG"
            ;;
        r)
            TOOLCHAIN_RELEASE="$OPTARG"
            ;;
        h)
            usage
            exit 0
            ;;
    esac
done

toolchain_prepare

## vim: set ft=sh sw=4 sts=4 et foldmethod=syntax : ##
