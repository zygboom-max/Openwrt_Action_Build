#!/bin/bash
# 修改版本为编译日期
  date_version=$(date +"%y.%m.%d")
  # 定义目标文件路径
  target_file="package/emortal/default-settings/files/99-default-settings"
  # 创建临时文件，将内容写入临时文件
  temp_file=$(mktemp)

# 读取文件内容并分割
{
    head -n -1 "$target_file" # 除了最后一行的所有内容
    cat << EOF
sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release
echo "DISTRIB_REVISION='R${date_version} by billyJR'" >> /etc/openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release
echo "DISTRIB_DESCRIPTION='ImmortalWrt '" >> /etc/openwrt_release

sed -i '/OPENWRT_RELEASE/d' /usr/lib/os-release
echo 'OPENWRT_RELEASE="ImmortalWrt ${date_version}"' >> /usr/lib/os-release
EOF
    tail -n 1 "$target_file" # 最后一行
} > "$temp_file"

  # 移动临时文件覆盖原文件
  mv "$temp_file" "$target_file"