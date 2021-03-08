#!/bin/bash

# 配置vscode下载源
cat > /etc/yum.repos.d/code.repo << EOF
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc

EOF

# 安装vscode
yum install -y code

echo -e "\033[32m vscode安装成功\n \033[0m"