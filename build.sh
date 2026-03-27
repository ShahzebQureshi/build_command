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
rm -rf hardware/oneplus
rm -rf vendor/infinity-priv/keys
rm -rf vendor/qcom/opensource/core-utils
rm -rf device/qcom/common
rm -rf vendor/qcom/common
rm -rf packages/apps/KProfiles
rm -rf hardware/qcom/display
rm -rf hardware/qcom/media
rm -rf hardware/qcom/audio
rm -rf device/qcom/sepolicy_vndr

# Clone sources
git clone https://github.com/ShahzebQureshi/device_oneplus_guacamole -b sixteen-infinity device/oneplus/guacamole --depth=1
git clone https://github.com/ShahzebQureshi/device_oneplus_sm8150-common -b sixteen device/oneplus/sm8150-common --depth=1
git clone https://github.com/yaap/kernel_oneplus_sm8150 -b sixteen kernel/oneplus/sm8150 --depth=1
git clone https://github.com/yaap/vendor_oneplus_guacamole -b sixteen vendor/oneplus/guacamole --depth=1
git clone https://github.com/yaap/vendor_oneplus_sm8150-common -b sixteen vendor/oneplus/sm8150-common --depth=1
git clone https://github.com/ShahzebQureshi/ak vendor/lineage-priv/keys --depth=1
git clone https://github.com/yaap/vendor_qcom_opensource_core-utils -b sixteen vendor/qcom/opensource/core-utils --depth=1
git clone https://github.com/yaap/device_qcom_common -b sixteen device/qcom/common --depth=1
git clone https://gitlab.com/yaosp/vendor_qcom_common -b sixteen vendor/qcom/common --depth=1
git clone https://github.com/yaap/packages_apps_KProfiles -b sixteen packages/apps/KProfiles --depth=1
git clone https://github.com/yaap/hardware_qcom-caf_sm8150_display -b sixteen hardware/qcom/display --depth=1
git clone https://github.com/yaap/hardware_qcom-caf_sm8150_media -b sixteen hardware/qcom/media --depth=1
git clone https://github.com/yaap/hardware_qcom-caf_sm8150_audio -b sixteen hardware/qcom/audio --depth=1
git clone https://github.com/yaap/device_qcom_common -b sixteen device/qcom/common --depth=1
git clone https://gitlab.com/yaosp/vendor_qcom_common -b sixteen vendor/qcom/common --depth=1

git clone https://github.com/LineageOS/android_device_qcom_sepolicy_vndr -b lineage-23.2-legacy-um device/qcom/sepolicy_vndr --depth=1
# Clone hardware LAST
git clone https://github.com/LineageOS/android_hardware_oneplus hardware/oneplus --depth=1


# Set up build environment
export BUILD_USERNAME=ShahzebQureshi
export BUILD_HOSTNAME=Linux
export TZ="Asia/Karachi"


# Build
export TARGET_INIT_VENDOR_LIB=""
export TARGET_SURFACEFLINGER_UDFPS_LIB=""
. build/envsetup.sh
export SKIP_ABI_CHECKS=true
lunch infinity_guacamole-userdebug
m bacon
