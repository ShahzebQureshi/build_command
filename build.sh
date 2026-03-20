#!/bin/bash
rm -rf .repo/local_manifests
repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault

# Clone hardware BEFORE resync 
rm -rf hardware/oneplus
git clone https://github.com/yaap/hardware_oneplus -b sixteen hardware/oneplus --depth=1

/opt/crave/resync.sh

# Clean old dirs
rm -rf out/target/product/guacamole
rm -rf device/oneplus/guacamole
rm -rf device/oneplus/sm8150-common
rm -rf kernel/oneplus/sm8150
rm -rf vendor/oneplus/guacamole
rm -rf vendor/oneplus/sm8150-common

# Clone sources
git clone https://github.com/ShahzebQureshi/device_oneplus_guacamole -b sixteen-infinity device/oneplus/guacamole --depth=1
git clone https://github.com/yaap/device_oneplus_sm8150-common -b sixteen device/oneplus/sm8150-common --depth=1
git clone https://github.com/yaap/kernel_oneplus_sm8150 -b sixteen kernel/oneplus/sm8150 --depth=1
git clone https://github.com/yaap/vendor_oneplus_guacamole -b sixteen vendor/oneplus/guacamole --depth=1
git clone https://github.com/yaap/vendor_oneplus_sm8150-common -b sixteen vendor/oneplus/sm8150-common --depth=1
git clone https://github.com/shahzebqureshi/ak vendor/infinity-priv/keys --depth=1

# Build
. build/envsetup.sh
export SKIP_ABI_CHECKS=true
export TARGET_SURFACEFLINGER_UDFPS_LIB=""
make installclean
lunch infinity_guacamole-bp4a-userdebug
m bacon
