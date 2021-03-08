#!/bin/bash

ROOT_PATH=${PWD}
TAR_PATH="./sudo-1.9.5p2.tar.gz"

if [ "$(whoami)" != "root" ]; then
    echo -e "\033[31m 请使用root账户\n \033[0m"
    exit
fi

if [ ! -e ${TAR_PATH} ]; then
    echo -e "\033[31m ${TAR_PATH}不存在 \033[0m"
    exit
fi

echo -e "\033[32m 解压${TAR_PATH}... \033[0m"
tar -zxvf ${TAR_PATH}
cd ${TAR_PATH%.*.*}

if [ $? != 0 ]; then
    echo -e "\033[31m 解压${TAR_PATH}失败 \033[0m"
    exit
fi

echo -e "\033[32m 校验${TAR_PATH}... \033[0m"
./configure --prefix=/usr/local --libexecdir=/usr/local/lib

echo -e "\033[32m 安装${TAR_PATH}... \033[0m"
make || exit
make install || exit

echo -e "\033[32m 校验${TAR_PATH}... \033[0m"
./configure --prefix=/usr --libexecdir=/usr/lib

echo -e "\033[32m 安装${TAR_PATH}... \033[0m"
make || exit
make install || exit

if [ $? == 0 ]; then
    echo -e "\033[32m 安装${TAR_PATH}成功 \033[0m"
else
    echo -e "\033[31m 安装${TAR_PATH}失败 \033[0m"
fi

rm -rf ${ROOT_PATH}/${TAR_PATH%.*.*}
