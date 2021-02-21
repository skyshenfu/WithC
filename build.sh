#!/bin/bash
#NDK 配置
NDK_ROOT=/Users/zty/Library/Android/sdk/ndk/21.3.6528147
#TOOLCHAIN
TOOLCHAIN=$NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
#支持的CPU
CPU=arm-linux-androideabi
#NDK环境设置
ADDI_LDFLAGS="-fPIE -pie"
ADDI_CFLAGS="-fPIE -pie -march=armv7-a -mfloat-abi=softfp -mfpu=neon"


#配置文件的生成目录
./configure \
--prefix=`pwd`/android/armeabi-v7 \
#生成文件尽可能小
--enable-small \
#不直接使用ffmpeg可执行文件 而是通过程序调用
--disable-programs \
#无用的摄像头驱动（Android的不行）
--disable-avdevice \
#后期处理模块
--disable-postproc \
#关闭编码
--disable-encoders \
#关闭封装音视频
--disable-muxers \
#允许交叉编译
--enable-cross-compile \
#使用对应CPU
--cross-prefix=$TOOLCHAIN/bin/$CPU- \
#指定使用这个目录下usr 里面的头文件和库
--sysroot=$NDK_ROOT/platforms/android-21/arch-arm \

--extra-cflags="$ADDI_CFLAGS" \

--extra-ldflags="$ADDI_LDFLAGS" \

--arch=arm \
--target-os=android 

make clean
make -j4 install



