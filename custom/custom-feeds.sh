
echo ">>> [5/4] clone argon 主题 (v2.4.8) 到 package/"
if [ ! -d package/luci-theme-argon ]; then
  git clone --depth 1 --branch v2.4.8 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
fi

echo ">>> [6/4] 追加 argon 到 rax3000m.config（内置 argon 2.4.8 主题）"
grep -q 'CONFIG_PACKAGE_luci-theme-argon' custom/rax3000m.config || echo 'CONFIG_PACKAGE_luci-theme-argon=y' >> custom/rax3000m.config
