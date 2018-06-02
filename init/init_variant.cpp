/*
   Copyright (c) 2015, The CyanogenMod Project
   Copyright (c) 2016, The OmniROM Project

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/system_properties.h>

#include "property_service.h"
#include "log.h"
#include "util.h"


#include "variants.h"

#ifndef VARIANT_GSM
#define VARIANT_GSM 1
#endif

namespace android {
namespace init {

void vendor_load_properties()
{
    char model[PROP_VALUE_MAX];
    char codename[PROP_VALUE_MAX];

#if VARIANT_GSM
    int variantID = -1;
#endif

    // Get properties
    __system_property_get("ro.sony.variant", model);
    __system_property_get("ro.choose-a.device", codename);
    // Set Properties
    property_set("ro.product.model", model);
    property_set("ro.product.device", codename);

#if VARIANT_GSM
    for (int i = 0; i < (signed)(sizeof(variants)/(sizeof(variants[0]))); i++) {
        if (strcmp(model,variants[i].model) == 0) {
            variantID = i;
            break;
        }
    }

    if (variantID >= 0) {
        if (variants[variantID].is_ds) {
            property_set("persist.radio.multisim.config", "dsds");
        }
    }
#endif
}
} //init
} //android
