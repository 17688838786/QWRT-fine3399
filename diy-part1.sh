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

# 移除已存在的qmodem feed（避免重复）
sed -i '/src-git qmodem/d' feeds.conf.default
sed -i '/src-git openclash/d' feeds.conf.default

# QModem - 5G模组管理（含短信、多WAN、TTL功能）
echo 'src-git qmodem https://github.com/FUjr/QModem.git;main' >>feeds.conf.default

# OpenClash - 网络工具
echo 'src-git openclash https://github.com/vernesong/OpenClash.git;master' >>feeds.conf.default

# LuCI主题 - argon-mod (基于原版argon优化)
rm -rf package/lean/luci-theme-argon-mod
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon-mod 2>/dev/null || true

# LuCI主题 - neobird (专为移动端优化)
rm -rf package/lean/luci-theme-neobird
git clone --depth=1 https://github.com/thinktip/luci-theme-neobird.git package/lean/luci-theme-neobird 2>/dev/null || true