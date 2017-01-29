#!/bin/bash

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")
echo $SCRIPT
echo $SCRIPTPATH

IMAGEBUILDER_DIR=$SCRIPTPATH

#添加SDK到PATH中
SDK_DIR=$SCRIPTPATH/../SDK/staging_dir/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2
echo $SDK_DIR
export PATH=$PATH:$SDK_DIR/bin
export STAGING_DIR=$SDK_DIR
export CFLAGS="-I$STAGING_DIR/usr/include/ -L$STAGING_DIR/usr/lib/"

export CC=mips-openwrt-linux-gcc
export CPP=mips-openwrt-linux-cpp
export GCC=mips-openwrt-linux-gcc
export CXX=mips-openwrt-linux-g++
export RANLIB=mips-openwrt-linux-uclibc-ranlib

###输入参数 build.sh  PROFILE_SUBPROFILE 
###如: build.sh TLWR703_
#TLWR703_8M
#build.sh TLWR703_gfwmini
PROFILE_TARGET=$1
#PROFILE_TARGET=703_8M

#set -f 
PROFILE_NAME=(${PROFILE_TARGET//_/ })

echo $PROFILE_NAME
echo $PROFILE_TARGET

PACKAGES_FN=$PROFILE_TARGET/packages.list

echo $PACKAGES_FN 

#PROFILE_PACKAGES=`grep -v '^#' $PACKAGES_FN`
PROFILE_PACKAGES=`grep -v '^#' $PACKAGES_FN | sed 'H;1h;$!d;x;s/\n/ /g'`

echo $PROFILE_PACKAGES

PROFILE_FILES="$PROFILE_TARGET/files"

echo $PROFILE_FILES


make CC=mipsel-openwrt-linux-gcc LD=mipsel-openwrt-linux-ld  

#echo make image PROFILE=$PROFILE_NAME PACKAGES=\"$PROFILE_PACKAGES\"  FILES=$PROFILE_FILES  
make image PROFILE=$PROFILE_NAME   FILES=\"$PROFILE_FILES\"  PACKAGES="$PROFILE_PACKAGES" 

#rm -rf "$PROFILE_TARGET/bin/*"

#mv bin/* "$PROFILE_TARGET/bin/"

