#!/sbin/sh
#
# Copyright (C) 2012 The Android Open Source Project
# Copyright (C) 2016 The OmniROM Project
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
#

set -e

# write logs to /tmp
set_log() {
    mkdir -p /tmp/choose-a;
    rm -rf /tmp/choose-a/"${1}";
    exec >> /tmp/choose-a/"${1}" 2>&1;
}

# set log
set_log variant_detect.log

# check mounts
check_mount() {
    local MOUNT_POINT=$(readlink "${1}");
    if ! test -n "${MOUNT_POINT}" ; then
        # readlink does not work on older recoveries for some reason
        # doesn't matter since the path is already correct in that case
        echo "Using non-readlink mount point ${1}";
        MOUNT_POINT="${1}";
    fi
    if ! grep -q "${MOUNT_POINT}" /proc/mounts ; then
        mkdir -p "${MOUNT_POINT}";
        if test "${MOUNT_POINT}" = /lta-label ; then
            if ! mount -r -t "${3}" "${2}" "${MOUNT_POINT}" ; then
                echo "Cannot mount ${1} (${MOUNT_POINT}).";
                exit 1;
            fi
        else
            umount -l "${2}";
            if ! mount -t "${3}" "${2}" "${MOUNT_POINT}" ; then
                echo "Cannot mount ${1} (${MOUNT_POINT}).";
                exit 1;
            fi
        fi
    fi
}

# check partitions
check_mount /system /dev/block/bootdevice/by-name/system ext4;
check_mount /lta-label /dev/block/bootdevice/by-name/LTALabel ext4;
check_mount /odm /dev/block/bootdevice/by-name/oem ext4;

# Check the vendor firmware version flashed on ODM

currentversion=12

vendorversion=$(\
    cat /odm/odm_version.prop | \
    grep ro.vendor.version | \
    sed s/.*=// \
);

echo "Vendorversion: ${vendorversion}";

if [[ "$vendorversion" == "$currentversion"]]
then
  echo "#######################################";
  echo "###    Vendorversion up to date     ###";
  echo "#######################################";
else
  echo -e "${RED}#######################################${NC}";
  echo -e "${RED}#  PLEASE BEWARE YOU DONOT HAVE THE   #${NC}";
  echo -e "${RED}#  (CURRENT) VENDOR FIRMWARE INSTALLED#${NC}";
  echo -e "${RED}#=====================================#${NC}";
  echo -e "${RED}#  NOT HAVING THIS INSTALLED COULD    #${NC}";
  echo -e "${RED}#  CAUSE UNEXPECTED AND UNWANTED      #${NC}";
  echo -e "${RED}#  BEHAVIOUR. GET YOUR COPY OF THE    #${NC}";
  echo -e "${RED}#  LATEST VENDOR FIRMWARE AT:         #${NC}";
  echo -e "${RED}#  https://developer.sony.com/deve    #${NC}";
  echo -e "${RED}#  lop/open-devices/guides/aosp-bu    #${NC}";
  echo -e "${RED}#  ild-instructions                   #${NC}";
  echo -e "${RED}#  AND FOLLOW INSTRUCTIONS ON LINKED  #${NC}";
  echo -e "${RED}#  PAGES. ALTERNATIVELY CHECK THE     #${NC}";
  echo -e "${RED}#  README THAT IS INCLUDED IN THE     #${NC}";
  echo -e "${RED}#  ZIP YOU ARE INSTALLING THIS        #${NC}";
  echo -e "${RED}#  ROM FROM                           #${NC}";
  echo -e "${RED}#######################################${NC}";
fi

# Detect the exact model from the LTALabel partition
# This looks something like:
# 1284-8432_5-elabel-D5303-row.html
variant=$(\
    ls /lta-label/*.html | \
    sed s/.*-elabel-// | \
    sed s/-.*.html// | \
    tr -d '\n\r' | \
    tr '[a-z]' '[A-Z]' \
);
echo "Variant: ${variant}";

# Set the variant as a prop
if [ ! -f /odm/build.prop ]
then
touch /odm/build.prop;
$(echo "ro.sony.variant=${variant}" >> /odm/build.prop);
chmod 0644 /odm/build.prop;
fi

exit 0
