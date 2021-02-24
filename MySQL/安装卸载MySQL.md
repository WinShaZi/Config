# 安装卸载Mysql

## 安装

### windows下安装mysql，进入mysql/bin

1.安装服务

    mysqld --install

2.初始化

    mysqld --initialize-insecure --user=mysql

3.启动服务

    net start mysql

4.登陆

    mysql -u root -p

5.更改密码

    alter user 'root'@'localhost' identified by 'Password';

### CentOS下安装mysql

#### tar.xz压缩包

``` shell
#!/bin/bash

BASE_PATH="/usr/local/mysql"
PASS_WORD="asdf"
MYSQL_TAR="$1"

if [ "$(whoami)" != "root" ]; then
    echo -e "\033[31m 请使用root账户\n \033[0m"
    exit
fi

if [ -z ${MYSQL_TAR} ] || [ ! -e ${MYSQL_TAR} ]; then
    echo -e "\033[31m 请输入正确安装包路径 \033[0m"
    exit
fi

# 解压mysql
echo -e "\033[32m 解压${MYSQL_TAR}... \033[0m"
mkdir ${BASE_PATH}
xz -dk ${MYSQL_TAR}
tar -xvf ${MYSQL_TAR%.*}
mv ${MYSQL_TAR%.*.*}/* ${BASE_PATH}
rm -rf ${MYSQL_TAR%.*}
rm -rf ${MYSQL_TAR%.*.*}
echo -e "\033[32m 解压${MYSQL_TAR}成功 \033[0m"

# 赋予必要权限
echo -e "\033[32m 创建mysql用户并赋予必要权限... \033[0m"
if [ $(grep "mysql" /etc/group | wc -l) -eq 0 ]; then
    useradd -r mysql
fi
cd ${BASE_PATH} || exit
mkdir data
chown -R root:mysql ${BASE_PATH}/*
echo -e "\033[32m 创建mysql用户并赋予必要权限成功 \033[0m"

# 安装mysql
echo -e "\033[32m 安装mysql... \033[0m"
${BASE_PATH}/bin/mysqld --initialize --lower-case-table-names=1 --user=mysql --basedir=${BASE_PATH} --datadir=${BASE_PATH}/data

# 添加mysql到系统服务
cp ${BASE_PATH}/support-files/mysql.server /etc/init.d/mysqld
chkconfig --add mysqld

# 更改配置文件
echo "[mysqld]
basedir = ${BASE_PATH}
datadir = ${BASE_PATH}/data
socket = /tmp/mysql.sock
user = mysql
# 端口号为3306
port = 3306
# 默认字符集为utf8mb4
character-set-server = utf8mb4
# 默认储存引擎为InnoDB
default_storage_engine = InnoDB
# 允许最大连接数
max_connections = 256
# 允许连接失败的次数
max_connect_errors = 128
# 输出路径不限
secure_file_priv =
# 不区分大小写
lower_case_table_names = 1
# 开启事件
event_scheduler=ON
# 禁用符号链接
symbolic-links=0
# 跳过验证
skip-grant-tables

[client]
port = 3306
default-character-set = utf8mb4
socket = /tmp/mysql.sock

[mysql]
# 开启自动补全
auto-rehash

[mysqld_safe]
# 指定错误日志路径
log-error = /var/log/mysqld.log
# 指定pid路径
pid-file = /var/run/mysqld/mysqld.pid
" > /etc/my.cnf

# 设置环境变量
if [ $(grep "mysql" /etc/profile | wc -l) -eq 0 ]; then
    echo "export PATH=${PATH}:${BASE_PATH}/bin " >> /etc/profile
fi
. /etc/profile
systemctl restart mysqld.service
echo -e "\033[32m 安装mysql成功 \033[0m"

# 修改密码
echo -e "\033[32m 修改密码... \033[0m"
${BASE_PATH}/bin/mysql -uroot -e "FLUSH privileges;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${PASS_WORD}';
USE mysql;
UPDATE user SET host = '%' WHERE user = 'root';"

# 关闭跳过验证
sed -i 's/skip-grant-tables/\#&/' /etc/my.cnf
systemctl restart mysqld.service
echo -e "\033[32m 修改密码成功 \033[0m"

```

#### rpm压缩包

``` shell
#!/bin/bash

MYSQL_TAR=$1
PASS_WORD="asdf"
MYSQL_PATH="/usr/local/mysql"

if [ "$(whoami)" != "root" ]; then
    echo -e "\033[31m 请使用root账户\n \033[0m"
    exit
fi

if [ -z ${MYSQL_TAR} ] || [ ! -e ${MYSQL_TAR} ]; then
    echo -e "\033[31m 请输入正确安装包路径 \033[0m"
    exit
fi

echo -e "\033[32m 创建mysql安装目录 \033[0m"
mkdir ${MYSQL_PATH}
cp ${MYSQL_TAR} ${MYSQL_PATH}
cd ${MYSQL_PATH}
echo -e "\033[32m 创建mysql安装目录成功\n \033[0m"

echo -e "\033[32m 卸载mariadb中... \033[0m"
listMariadb=$(rpm -qa | grep mariadb)
for item in $listMariadb; do
    rpm -e ${item} --nodeps
done
echo -e "\033[32m 已卸载mariadb\n \033[0m"

echo -e "\033[32m 解压${MYSQL_TAR}中... \033[0m"
tar -xvf ${MYSQL_TAR} || exit
echo -e "\033[32m 解压${MYSQL_TAR}完成\n \033[0m"

echo -e "\033[32m 安装rpm包中... \033[0m"
mysqlRpm=$(ls | grep -E "common-[0-9](.*)rpm$")
rpm -ivh --force --nodeps ${mysqlRpm} || exit
mysqlRpm=$(ls | grep -E "libs-[0-9](.*)rpm$")
rpm -ivh --force --nodeps ${mysqlRpm} || exit
mysqlRpm=$(ls | grep -E "client-[0-9](.*)rpm$")
rpm -ivh --force --nodeps ${mysqlRpm} || exit
mysqlRpm=$(ls | grep -E "server-[0-9](.*)rpm$")
rpm -ivh --force --nodeps ${mysqlRpm} || exit
mysqlRpm=$(ls | grep -E "devel-[0-9](.*)rpm$")
rpm -ivh --force --nodeps ${mysqlRpm} || exit
echo -e "\033[32m rpm包安装完成\n \033[0m"

echo -e "\033[32m mysql初始化中... \033[0m"
mysqld --initialize
chown mysql:mysql /var/lib/mysql -R
systemctl start mysqld.service
systemctl enable mysqld
echo -e "\033[32m mysql初始化完成\n \033[0m"

echo -e "\033[32m mysql更新设置... \033[0m"
password=$(cat /var/log/mysqld.log | grep password | awk -F 'root@localhost: ' '{print $2}')
mysql --connect-expired-password -uroot -p${password} -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${PASS_WORD}'"  || exit
mysql -uroot -p${PASS_WORD} -e "USE mysql;
UPDATE user SET host = '%' WHERE user = 'root';
FLUSH privileges;" || exit
systemctl restart mysqld
echo -e "\033[32m mysql设置更新完成\n \033[0m"

```

## 卸载

### CentOS下卸载mysql

``` shell

```
