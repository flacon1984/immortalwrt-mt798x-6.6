#!/bin/bash
set -e

echo ">>> [1/4] 添加 istore 商店 feed"
if ! grep -q 'src-git istore' feeds.conf.default; then
  echo 'src-git istore https://github.com/linkease/istore;main' >> feeds.conf.default
fi

echo ">>> [2/4] clone openclash 插件到 package/"
if [ ! -d package/OpenClash ]; then
  git clone --depth 1 https://github.com/vernesong/OpenClash.git package/OpenClash
fi

echo ">>> [3/4] clone quickfile 插件到 package/"
if [ ! -d package/luci-app-quickfile ]; then
  git clone --depth 1 https://github.com/sbwml/luci-app-quickfile.git package/luci-app-quickfile
fi

echo ">>> [4/4] clone bandix 后端+前端到 package/"
if [ ! -d package/openwrt-bandix ]; then
  git clone --depth 1 https://github.com/timsaya/openwrt-bandix.git package/openwrt-bandix
fi
if [ ! -d package/luci-app-bandix ]; then
  git clone --depth 1 https://github.com/timsaya/luci-app-bandix.git package/luci-app-bandix
fi

echo ">>> 开启 BPF 调度器内核配置（bandix 依赖）"
KCFG="target/linux/mediatek/filogic/config-6.6"
if [ -f "$KCFG" ]; then
  grep -q '^CONFIG_NET_SCH_BPF' "$KCFG" || echo 'CONFIG_NET_SCH_BPF=m' >> "$KCFG"
  grep -q '^CONFIG_NET_CLS_BPF' "$KCFG" || echo 'CONFIG_NET_CLS_BPF=m' >> "$KCFG"
  echo "--- 已追加的 BPF 配置 ---"
  grep -E 'NET_SCH_BPF|NET_CLS_BPF' "$KCFG"
else
  echo "!! 未找到 $KCFG，BPF 配置未追加，bandix 将不可用！"
fi

echo ">>> feeds 配置完成"
