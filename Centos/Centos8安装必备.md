# 安装必备

## 配置固定IP

    1.打开VMware->编辑->虚拟网络编辑器

    2.选择VMnet8，取消勾选“使用本地DHCP服务将IP地址分配给虚拟机”

    3.记录子网IP，子网掩码，网关

    4.打开控制面板->网络和Internet->网络和共享中心->更改适配器设置->VMnet8->属性->Internet协议4，保证IP地址与子网IP同一网段

    5.sudo vi /etc/sysconfig/network-scripts/ifcfg-ens33，修改如下信息
    BOOTPROTO=static
    ONBOOT=yes
    IPADDR=与子网IP同一网段
    NETMASK=子网掩码
    GATEWAY=网关

## 配置终端快捷键

    名  称：Terminal
    命  令：/usr/bin/gnome-terminal
    快捷键：Ctrl+Tab

## vim配置

    "放在~下保存为.vimrc或者在/ect/vimrc中添加

    set nocompatible

    syntax on " 自动语法高亮

    set number " 显示行号
    set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4
    set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格
    set tabstop=4 " 设定 tab 长度为 4
    set autochdir " 自动切换当前目录为当前文件所在的目录
    set autoindent
    set smartindent " 开启新行时使用智能自动缩进
    set cindent " c风格缩进

    imap{ {}<ESC>i
    imap[ []<ESC>i
    imap( ()<ESC>i
    inoremap ' ''<ESC>i
    inoremap " ""<ESC>i

## 添加下载源

    sudo yum install -y epel-release

## 安装tweaks

    sudo yum install -y gnome-tweaks

## 安装gcc

    sudo yum install -y gcc gcc-c++ gdb kernel-devel

## 安装git

    sudo yum install -y git

## 安装nafs

    sudo yum install -y ntfs-3g

## 安装中文输入

    # 安装完重启生效
    sudo yum install -y ibus-libpinyin.x86_64
