#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# 缂佸顭峰▍搴☆啅閹绘帞鎽犻柛锔哄妿濞堟唴modem feed闁挎稑鐗撴导鈺呭礂瀹ュ娅㈠璺虹▌缁?
sed -i '/src-git qmodem/d' feeds.conf.default
sed -i '/src-git openclash/d' feeds.conf.default

# QModem - 5G婵☆垽绱曠划宥囩不閿涘嫭鍊為柨娑樼墕閹牓鎯岄婵呯箚闁靛棔绀侀ˇ绺扐N闁靛棔绠慣L闁告梻鍠曢崗姗€鏁?
echo 'src-git qmodem https://github.com/FUjr/QModem.git;main' >>feeds.conf.default

# OpenClash - 缂傚啯鍨圭划璺侯啅閵夈儱寰?
echo 'src-git openclash https://github.com/vernesong/OpenClash.git;master' >>feeds.conf.default

# LuCI濞戞挸顭烽。?- argon-mod (闁糕晞妗ㄧ花顒勫储閻斿搫顣糰rgon濞村吋锚鐎?
rm -rf package/lean/luci-theme-argon-mod
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon-mod 2>/dev/null || true

# LuCI濞戞挸顭烽。?- neobird (濞戞挻鎸风拹鐔虹矓鐠囨彃袟缂佹棏鍨槐顓㈠礌?
rm -rf package/lean/luci-theme-neobird
git clone --depth=1 https://github.com/thinktip/luci-theme-neobird.git package/lean/luci-theme-neobird 2>/dev/null || true