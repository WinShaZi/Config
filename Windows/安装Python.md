# 安装Python

    1.全选定制化安装Python安装程序

    2.python --version 验证python是否安装成功

    3.pip list 验证pip是否完整

    4.python -m pip install --upgrade pip 更新pip

    5.pip install flake8 安装flake8

    6.pip install yapf 安装yapf

    7.在vscode安装python插件

    8.在配置中写入
    "python.linting.flake8Enabled": true,
    "python.formatting.provider": "yapf",
    "python.formatting.yapfArgs": [
        "--style",
        "{column_limit: 248}"
    ],
    "python.linting.flake8Args": [
    "--max-line-length=248"
    ],
    "python.linting.pylintEnabled": false,
