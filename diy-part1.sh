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

# 绉婚櫎宸插瓨鍦ㄧ殑qmodem feed锛堥伩鍏嶉噸澶嶏級
sed -i '/src-git qmodem/d' feeds.conf.default
sed -i '/src-git openclash/d' feeds.conf.default

# QModem - 5G妯＄粍绠＄悊锛堝惈鐭俊銆佸WAN銆乀TL鍔熻兘锛?
echo 'src-git qmodem https://github.com/FUjr/QModem.git;main' >>feeds.conf.default

# OpenClash - 缃戠粶宸ュ叿
echo 'src-git openclash https://github.com/vernesong/OpenClash.git;master' >>feeds.conf.default

# LuCI涓婚 - argon-mod (鍩轰簬鍘熺増argon浼樺寲)
rm -rf package/lean/luci-theme-argon-mod
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon-mod 2>/dev/null || true

# LuCI涓婚 - neobird (涓撲负绉诲姩绔紭鍖?
rm -rf package/lean/luci-theme-neobird
git clone --depth=1 https://github.com/thinktip/luci-theme-neobird.git package/lean/luci-theme-neobird 2>/dev/null || true