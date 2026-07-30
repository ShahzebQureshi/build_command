#!/bin/bash
rm -rf .repo/local_manifests
repo init --no-repo-verify --git-lfs -u https://github.com/Lunaris-AOSP/android -b 16.2 -g default,-mips,-darwin,-notdefault
/opt/crave/resync.sh

# Clean old dirs
rm -rf out/target/product/merlinx
rm -rf device/xiaomi/merlinx
rm -rf device/xiaomi/mt6768-common
rm -rf kernel/xiaomi/mt6768
rm -rf vendor/xiaomi/merlinx
rm -rf vendor/xiaomi/mt6768-common
rm -rf hardware/oplus
rm -rf hardware/dolby
rm -rf vendor/infinity-priv/keys

# Clone sources
git clone https://github.com/ShahzebQureshi/android_device_xiaomi_merlinx -b luna device/xiaomi/merlinx --depth=1
git clone https://github.com/ShahzebQureshi/android_device_xiaomi_mt6768-common -b luna device/xiaomi/mt6768-common --depth=1
git clone https://github.com/mt6768-dev/android_kernel_xiaomi_mt6768 -b lineage-23.2 kernel/xiaomi/mt6768 --depth=1
git clone https://github.com/mt6768-dev/proprietary_vendor_xiaomi_merlinx -b lineage-23.2 vendor/xiaomi/merlinx --depth=1
git clone https://github.com/mt6768-dev/proprietary_vendor_xiaomi_mt6768-common -b lineage-23.2 vendor/xiaomi/mt6768-common --depth=1
git clone https://github.com/ShahzebQureshi/ak vendor/lineage-priv/keys --depth=1
git clone https://github.com/Pong-Development/hardware_dolby hardware/dolby --depth=1

# Set up build environment
export BUILD_USERNAME=ShahzebQureshi
export BUILD_HOSTNAME=Linux
export TZ="Asia/Karachi"

# Build
. build/envsetup.sh
export SKIP_ABI_CHECKS=true
lunch lineage_merlinx-userdebug
mka bacon
