# mail命令发送邮件

    1.安装服务
    sudo yum install -y mailx

    2.以网页形式登陆邮箱，开启发送邮箱的SMTP服务

    3.vim /etc/mail.rc，在文件尾加入
    # 发送者邮箱
    set from=12345@qq.com
    # 邮箱服务地址
    set smtp=smtp.qq.com
    # 发送者用户名
    set smtp-auth-user=12345@qq.com
    # 授权码
    set smtp-auth-password=abcdefg
    # 邮件认证的方式
    set smtp-auth=login

    4.发送邮箱
    echo "内容" | mail -s "标题" 1234@qq.com
