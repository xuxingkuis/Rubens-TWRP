# HyperOS 2.0.5 Compatibility Verification Script (PowerShell)
# For Redmi K50 (rubens) TWRP Device Tree

Write-Host "================================" -ForegroundColor Magenta
Write-Host "HyperOS 2.0.5 Compatibility Verification" -ForegroundColor Magenta
Write-Host "================================" -ForegroundColor Magenta

$PassCount = 0
$WarnCount = 0
$FailCount = 0

function Check-Pass {
    param($Message)
    Write-Host "[PASS] $Message" -ForegroundColor Green
    $script:PassCount++
}

function Check-Warn {
    param($Message)
    Write-Host "[WARN] $Message" -ForegroundColor Yellow
    $script:WarnCount++
}

function Check-Fail {
    param($Message)
    Write-Host "[FAIL] $Message" -ForegroundColor Red
    $script:FailCount++
}

Write-Host "[CHECK] Checking essential configuration files..." -ForegroundColor Blue

# Check BoardConfig.mk
if (Test-Path "BoardConfig.mk") {
    $boardConfig = Get-Content "BoardConfig.mk" -Raw
    if ($boardConfig -match "PLATFORM_VERSION := 14") {
        Check-Pass "BoardConfig.mk has Android 14 platform version"
    } else {
        Check-Fail "BoardConfig.mk missing Android 14 platform version"
    }
    
    if ($boardConfig -match "TW_DEVICE_VERSION := Redmi_K50_HyperOS_2.0.5") {
        Check-Pass "BoardConfig.mk has HyperOS 2.0.5 device version"
    } else {
        Check-Warn "BoardConfig.mk missing HyperOS 2.0.5 device version"
    }
} else {
    Check-Fail "BoardConfig.mk not found"
}

# Check device.mk
if (Test-Path "device.mk") {
    $deviceMk = Get-Content "device.mk" -Raw
    if ($deviceMk -match "PRODUCT_SHIPPING_API_LEVEL := 34") {
        Check-Pass "device.mk has API level 34"
    } else {
        Check-Fail "device.mk missing API level 34"
    }
} else {
    Check-Fail "device.mk not found"
}

# Check twrp_rubens.mk
if (Test-Path "twrp_rubens.mk") {
    $twrpMk = Get-Content "twrp_rubens.mk" -Raw
    if ($twrpMk -match "hyperos_config.mk") {
        Check-Pass "twrp_rubens.mk includes HyperOS config"
    } else {
        Check-Warn "twrp_rubens.mk missing HyperOS config inclusion"
    }
} else {
    Check-Fail "twrp_rubens.mk not found"
}

# Check hyperos_config.mk
if (Test-Path "hyperos_config.mk") {
    Check-Pass "HyperOS configuration file exists"
} else {
    Check-Fail "hyperos_config.mk not found"
}

Write-Host "[CHECK] Checking system properties..." -ForegroundColor Blue

# Check system.prop
if (Test-Path "system.prop") {
    $systemProp = Get-Content "system.prop" -Raw
    if ($systemProp -match "ro.miui.ui.version.code=14") {
        Check-Pass "system.prop has MIUI version 14"
    } else {
        Check-Warn "system.prop missing MIUI version 14"
    }
} else {
    Check-Fail "system.prop not found"
}

Write-Host "[CHECK] Checking init configuration..." -ForegroundColor Blue

# Check init_rubens.cpp
if (Test-Path "init/init_rubens.cpp") {
    $initCpp = Get-Content "init/init_rubens.cpp" -Raw
    if ($initCpp -match "ro.miui.ui.version.code") {
        Check-Pass "init_rubens.cpp has HyperOS properties"
    } else {
        Check-Warn "init_rubens.cpp missing HyperOS properties"
    }
} else {
    Check-Fail "init/init_rubens.cpp not found"
}

Write-Host "[CHECK] Checking kernel modules..." -ForegroundColor Blue

$ModulesDir = "recovery/root/lib/modules"
if (Test-Path $ModulesDir) {
    $EssentialModules = @(
        "fts_touch_spi.ko",
        "mtk_charger_framework.ko",
        "mtk_battery_oc_throttling.ko",
        "mtk_disp_notify.ko",
        "system_heap.ko"
    )
    
    foreach ($module in $EssentialModules) {
        if (Test-Path "$ModulesDir/$module") {
            Check-Pass "Essential module found: $module"
        } else {
            Check-Warn "Essential module missing: $module"
        }
    }
} else {
    Check-Fail "Kernel modules directory not found"
}

Write-Host "================================" -ForegroundColor Magenta
Write-Host "Verification Summary" -ForegroundColor Magenta
Write-Host "================================" -ForegroundColor Magenta

Write-Host "Passed checks: $PassCount" -ForegroundColor Green
Write-Host "Warnings: $WarnCount" -ForegroundColor Yellow
Write-Host "Failed checks: $FailCount" -ForegroundColor Red

if ($FailCount -eq 0) {
    if ($WarnCount -eq 0) {
        Write-Host "[SUCCESS] All checks passed! Device tree is fully compatible with HyperOS 2.0.5" -ForegroundColor Green
    } else {
        Write-Host "[WARNING] Device tree is compatible with HyperOS 2.0.5 but has some warnings" -ForegroundColor Yellow
    }
} else {
    Write-Host "[ERROR] Device tree has compatibility issues that need to be addressed" -ForegroundColor Red
}