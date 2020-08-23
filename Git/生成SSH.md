# 生成ssh

## ssh

    ssh-keygen -t rsa -C "12345@qq.com"
    cat ~/.ssh/id_rsa.pub
    ssh -T git@github.com

## config文件

    Host github.com
    User 12345@qq.com
    Hostname ssh.github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa
    Port 443
