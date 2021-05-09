#!/bin/bash
# 搭配ffmpeg 4.4/ 4.2.2/ 3.4.6测试正常
# 修改为你本地NDK目录
export NDK=/Users/zty/Library/Android/sdk/ndk/22.1.7171670
# 当前系统
export HOST_PLATFORM=darwin-x86_64
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_PLATFORM
export SYSROOT=$NDK/toolchains/llvm/prebuilt/$HOST_PLATFORM/sysroot
export API=21

function build_android() {
    echo "Compiling FFmpeg for $CPU"
    ./configure \
	--prefix=$PREFIX \
	--ar=$TOOLCHAIN/bin/${TARGET}-ar \
	--as=$TOOLCHAIN/bin/${TARGET}-as \
	--cc=$TOOLCHAIN/bin/${TARGET_MIN}-clang \
	--cxx=$TOOLCHAIN/bin/${TARGET_MIN}-clang++ \
	--nm=$TOOLCHAIN/bin/${TARGET}-nm \
	--ranlib=$TOOLCHAIN/bin/${TARGET}-ranlib \
	--strip=$TOOLCHAIN/bin/${TARGET}-strip \
	--arch=$ARCH \
	--target-os=android \
	--enable-cross-compile \
	--disable-asm \
	--disable-shared \
	--enable-static \
	--disable-programs \
	--disable-debug \
	--disable-symver \
	--enable-jni \
	--enable-mediacodec \
	--enable-decoder=h264_mediacodec \
	--enable-hwaccel=h264_mediacodec \
    --enable-decoder=hevc_mediacodec \
    --enable-decoder=mpeg4_mediacodec \
    --enable-decoder=vp8_mediacodec \
    --enable-decoder=vp9_mediacodec \
	--enable-small \
	--disable-debug \
	--enable-neon \
	--enable-gpl \
	--enable-version3 \
	--enable-nonfree \
	--disable-avdevice \
	--extra-cflags="-Os -fpic $OPTIMIZE_CFLAGS" \
	--extra-ldflags="$ADDI_LDFLAGS"

    make clean
    make -j8
    make install
    echo "The Compilation of FFmpeg for $CPU is completed"
}

## armv8-a
function armv8() {
    ARCH="arm64"
    CPU="armv8-a"
	TARGET="aarch64-linux-android"
    TARGET_MIN="aarch64-linux-android${API}"
    PREFIX="${PWD}/android/arm64-v8a"
    OPTIMIZE_CFLAGS="-march=$CPU"
    build_android
}

## armv7-a
function armv7() {
    ARCH="arm"
    CPU="armv7-a"
	TARGET="arm-linux-androideabi"
    TARGET_MIN="armv7a-linux-androideabi${API}"
    PREFIX="${PWD}/android/armeabi-v7a"
    OPTIMIZE_CFLAGS="-march=$CPU"
    build_android
}

# 根据自己需要的 cpu, 放开对应的注释即可
armv8
armv7