#!/bin/bash

ROOT_PATH=${PWD}
OPENSSH_TAR="${ROOT_PATH}/openssh-8.5p1.tar.gz"
OPENSSL_TAR="${ROOT_PATH}/openssl-1.1.1j.tar.gz"
ZLIB_TAR="${ROOT_PATH}/zlib-1.2.11.tar.gz"

OPENSSH_PATH="/usr/local/openssh"
OPENSSL_PATH="/usr/local/ssl"
ZLIB_PATH="/usr/local/zlib"

OBJECTS=(${ZLIB_TAR} ${OPENSSL_TAR} ${OPENSSH_TAR})

function Remove() {
    for obj in ${OBJECTS[*]}; do
        rm -rf ${obj%.*.*}
    done
}

if [ "$(whoami)" != "root" ]; then
    echo -e "\033[31m 请使用root账户\n \033[0m"
    exit
fi

for obj in ${OBJECTS[*]}; do
    if [ ! -e ${obj} ]; then
        echo -e "\033[31m ${obj}不存在 \033[0m"
        exit
    fi
done

for obj in ${OBJECTS[*]}; do
    tar -zxvf ${obj} > /dev/null
    if [ $? != 0 ]; then
        echo -e "\033[31m ${obj}解压失败 \033[0m"
        exit
    fi
done

echo -e "\033[32m ${ZLIB_TAR}校验... \033[0m"
sleep 2
cd ${ZLIB_TAR%.*.*}
./configure --prefix=${ZLIB_PATH}  || exit

echo -e "\033[32m ${ZLIB_TAR}安装... \033[0m"
sleep 2
make || exit
make install || exit



echo -e "\033[32m ${OPENSSL_TAR}校验... \033[0m"
sleep 2
cd ${OPENSSL_TAR%.*.*}
./config --prefix=${OPENSSL_PATH} --shared || exit

echo -e "\033[32m ${OPENSSL_TAR}安装... \033[0m"
sleep 2
make || exit
make install || exit

# 添加链接库
echo "${OPENSSL_PATH}/lib" >> /etc/ld.so.conf
ldconfig

# 拷贝程序
mv /usr/bin/openssl{,_backup_`date "+%Y%m%d"`}
/bin/cp -f  ${OPENSSL_PATH}/bin/openssl /usr/bin/openssl



mv /etc/ssh{,_backup_`date "+%Y%m%d"`}

echo -e "\033[32m ${OPENSSH_TAR}校验... \033[0m"
sleep 2
cd ${OPENSSH_TAR%.*.*}
./configure --prefix=${OPENSSH_PATH} --sysconfdir=/etc/ssh --with-ssl-dir=${OPENSSL_PATH} --with-zlib=${ZLIB_PATH} || exit

echo -e "\033[32m ${OPENSSH_TAR}安装... \033[0m"
sleep 2
make || exit
make install || exit

# 拷贝程序
cd ${OPENSSH_PATH}/bin
for obj in $(ls); do
    mv /usr/bin/${obj}{,_backup_`date "+%Y%m%d"`}
    /bin/cp -f ${OPENSSH_PATH}/bin/${obj} /usr/bin/${obj}
done

cd ${OPENSSH_PATH}/sbin
for obj in $(ls); do
    mv /usr/sbin/${obj}{,_backup_`date "+%Y%m%d"`}
    /bin/cp -f ${OPENSSH_PATH}/sbin/${obj} /usr/sbin/${obj}
done

# 登录选项
echo "
PermitRootLogin yes
PubkeyAuthentication yes
PasswordAuthentication yes
X11Forwarding yes
" >> /etc/ssh/sshd_config

# 启动服务设置
rm -rf /usr/lib/systemd/system/sshd.service 
/bin/cp -fp ${OPENSSH_TAR%.*.*}/contrib/redhat/sshd.init /etc/init.d/sshd
chmod +x /etc/init.d/sshd
systemctl daemon-reload
chkconfig --add sshd
chkconfig sshd on

systemctl restart sshd.service

if [ $? == 0 ]; then
    Remove
    echo -e "\033[32m openssh更新成功 \033[0m"
else
    echo -e "\033[31m openssh更新失败 \033[0m"
fi
