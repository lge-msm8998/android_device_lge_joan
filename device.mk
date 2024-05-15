#
# Copyright (C) 2018-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/lge/joan

$(call inherit-product,device/lge/msm8998-common/msm8998-common.mk)

PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH) \
    hardware/lge

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(DEVICE_PATH)/overlay \
    $(DEVICE_PATH)/overlay-lineage

PRODUCT_ENFORCE_RRO_TARGETS := *
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(DEVICE_PATH)/overlay-lineage/lineage-sdk

# APN
PRODUCT_PACKAGES += \
    apns-conf.xml

# Audio
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/audio/audio_output_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_output_policy.conf \
    $(DEVICE_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(DEVICE_PATH)/audio/mixer_paths_tavil.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_tavil.xml \

# Boot animation
TARGET_SCREEN_HEIGHT := 2880
TARGET_SCREEN_WIDTH := 1440

# Camera
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/camera/camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/camera_config.xml \
    $(DEVICE_PATH)/configs/camera/hi553_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/hi553_chromatix.xml \
    $(DEVICE_PATH)/configs/camera/imx351_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx351_chromatix.xml \
    $(DEVICE_PATH)/configs/camera/s5k3m3_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/s5k3m3_chromatix.xml

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1 \
    android.hardware.biometrics.fingerprint@2.1.vendor \
    vendor.lge.hardware.biometrics.fingerprint@2.1.vendor

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service

# HDR
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/hdr_tm_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/hdr_tm_config.xml

# Init
PRODUCT_PACKAGES += \
    fstab.qcom

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# Media
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/media/media_profiles_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_vendor.xml

# Releasetools
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/releasetools/device_check.sh:install/bin/device_check.sh

# Sensors
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/sensors/sensor_def_common.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/sensor_def_common.conf \
    $(DEVICE_PATH)/configs/sensors/sensor_def_joan_global_com.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/sensor_def_variable.conf

# Shipping API Level
PRODUCT_SHIPPING_API_LEVEL := 25

# Inherit proprietary blobs
$(call inherit-product, vendor/lge/joan/joan-vendor.mk)
