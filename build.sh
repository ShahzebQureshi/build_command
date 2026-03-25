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
rm -rf device/qcom/qssi
rm -rf packages/apps/KProfiles

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
git clone https://github.com/AOSPA/android_device_qcom_qssi -b vauxite device/qcom/qssi --depth=1
git clone https://github.com/yaap/packages_apps_KProfiles -b sixteen packages/apps/KProfiles --depth=1
# Clone hardware LAST
git clone https://github.com/LineageOS/android_hardware_oneplus -b lineage-23.2 hardware/oneplus --depth=1

# Build
export TARGET_INIT_VENDOR_LIB=""
export TARGET_SURFACEFLINGER_UDFPS_LIB=""
. build/envsetup.sh
export SKIP_ABI_CHECKS=true
lunch infinity_guacamole-userdebug
m bacon
