# 安装Mysql

## windows下安装mysql，进入mysql/bin

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

## linux下安装mysql

    1.安装mysql
    sudo dnf install @mysql

    2.服务开机自启
    sudo systemctl enable --now mysqld

    3.添加密码及安全设置
    sudo mysql_secure_installation

    # 要求你配置验证密码组件。=>y
    # 选择密码验证策略等级。=>0
    # 输入新密码两次
    # 确认是否继续使用提供的密码？=>y
    # 移除匿名用户？=>y
    # 不允许root远程登陆？=>n
    # 移除test数据库？=>y
    # 重新载入权限表？=>y

    4.登陆mysql
    mysql -u root -p

    5.将root用户的host字段设为'%'
    use mysql;
    update user set host='%' where user='root';
    flush privileges;

    6.关闭防火墙
    sudo firewall-cmd --add-port=3306/tcp --permanent
    sudo firewall-cmd --reload

    7.关闭MySQL主机查询dns
    #打开/etc/my.cnf
    [mysqld]
    skip-name-resolve

    8.重启服务
    sudo systemctl restart mysqld
