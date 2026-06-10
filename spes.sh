#!/bin/bash
rm -rf .repo/local_manifests
repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault
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
git clone https://github.com/ShahzebQureshi/android_device_xiaomi_spes -b infinity device/xiaomi/spes --depth=1
git clone https://github.com/muralivijay/vendor_xiaomi_spes -b 16-QPR2 vendor/xiaomi/spes --depth=1
git clone https://github.com/muralivijay/kernel_xiaomi_spes -b main-a16-sm8250-base kernel/xiaomi/sm6225 --depth=1
#git clone https://github.com/GustavoMends/vendor_GoogleCamera -b sg vendor/GoogleCamera --depth=1
git clone https://github.com/ShahzebQureshi/ak vendor/infinity-priv/keys --depth=1


# Remove pixel headers to avoid conflicts
rm -rf hardware/google/pixel/kernel_headers/Android.bp

# Remove hardware/lineage/compat to avoid conflicts
rm -rf hardware/lineage/compat/Android.bp

rm -rf device/xiaomi/spes/vendorsetup.sh

# Hardware/Xiaomi
rm -fr hardware/xiaomi
git clone https://github.com/LineageOS/android_hardware_xiaomi hardware/xiaomi
rm -fr hardware/lineage/interfaces/health/aidl/default/Android.bp
rm -fr hardware/xiaomi/interfaces/xiaomi/hardware/mtdservice/1.3
rm -fr hardware/xiaomi/interfaces/xiaomi/hardware/mfidoca/1.0

# HALS
rm -rf hardware/qcom-caf/sm8250/audio
git clone https://github.com/muralivijay/android_hardware_qcom_audio.git -b lineage-23.2-caf-sm8250 hardware/qcom-caf/sm8250/audio

rm -rf hardware/qcom-caf/sm8250/display
git clone https://github.com/muralivijay/android_hardware_qcom_display.git -b lineage-23.2-caf-sm8250 hardware/qcom-caf/sm8250/display

# Debug Tools
git clone https://github.com/Roynas-Android-Playground/hardware_samsung-extra_interfaces hardware/samsung-ext/interfaces

# Sepolicy fix for imsrcsd
rm -rf device/qcom/sepolicy_vndr/legacy-um/qva/vendor/bengal/ims/imsservice.te
cp device/qcom/sepolicy_vndr/legacy-um/qva/vendor/bengal/legacy-ims/hal_rcsservice.te device/qcom/sepolicy_vndr/legacy-um/qva/vendor/bengal/ims/hal_rcsservice.te

# Rename conflicting qti_kernel_headers in source
sed -i 's/"qti_kernel_headers"/"qti_kernel_headers_old"/g' vendor/lineage/build/soong/Android.bp

# Set up build environment
export BUILD_USERNAME=ShahzebQureshi
export BUILD_HOSTNAME=Linux
export TZ="Asia/Karachi"

# Build
export TARGET_INIT_VENDOR_LIB=""
. build/envsetup.sh
export SKIP_ABI_CHECKS=true
lunch infinity_spes-userdebug
m bacon
