#!/bin/bash
rm -rf .repo/local_manifests
repo init --no-repo-verify --git-lfs -u https://github.com/LineageOS/android.git -b tiramisu -g default,-mips,-darwin,-notdefault
/opt/crave/resync.sh

# Clean old dirs
rm -rf out/target/product/spes
rm -rf device/xiaomi/spes
rm -rf vendor/xiaomi/spes
rm -rf kernel/xiaomi/spes
rm -rf vendor/gapps
rm -rf vendor/GoogleCamera
rm -rf hardware/xiaomi
rm -rf vendor/infinity-priv/keys

# Clone sources
git clone https://github.com/ShahzebQureshi/android_device_xiaomi_spes -b Evox device/xiaomi/spes --depth=1
git clone https://github.com/muralivijay/android_vendor_xiaomi_spes -b 13.0 vendor/xiaomi/spes --depth=1
git clone https://github.com/muralivijay/kernel_xiaomi_spes -b main kernel/xiaomi/spes --depth=1
git clone https://gitlab.com/crdroidandroid/android-vendor-gapps-spes -b 13.0 vendor/gapps --depth=1
git clone https://github.com/GustavoMends/vendor_GoogleCamera -b sg vendor/GoogleCamera --depth=1
git clone https://github.com/ShahzebQureshi/ak vendor/infinity-priv/keys --depth=1

# Clone hardware LAST
git clone https://github.com/LineageOS/android_hardware_xiaomi hardware/xiaomi --depth=1

# Set up build environment
export BUILD_USERNAME=ShahzebQureshi
export BUILD_HOSTNAME=Linux
export TZ="Asia/Karachi"

# Build
export TARGET_INIT_VENDOR_LIB=""
. build/envsetup.sh
export SKIP_ABI_CHECKS=true
lunch lineage_spes-userdebug
m evolution
