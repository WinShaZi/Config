# 升级Git

    1.编辑
    vim /etc/yum.repos.d/wandisco-git.repo

    2.写入
    [wandisco-git]
    name=Wandisco GIT Repository
    baseurl=http://opensource.wandisco.com/centos/7/git/x86_64/
    enabled=1
    gpgcheck=1
    gpgkey=http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco

    3.导出密钥
    sudo rpm --import http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco

    4.安装
    sudo yum install git
