# Board platforms lists to be used for
# TARGET_BOARD_PLATFORM specific featurization
QCOM_BOARD_PLATFORMS += msm8952 msm8996 msm8998 sdm660 sdm845

# List of targets that use video hw
MSM_VIDC_TARGET_LIST := msm8952 msm8996 msm8998 sdm660 sdm845

# List of targets that use master side content protection
MASTER_SIDE_CP_TARGET_LIST := msm8996 msm8998 sdm660 sdm845

ifeq ($(TARGET_USES_SDE),true)
display-hal := hardware/qcom/display/sde
else
display-hal := hardware/qcom/display/msmfb
endif
ifeq ($(TARGET_BOARD_PLATFORM),sdm845)
QCOM_MEDIA_ROOT := hardware/qcom/sdm845/media
else
QCOM_MEDIA_ROOT := hardware/qcom/media/msm8998
endif

audio-hal := hardware/qcom/audio
gps-hal := hardware/qcom/sdm845/gps/sdm845
ipa-hal := hardware/qcom/sdm845/data/ipacfg-mgr
OMX_VIDEO_PATH := mm-video-v4l2
media-hal := $(QCOM_MEDIA_ROOT)

SRC_CAMERA_HAL_DIR := hardware/qcom/camera
SRC_DISPLAY_HAL_DIR := $(display-hal)
SRC_MEDIA_HAL_DIR := $(QCOM_MEDIA_ROOT)
TARGET_KERNEL_VERSION := $(SOMC_KERNEL_VERSION)

include device/sony/common/hardware/qcom/utils.mk

include $(display-hal)/Android.mk
include $(call all-makefiles-under,$(audio-hal))
include $(call all-makefiles-under,$(ipa-hal))
include $(call all-makefiles-under,$(gps-hal))
include $(call all-makefiles-under,$(media-hal))
