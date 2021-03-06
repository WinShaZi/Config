#!/bin/bash

yum install -y centos-release-scl
yum install -y devtoolset-8-gcc*

scl enable devtoolset-8 bash
source /opt/rh/devtoolset-8/enable

mv /usr/bin/gcc /usr/bin/gcc_bak
ln -s /opt/rh/devtoolset-8/root/bin/gcc /usr/bin/gcc

mv /usr/bin/g++ /usr/bin/g++_bak
ln -s /opt/rh/devtoolset-8/root/bin/g++ /usr/bin/g++

gcc -v
g++ -v
