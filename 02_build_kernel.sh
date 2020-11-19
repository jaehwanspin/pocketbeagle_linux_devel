#!/bin/bash

export CC=`pwd`/gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-
cd ti-linux-kernel-dev
bash build_kernel.sh

