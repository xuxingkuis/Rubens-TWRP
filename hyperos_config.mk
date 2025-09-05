#
# Copyright (C) 2024 The TWRP Open Source Project
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

# HyperOS 2.0.5 Specific Configurations for Redmi K50

# HyperOS Version Properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.miui.ui.version.code=14 \
    ro.miui.ui.version.name=V140 \
    ro.product.mod_device=rubens_global \
    ro.build.ab_update=true

# Enhanced Crypto Support for HyperOS 2.0.5
PRODUCT_PROPERTY_OVERRIDES += \
    ro.crypto.dm_default_key.options_format.version=2 \
    ro.crypto.volume.metadata.method=dm-default-key \
    ro.crypto.volume.filenames_mode=aes-256-cts

# Performance Optimizations
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.perf.scroll_opt=true \
    ro.config.avoid_gfx_accel=true \
    ro.config.per_app_memcg=false \
    ro.surface_flinger.max_frame_buffer_acquired_buffers=3 \
    ro.surface_flinger.running_without_sync_framework=true \
    ro.surface_flinger.vsync_event_phase_offset_ns=2000000 \
    ro.surface_flinger.vsync_sf_event_phase_phase_offset_ns=6000000

# Display Enhancements
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=560 \
    ro.opengles.version=196610 \
    debug.sf.enable_hwc_vds=1 \
    debug.sf.latch_unsignaled=1

# Audio Properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.audio.flinger_standbytime_ms=300 \
    ro.config.vc_call_vol_steps=11 \
    ro.config.media_vol_steps=25

# Thermal Management
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.thermal.management=true \
    ro.config.thermal_limit_cpu_freq=true

# Memory Management
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.fha_enable=true \
    ro.sys.fw.bg_apps_limit=32 \
    ro.config.dha_cached_max=16 \
    ro.config.dha_empty_max=42

# Network Optimizations
PRODUCT_PROPERTY_OVERRIDES += \
    net.tcp.default_init_rwnd=60 \
    ro.telephony.iwlan_operation_mode=legacy