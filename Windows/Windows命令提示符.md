# 生成右键命令提示符（管理员模式），保存为.reg

    Windows Registry Editor Version 5.00

    ; 若原先有，先删除原来的
    [-HKEY_CLASSES_ROOT\Directory\Background\shell\runas]

    ; 1.右键：命令行 @后为显示名字，icon为图标
    [HKEY_CLASSES_ROOT\Directory\Background\shell\runas]
    "Icon"="C:\\windows\\system32\\cmd.exe"

    [HKEY_CLASSES_ROOT\Directory\Background\shell\runas]
    "ShowBasedOnVelocityId"=dword:00639bc8
 
    [HKEY_CLASSES_ROOT\Directory\Background\shell\runas\command]
    @="cmd.exe /s /k pushd \"%V\""
