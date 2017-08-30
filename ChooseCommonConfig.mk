# Copyright 2014 The Android Open Source Project
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

# Also use headers from kernel during build process
TARGET_COMPILE_WITH_MSM_KERNEL := true

# Common kernel source
TARGET_KERNEL_SOURCE := kernel/sony/msm

# Enforcing SELinux
BOARD_USE_ENFORCING_SELINUX := true

# Common config
include $(COMMON_PATH)/CommonConfig.mk
#include $(COMMON_PATH)/twrp.mk
