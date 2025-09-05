#
# Copyright (C) 2022 The TWRP Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Configure base.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Configure core_64_bit.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Configure launch_with_vendor_ramdisk.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Configure emulated_storage.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Configure twrp config common.mk
$(call inherit-product, vendor/twrp/config/common.mk)

# Device specific configs
$(call inherit-product, device/xiaomi/rubens/device.mk)

# HyperOS 2.0.5 specific configs
$(call inherit-product, device/xiaomi/rubens/hyperos_config.mk)

# Device identifier
PRODUCT_DEVICE := rubens
PRODUCT_NAME := twrp_rubens
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := 22041211AC
PRODUCT_MANUFACTURER := Xiaomi

# Build info for HyperOS 2.0.5
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=rubens \
    PRIVATE_BUILD_DESC="rubens-user 14 UKQ1.230804.001 V14.0.5.0.UGBCNXM release-keys"

BUILD_FINGERPRINT := Redmi/rubens/rubens:14/UKQ1.230804.001/V14.0.5.0.UGBCNXM:user/release-keys

# Hide Reflash TWRP
PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.vendor_boot=true \
    ro.build.version.release=14 \
    ro.build.version.sdk=34
