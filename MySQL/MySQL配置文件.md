# 配置文件

## window配置文件，放到bin同级目录下保存为my.ini

    [mysqld]
    # 设置3306端口
    port = 3306

    # 自定义设置mysql的安装目录，即解压mysql压缩包的目录
    basedir = C:\Develop\mysql-8.0.21-winx64

    # 自定义设置mysql数据库的数据存放目录
    datadir = C:\Develop\mysql-8.0.21-winx64\data

    # 允许最大连接数
    max_connections = 200

    # 允许连接失败的次数
    max_connect_errors = 10

    # 服务端使用的字符集默认为UTF8
    character-set-server = utf8

    # 创建新表时将使用的默认存储引擎
    default-storage-engine = INNODB

    # 默认使用“mysql_native_password”插件认证
    default_authentication_plugin = mysql_native_password

    # 设置输出路径
    secure_file_priv =

    [mysql]
    # 设置mysql客户端默认字符集
    default-character-set=utf8

    [client]
    # 设置mysql客户端连接服务端时默认使用的端口和默认字符集
    port=3306
    default-character-set=utf8

## CentOS配置文件，/etc/my.cnf

    [mysqld]
    basedir = /usr/local/mysql
    datadir = /usr/local/mysql/data
    socket = /tmp/mysql.sock
    user = lyh
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

    [client]
    port = 3306
    default-character-set = utf8mb4
    socket = /tmp/mysql.sock

    [mysql]
    # 开始自动补全
    auto-rehash

    [mysqld_safe]
    # 指定错误日志路径
    log-error = /var/log/mysqld.log
    # 指定pid路径
    pid-file = /var/run/mysqld/mysqld.pid
