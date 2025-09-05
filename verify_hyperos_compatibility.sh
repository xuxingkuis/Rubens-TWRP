#!/bin/bash

# HyperOS 2.0.5 Compatibility Verification Script
# For Redmi K50 (rubens) TWRP Device Tree

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}$1${NC}"
    echo -e "${PURPLE}================================${NC}"
}

print_status() {
    echo -e "${BLUE}[CHECK]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[FAIL]${NC} $1"
}

# Counters
PASS_COUNT=0
WARN_COUNT=0
FAIL_COUNT=0

check_pass() {
    print_success "$1"
    ((PASS_COUNT++))
}

check_warn() {
    print_warning "$1"
    ((WARN_COUNT++))
}

check_fail() {
    print_error "$1"
    ((FAIL_COUNT++))
}

print_header "HyperOS 2.0.5 Compatibility Verification"

# Check essential files
print_status "Checking essential configuration files..."

if [ -f "BoardConfig.mk" ]; then
    if grep -q "PLATFORM_VERSION := 14" BoardConfig.mk; then
        check_pass "BoardConfig.mk has Android 14 platform version"
    else
        check_fail "BoardConfig.mk missing Android 14 platform version"
    fi
    
    if grep -q "TW_DEVICE_VERSION := Redmi_K50_HyperOS_2.0.5" BoardConfig.mk; then
        check_pass "BoardConfig.mk has HyperOS 2.0.5 device version"
    else
        check_warn "BoardConfig.mk missing HyperOS 2.0.5 device version"
    fi
else
    check_fail "BoardConfig.mk not found"
fi

if [ -f "device.mk" ]; then
    if grep -q "PRODUCT_SHIPPING_API_LEVEL := 34" device.mk; then
        check_pass "device.mk has API level 34"
    else
        check_fail "device.mk missing API level 34"
    fi
else
    check_fail "device.mk not found"
fi

if [ -f "twrp_rubens.mk" ]; then
    if grep -q "hyperos_config.mk" twrp_rubens.mk; then
        check_pass "twrp_rubens.mk includes HyperOS config"
    else
        check_warn "twrp_rubens.mk missing HyperOS config inclusion"
    fi
else
    check_fail "twrp_rubens.mk not found"
fi

if [ -f "hyperos_config.mk" ]; then
    check_pass "HyperOS configuration file exists"
else
    check_fail "hyperos_config.mk not found"
fi

# Check system properties
print_status "Checking system properties..."

if [ -f "system.prop" ]; then
    if grep -q "ro.miui.ui.version.code=14" system.prop; then
        check_pass "system.prop has MIUI version 14"
    else
        check_warn "system.prop missing MIUI version 14"
    fi
    
    if grep -q "ro.crypto.dm_default_key.options_format.version=2" system.prop; then
        check_pass "system.prop has enhanced crypto support"
    else
        check_warn "system.prop missing enhanced crypto support"
    fi
else
    check_fail "system.prop not found"
fi

# Check init configuration
print_status "Checking init configuration..."

if [ -f "init/init_rubens.cpp" ]; then
    if grep -q "ro.miui.ui.version.code" init/init_rubens.cpp; then
        check_pass "init_rubens.cpp has HyperOS properties"
    else
        check_warn "init_rubens.cpp missing HyperOS properties"
    fi
else
    check_fail "init/init_rubens.cpp not found"
fi

if [ -f "recovery/root/init.recovery.mt6895.rc" ]; then
    if grep -q "ro.miui.ui.version.code 14" recovery/root/init.recovery.mt6895.rc; then
        check_pass "Recovery init has HyperOS properties"
    else
        check_warn "Recovery init missing HyperOS properties"
    fi
else
    check_fail "recovery/root/init.recovery.mt6895.rc not found"
fi

# Check fstab configuration
print_status "Checking fstab configuration..."

if [ -f "recovery/root/first_stage_ramdisk/fstab.mt6895" ]; then
    if grep -q "fileencryption=aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized" recovery/root/first_stage_ramdisk/fstab.mt6895; then
        check_pass "fstab has enhanced encryption support"
    else
        check_warn "fstab missing enhanced encryption support"
    fi
else
    check_fail "fstab.mt6895 not found"
fi

# Check kernel modules
print_status "Checking kernel modules..."

MODULES_DIR="recovery/root/lib/modules"
if [ -d "$MODULES_DIR" ]; then
    ESSENTIAL_MODULES=(
        "fts_touch_spi.ko"
        "mtk_charger_framework.ko"
        "mtk_battery_oc_throttling.ko"
        "mtk_disp_notify.ko"
        "system_heap.ko"
    )
    
    for module in "${ESSENTIAL_MODULES[@]}"; do
        if [ -f "$MODULES_DIR/$module" ]; then
            check_pass "Essential module found: $module"
        else
            check_warn "Essential module missing: $module"
        fi
    done
    
    if [ -f "$MODULES_DIR/modules.load" ]; then
        check_pass "modules.load file exists"
    else
        check_warn "modules.load file missing"
    fi
else
    check_fail "Kernel modules directory not found"
fi

# Check build scripts
print_status "Checking build scripts..."

if [ -f "build_twrp.sh" ]; then
    if [ -x "build_twrp.sh" ]; then
        check_pass "Build script is executable"
    else
        check_warn "Build script exists but not executable"
        chmod +x build_twrp.sh
        check_pass "Made build script executable"
    fi
else
    check_warn "Build script not found"
fi

if [ -f "cleanup_old_files.sh" ]; then
    if [ -x "cleanup_old_files.sh" ]; then
        check_pass "Cleanup script is executable"
    else
        check_warn "Cleanup script exists but not executable"
        chmod +x cleanup_old_files.sh
        check_pass "Made cleanup script executable"
    fi
else
    check_warn "Cleanup script not found"
fi

# Check Android.bp and Android.mk files
print_status "Checking build system files..."

if [ -f "init/Android.bp" ]; then
    check_pass "init/Android.bp exists"
else
    check_warn "init/Android.bp not found"
fi

if [ -f "Android.mk" ]; then
    check_pass "Android.mk exists"
else
    check_warn "Android.mk not found"
fi

if [ -f "AndroidProducts.mk" ]; then
    check_pass "AndroidProducts.mk exists"
else
    check_fail "AndroidProducts.mk not found"
fi

# Summary
print_header "Verification Summary"

echo -e "${GREEN}Passed checks: $PASS_COUNT${NC}"
echo -e "${YELLOW}Warnings: $WARN_COUNT${NC}"
echo -e "${RED}Failed checks: $FAIL_COUNT${NC}"

if [ $FAIL_COUNT -eq 0 ]; then
    if [ $WARN_COUNT -eq 0 ]; then
        print_success "All checks passed! Device tree is fully compatible with HyperOS 2.0.5"
        exit 0
    else
        print_warning "Device tree is compatible with HyperOS 2.0.5 but has some warnings"
        exit 0
    fi
else
    print_error "Device tree has compatibility issues that need to be addressed"
    exit 1
fi