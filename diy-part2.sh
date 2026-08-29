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