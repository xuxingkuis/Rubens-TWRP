
The Redmi K50 (codenamed _"rubens"_) is a high-end, mid-range smartphone from Xiaomi.

It was released in March 2022.

## Device specifications

Basic   | Spec Sheet
-------:|:-------------------------
CPU     | Octa-core CPU with 4x Arm Cortex-A78 up to 2.85GHz
Chipset | Mediatek Dimensity 8100
GPU     | Mali-G610 MC6
Memory  | 8/12 GB RAM (LPDDR5 6400Mbps)
Shipped Android Version | 12
Storage | 128/256/512 GB (UFS 3.1)
Battery | Li-Po 5500 mAh, non-removable
Display | 1440 x 3200 pixels, 6.67 inches, 60/120 hz
=======
### TWRP device tree for Redmi K50 (rubens) - HyperOS 2.0.5 Compatible

=========================================

The Redmi K50 (codenamed _"rubens"_) is a high-end, mid-range smartphone from Xiaomi.

It was released in March 2022. This TWRP build is specifically optimized for HyperOS 2.0.5.

## Device specifications

Basic   | Spec Sheet
-------:|:-------------------------
CPU     | Octa-core CPU with 4x Arm Cortex-A78 up to 2.85GHz
Chipset | Mediatek Dimensity 8100
GPU     | Mali-G610 MC6
Memory  | 8/12 GB RAM (LPDDR5 6400Mbps)
Shipped Android Version | 12 (Now supports Android 14/HyperOS 2.0.5)
Storage | 128/256/512 GB (UFS 3.1)
Battery | Li-Po 5500 mAh, non-removable
Display | 1440 x 3200 pixels, 6.67 inches, 60/120 hz

=========================================

The Redmi K50 (codenamed _"rubens"_) is a high-end, mid-range smartphone from Xiaomi.

It was released in March 2022.

## Device specifications

Basic   | Spec Sheet
-------:|:-------------------------
CPU     | Octa-core CPU with 4x Arm Cortex-A78 up to 2.85GHz
Chipset | Mediatek Dimensity 8100
GPU     | Mali-G610 MC6
Memory  | 8/12 GB RAM (LPDDR5 6400Mbps)
Shipped Android Version | 12
Storage | 128/256/512 GB (UFS 3.1)
Battery | Li-Po 5500 mAh, non-removable
Display | 1440 x 3200 pixels, 6.67 inches, 60/120 hz

![Redmi K50](https://cdn.cnbj0.fds.api.mi-img.com/b2c-shopapi-pms/pms_1653381863.47942179.png)

## Features

Works:

- [X] ADB
- [X] Decryption (Android 14/HyperOS 2.0.5)
- [X] Display (120Hz support)
- [X] Fastbootd
- [X] Flashing (A/B partitions)
- [X] MTP
- [X] Sideload
- [X] USB OTG
- [X] Vibrator (Enhanced haptic feedback)
- [X] Logical partitions
- [X] Super partition support
- [X] Enhanced touch screen support
- [X] Thermal management
- [X] Performance optimizations

## HyperOS 2.0.5 Specific Features

- [X] Enhanced encryption support (FBE with metadata)
- [X] Improved performance with 120Hz display support
- [X] Better memory management
- [X] Optimized thermal control
- [X] Enhanced touch screen responsiveness
- [X] Improved haptic feedback system
- [X] Better compatibility with HyperOS system apps

## Compile

First checkout minimal twrp with aosp tree:

```bash
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
repo sync -j$(nproc --all)
```

Then add these projects to .repo/manifest.xml:

```xml
<project path="device/xiaomi/rubens" name="your-repo/device_xiaomi_rubens-TWRP" remote="github" revision="hyperos-2.0.5" />
```

Finally execute these:

```bash
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export TW_DEFAULT_LANGUAGE="zh_CN"
lunch twrp_rubens-eng
mka vendorbootimage -j$(nproc --all)
```

## Installation

### For HyperOS 2.0.5:

```bash
# Flash the vendor_boot image
fastboot flash vendor_boot out/target/product/rubens/vendor_boot.img

# Reboot to recovery
fastboot reboot recovery
```

### Notes for HyperOS 2.0.5:
- Ensure your device is running HyperOS 2.0.5 before flashing
- This TWRP build includes enhanced decryption support for HyperOS
- Performance optimizations are specifically tuned for HyperOS 2.0.5
- Backup your current recovery before flashing

## Changelog (HyperOS 2.0.5 Update)

- Updated to Android 14 API level 34
- Enhanced FBE decryption support for HyperOS 2.0.5
- Improved 120Hz display support
- Better thermal management
- Enhanced haptic feedback system
- Optimized memory management
- Added touch screen gesture support
- Performance improvements for HyperOS compatibility
- Updated kernel modules for better hardware support
- Enhanced logical partition support
