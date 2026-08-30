#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# Fix rk3399-fine-3399.dts syntax error (Unicode hyphen and indentation)
DTS_FILE="target/linux/rockchip/files/arch/arm64/boot/dts/rockchip/rk3399-fine-3399.dts"
if [ -f "$DTS_FILE" ]; then
    # Replace Unicode non-breaking hyphen (U+2011) with ASCII hyphen
    sed -i 's/\xc2\xad/-/g' "$DTS_FILE" 2>/dev/null || true
    sed -i 's/\xe2\x80\x91/-/g' "$DTS_FILE" 2>/dev/null || true
    # Fix indentation for usb_pwr node (lines 92-98)
    sed -i '92s/^    /\t/' "$DTS_FILE"
    sed -i '93,97s/^    /\t\t/' "$DTS_FILE"
    sed -i '98s/^};/\t};/' "$DTS_FILE"
    echo "Fixed rk3399-fine-3399.dts syntax error"
fi
# Fix duplicate label 'usb_pwr' in rk3399-fine-3399.dts
DTS_FILE="target/linux/rockchip/files/arch/arm64/boot/dts/rockchip/rk3399-fine-3399.dts"
if [ -f "$DTS_FILE" ]; then
    # Fix pinctrl label: usb_pwr -> pinctrl_usb_pwr (line 448)
    sed -i '448s/usb_pwr: usb-pwr-grp/pinctrl_usb_pwr: usb-pwr-grp/' "$DTS_FILE"
    echo "Fixed duplicate label usb_pwr in rk3399-fine-3399.dts"
fi
# === 添加高通 QCNFA765 (WCN6855) ath11k WiFi 驱动支持 ===
echo "Adding ath11k driver support to kernel config..."
KERNEL_CONFIG="target/linux/rockchip/armv8/config-6.12"
if [ -f "$KERNEL_CONFIG" ]; then
    # 移除已存在的相关配置（避免重复）
    sed -i '/^CONFIG_ATH_COMMON=/d' "$KERNEL_CONFIG"
    sed -i '/^CONFIG_ATH11K=/d' "$KERNEL_CONFIG"
    sed -i '/^CONFIG_ATH11K_PCI=/d' "$KERNEL_CONFIG"
    sed -i '/^CONFIG_MAC80211=/d' "$KERNEL_CONFIG"
    sed -i '/^CONFIG_MAC80211_MESH=/d' "$KERNEL_CONFIG"
    sed -i '/^CONFIG_ATH9K_HWRNG=/d' "$KERNEL_CONFIG"
    sed -i '/^CONFIG_ATH9K_PCOEM=/d' "$KERNEL_CONFIG"
    sed -i '/^CONFIG_ATH9K_HTC=/d' "$KERNEL_CONFIG"
    sed -i '/^CONFIG_ATH10K=/d' "$KERNEL_CONFIG"
    sed -i '/^CONFIG_ATH10K_PCI=/d' "$KERNEL_CONFIG"
    sed -i '/^CONFIG_ATH10K_SDIO=/d' "$KERNEL_CONFIG"
    sed -i '/^CONFIG_ATH10K_USB=/d' "$KERNEL_CONFIG"
    sed -i '/^CONFIG_ATH6KL=/d' "$KERNEL_CONFIG"
    sed -i '/^CONFIG_ATH5K=/d' "$KERNEL_CONFIG"
    sed -i '/^CONFIG_WCN36XX=/d' "$KERNEL_CONFIG"
    
    # 添加 ath11k 及依赖配置
    cat >> "$KERNEL_CONFIG" << 'KERNEL_EOF'
CONFIG_ATH_COMMON=m
CONFIG_ATH11K=m
CONFIG_ATH11K_PCI=m
CONFIG_ATH11K_SDIO=m
CONFIG_ATH11K_AHB=m
CONFIG_ATH11K_DEBUG=y
CONFIG_ATH11K_DEBUGFS=y
CONFIG_ATH11K_TRACING=y
CONFIG_MAC80211=m
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_DEBUGFS=y
CONFIG_MAC80211_MESSAGE_TRACING=y
CONFIG_MAC80211_DEBUG_MENU=y
CONFIG_CFG80211=m
CONFIG_CFG80211_WEXT=y
CONFIG_CFG80211_DEBUGFS=y
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_SPY=y
CONFIG_WEXT_PRIV=y
CONFIG_LIB80211=m
CONFIG_LIB80211_CRYPT_WEP=m
CONFIG_LIB80211_CRYPT_CCMP=m
CONFIG_LIB80211_CRYPT_TKIP=m
CONFIG_BACKPORT=y
KERNEL_EOF
    echo "ath11k kernel config added to $KERNEL_CONFIG"
else
    echo "WARNING: Kernel config file $KERNEL_CONFIG not found"
    # 尝试查找其他可能的配置文件
    find target/linux/rockchip -name "config-*" -type f 2>/dev/null
fi
# === ath11k 驱动配置结束 ===