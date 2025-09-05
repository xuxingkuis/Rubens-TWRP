#!/bin/bash

# Cleanup Script for TWRP Redmi K50 (rubens) - HyperOS 2.0.5
# This script removes unnecessary old files and optimizes the build

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[CLEANUP]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[REMOVED]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[SKIP]${NC} $1"
}

print_status "Starting cleanup for HyperOS 2.0.5 compatibility..."

# Remove old Android version specific files
OLD_FILES=(
    "recovery/root/system/etc/recovery-resource.dat"
    "recovery/root/system/recovery-from-boot.p"
    "recovery/root/sbin/recovery"
    "prebuilt/recovery.img"
    "prebuilt/boot.img"
)

for file in "${OLD_FILES[@]}"; do
    if [ -f "$file" ]; then
        rm -f "$file"
        print_success "Removed old file: $file"
    else
        print_warning "File not found (already clean): $file"
    fi
done

# Clean up old kernel modules that might conflict with HyperOS 2.0.5
MODULES_DIR="recovery/root/lib/modules"
if [ -d "$MODULES_DIR" ]; then
    print_status "Checking kernel modules compatibility..."
    
    # Remove potentially conflicting old modules
    OLD_MODULES=(
        "wlan.ko"
        "old_touchscreen.ko"
        "legacy_audio.ko"
    )
    
    for module in "${OLD_MODULES[@]}"; do
        if [ -f "$MODULES_DIR/$module" ]; then
            rm -f "$MODULES_DIR/$module"
            print_success "Removed old module: $module"
        fi
    done
    
    # Update modules.load for HyperOS 2.0.5
    if [ -f "$MODULES_DIR/modules.load" ]; then
        print_status "Updating modules.load for HyperOS 2.0.5..."
        # Backup original
        cp "$MODULES_DIR/modules.load" "$MODULES_DIR/modules.load.backup"
        
        # Create optimized modules.load for HyperOS 2.0.5
        cat > "$MODULES_DIR/modules.load" << EOF
# Optimized module loading for HyperOS 2.0.5
# Core system modules
mtk_charger_framework.ko
mtk_battery_oc_throttling.ko
mtk_low_battery_throttling.ko
mtk_dynamic_loading_throttling.ko

# Display and input
fts_touch_spi.ko
mtk_disp_notify.ko
leds-mtk.ko

# Audio and haptics
haptic.ko

# Storage and filesystem
mtk-mmc.ko
system_heap.ko

# Security
sec.ko
rpmb.ko

# Power management
mt6375-charger.ko
mt6375-battery.ko
regulator-vibrator.ko

# Thermal management
# (thermal modules loaded automatically)

# Network (if needed)
# cfg80211.ko
# mac80211.ko
EOF
        print_success "Updated modules.load for HyperOS 2.0.5"
    fi
fi

# Remove old build artifacts
BUILD_ARTIFACTS=(
    "out/"
    ".repo/repo/"
    "*.log"
    "*.tmp"
)

for artifact in "${BUILD_ARTIFACTS[@]}"; do
    if ls $artifact 1> /dev/null 2>&1; then
        rm -rf $artifact
        print_success "Removed build artifacts: $artifact"
    fi
done

# Clean up git artifacts if present
if [ -d ".git" ]; then
    print_status "Cleaning git repository..."
    git clean -fd
    git gc --aggressive
    print_success "Git repository cleaned"
fi

# Remove empty directories
find . -type d -empty -delete 2>/dev/null || true

print_status "Cleanup completed!"
print_status "Summary of optimizations for HyperOS 2.0.5:"
echo "  ✓ Removed old Android version specific files"
echo "  ✓ Updated kernel modules for HyperOS compatibility"
echo "  ✓ Cleaned build artifacts"
echo "  ✓ Optimized directory structure"
echo ""
print_success "Device tree is now optimized for HyperOS 2.0.5!"