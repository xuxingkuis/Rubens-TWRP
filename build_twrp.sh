#!/bin/bash

# TWRP Build Script for Redmi K50 (rubens) - HyperOS 2.0.5 Compatible
# Copyright (C) 2024 The TWRP Open Source Project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "BoardConfig.mk" ] || [ ! -f "twrp_rubens.mk" ]; then
    print_error "Please run this script from the device tree root directory"
    exit 1
fi

print_status "Starting TWRP build for Redmi K50 (rubens) - HyperOS 2.0.5"

# Set build environment
export ALLOW_MISSING_DEPENDENCIES=true
export TW_DEFAULT_LANGUAGE="zh_CN"
export LC_ALL=C

print_status "Setting up build environment..."

# Source build environment
if [ -f "build/envsetup.sh" ]; then
    source build/envsetup.sh
elif [ -f "../../../build/envsetup.sh" ]; then
    cd ../../..
    source build/envsetup.sh
    cd device/xiaomi/rubens
else
    print_error "Cannot find build/envsetup.sh. Please ensure you're in a proper TWRP source tree."
    exit 1
fi

print_status "Selecting lunch target..."
lunch twrp_rubens-eng

print_status "Starting compilation..."
print_warning "This may take a while depending on your system..."

# Build vendor_boot image
if mka vendorbootimage -j$(nproc --all); then
    print_success "Build completed successfully!"
    print_status "Output files:"
    echo "  - vendor_boot.img: out/target/product/rubens/vendor_boot.img"
    echo ""
    print_status "To flash:"
    echo "  fastboot flash vendor_boot out/target/product/rubens/vendor_boot.img"
    echo "  fastboot reboot recovery"
    echo ""
    print_success "TWRP for Redmi K50 (HyperOS 2.0.5) build completed!"
else
    print_error "Build failed! Please check the error messages above."
    exit 1
fi