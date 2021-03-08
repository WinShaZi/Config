#!/bin/bash

# 配置git下载源
cat > /etc/yum.repos.d/wandisco-git.repo << EOF
[wandisco-git]
name=Wandisco GIT Repository
baseurl=http://opensource.wandisco.com/centos/7/git/x86_64/
enabled=1
gpgcheck=1
gpgkey=http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco

EOF

rpm --import http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco

# 安装git
yum -y install git

echo -e "\033[32m git安装成功 \033[0m"
