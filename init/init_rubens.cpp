#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <android-base/properties.h>

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

using android::base::GetProperty;

void property_override(char const prop[], char const value[])
{
    prop_info *pi;

    pi = (prop_info*) __system_property_find(prop);
    if (pi)
        __system_property_update(pi, value, strlen(value));
    else
        __system_property_add(prop, strlen(prop), value, strlen(value));
}

void vendor_load_properties()
{
    const char* prop_partitions[] = {"", "vendor.", "odm.", "system.", "system_ext.", "product."};
    
    for (int i = 0; i < 6; i++) {
        char prop_name[256];
        
        snprintf(prop_name, sizeof(prop_name), "ro.product.%sbrand", prop_partitions[i]);
        property_override(prop_name, "Redmi");
        
        snprintf(prop_name, sizeof(prop_name), "ro.product.%sname", prop_partitions[i]);
        property_override(prop_name, "rubens");
        
        snprintf(prop_name, sizeof(prop_name), "ro.product.%sdevice", prop_partitions[i]);
        property_override(prop_name, "rubens");
        
        snprintf(prop_name, sizeof(prop_name), "ro.product.%smodel", prop_partitions[i]);
        property_override(prop_name, "22041211AC");
        
        snprintf(prop_name, sizeof(prop_name), "ro.product.%smarketname", prop_partitions[i]);
        property_override(prop_name, "Redmi K50");
    }
    
    // HyperOS 2.0.5 specific properties
    property_override("ro.bootimage.build.date.utc", "1609430400");
    property_override("ro.build.date.utc", "1609430400");
    property_override("ro.miui.ui.version.code", "14");
    property_override("ro.miui.ui.version.name", "V140");
    property_override("ro.product.mod_device", "rubens_global");
    property_override("ro.build.ab_update", "true");
    property_override("ro.crypto.dm_default_key.options_format.version", "2");
    property_override("ro.crypto.volume.metadata.method", "dm-default-key");
    
    // Performance optimizations for HyperOS 2.0.5
    property_override("ro.vendor.perf.scroll_opt", "true");
    property_override("ro.config.avoid_gfx_accel", "true");
    property_override("ro.config.per_app_memcg", "false");
}