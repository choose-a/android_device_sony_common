# Copyright (C) 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Common path
COMMON_PATH := device/sony/common

# Sony AOSP Project
SONY_AOSP ?= true

# Common kernel source
TARGET_KERNEL_SOURCE := kernel/sony/msm
TARGET_COMPILE_WITH_MSM_KERNEL := true

# SELinux
BOARD_USE_ENFORCING_SELINUX := true
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Init
TARGET_INIT_VENDOR_LIB := libinit_variant

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(COMMON_PATH)/releasetools

# Variant linking script
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/releasetools/updater.sh:utilities/updater.sh \
    $(COMMON_PATH)/releasetools/README:utilities/README

# choose-a config
$(call inherit-product, vendor/choose-a/config/common.mk)
