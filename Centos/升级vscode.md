# 升级vscode

1. 在/etc/yum.repos.d目录下新建一个code.repo文件

2. 写入如下内容

    ``` repo
    [code]
    name=Visual Studio Code
    baseurl=https://packages.microsoft.com/yumrepos/vscode
    enabled=1
    gpgcheck=1
    gpgkey=https://packages.microsoft.com/keys/microsoft.asc
    ```

3. sudo yum install -y code
