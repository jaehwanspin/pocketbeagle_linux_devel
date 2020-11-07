#!/bin/bash

# https://www.digikey.com/eewiki/display/linuxonarm/PocketBeagle
echo $1
if [ -z $1 ]
then
    echo "----- arg 1 options -----"
    echo "ti-linux-rt-4.19.y"
    echo "ti-linux-4.19.y"
    echo "ti-linux-rt-5.4.y"
    echo "ti-linux-5.4.y"
    exit 1
fi

# compilers
echo "-------------------------"
echo "----- arm compilers -----"
echo "-------------------------"
wget -c https://releases.linaro.org/components/toolchain/binaries/6.5-2018.12/arm-linux-gnueabihf/gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf.tar.xz
tar xf gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf.tar.xz
export CC=`pwd`/gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-
${CC}gcc --version

# bootloader
echo "----------------------"
echo "----- bootloader -----"
echo "----------------------"
git clone -b v2019.04 https://github.com/u-boot/u-boot --depth=1
cd u-boot/
wget -c https://github.com/eewiki/u-boot-patches/raw/master/v2019.04/0001-am335x_evm-uEnv.txt-bootz-n-fixes.patch
wget -c https://github.com/eewiki/u-boot-patches/raw/master/v2019.04/0002-U-Boot-BeagleBone-Cape-Manager.patch
patch -p1 < 0001-am335x_evm-uEnv.txt-bootz-n-fixes.patch
patch -p1 < 0002-U-Boot-BeagleBone-Cape-Manager.patch
cd ..

# kernel
echo "------------------"
echo "----- kernel -----"
echo "------------------"
git clone https://github.com/RobertCNelson/ti-linux-kernel-dev.git
cd ti-linux-kernel-dev/
git checkout origin/$1 -b tmp
cd ..

# root file system
echo "----------------------------"
echo "----- root file system -----"
echo "----------------------------"
wget -c https://rcn-ee.com/rootfs/eewiki/minfs/debian-10.4-minimal-armhf-2020-05-10.tar.xz
sha256sum debian-10.4-minimal-armhf-2020-05-10.tar.xz
tar xf debian-10.4-minimal-armhf-2020-05-10.tar.xz

# ubuntu 20.04 LTS
echo "----------------------------"
echo "----- ubuntu 20.04 LTS -----"
echo "----------------------------"
wget -c https://rcn-ee.com/rootfs/eewiki/minfs/ubuntu-20.04-minimal-armhf-2020-05-10.tar.xz
sha256sum ubuntu-20.04-minimal-armhf-2020-05-10.tar.xz
tar xf ubuntu-20.04-minimal-armhf-2020-05-10.tar.xz
