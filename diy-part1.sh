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

# 缁夊娅庡鎻掔摠閸︺劎娈憅modem feed閿涘牓浼╅崗宥夊櫢婢跺稄绱?
sed -i '/src-git qmodem/d' feeds.conf.default
sed -i '/src-git openclash/d' feeds.conf.default

# QModem - 5G濡紕绮嶇粻锛勬倞閿涘牆鎯堥惌顓濅繆閵嗕礁顦縒AN閵嗕箑TL閸旂喕鍏橀敍?
echo 'src-git qmodem https://github.com/FUjr/QModem.git;main' >>feeds.conf.default

# OpenClash - 缂冩垹绮跺銉ュ徔
echo 'src-git openclash https://github.com/vernesong/OpenClash.git;master' >>feeds.conf.default

# LuCI娑撳顣?- argon-mod (閸╄桨绨崢鐔哄argon娴兼ê瀵?
rm -rf package/lean/luci-theme-argon-mod
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon-mod 2>/dev/null || true

# LuCI娑撳顣?- neobird (娑撴挷璐熺粔璇插З缁旑垯绱崠?
rm -rf package/lean/luci-theme-neobird
git clone --depth=1 https://github.com/thinktip/luci-theme-neobird.git package/lean/luci-theme-neobird 2>/dev/null || true