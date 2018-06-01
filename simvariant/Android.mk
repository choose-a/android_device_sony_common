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

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := sim_variant.c
LOCAL_INIT_RC_64 := vendor/etc/init/sim_variant.rc
LOCAL_MODULE := sim_variant
LOCAL_SHARED_LIBRARIES := libcutils liblog
LOCAL_MODULE_OWNER := sony
LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_EXECUTABLE)
