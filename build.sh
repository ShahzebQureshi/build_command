#!/bin/bash
rm -rf .repo/local_manifests
repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault
/opt/crave/resync.sh

# Clean old dirs
rm -rf out/target/product/guacamole
rm -rf device/oneplus/guacamole
rm -rf device/oneplus/sm8150-common
rm -rf kernel/oneplus/sm8150
rm -rf vendor/oneplus/guacamole
rm -rf vendor/oneplus/sm8150-common
rm -rf hardware/oplus

# Clone sources
git clone https://github.com/ShahzebQureshi/device_oneplus_guacamole-Evox -b Infinity device/oneplus/guacamole --depth=1
git clone https://github.com/QuinceROMs/device_oneplus_sm8150-common-1 -b 16-d-cam device/oneplus/sm8150-common --depth=1
git clone https://github.com/QuinceROMs/android_kernel_oneplus_sm8150 -b 16-c kernel/oneplus/sm8150 --depth=1
git clone https://github.com/ShahzebQureshi/proprietary_vendor_oneplus_guacamole -b Infinity vendor/oneplus/guacamole --depth=1
git clone https://github.com/QuinceROMs/vendor_oneplus_sm8150-common-1 -b 16-d-cam vendor/oneplus/sm8150-common --depth=1

# Clone hardware LAST
git clone https://github.com/QuinceROMs/hardware_oneplus-1 -b 16-cam hardware/oplus --depth=1

# Set up build environment
export BUILD_USERNAME=ShahzebQureshi
export BUILD_HOSTNAME=Linux
export TZ="Asia/Karachi"

# Build
. build/envsetup.sh
export SKIP_ABI_CHECKS=true
lunch infinity_guacamole-userdebug
mka bacon
