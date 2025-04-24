#!/usr/bin/env fish

function fold
	return;
    # 检查参数数量是否正确
    if test (count $argv) -ne 1
        echo "Usage: zip_folder <folder>"
        return 1
    end

    set folder $argv[1]

    # 检查文件夹是否存在
    if not test -d $folder
        echo "Folder does not exist: $folder"
        return 1
    end

    # 获取文件夹名称（去掉路径）
    set folder_name (basename $folder)

    # 生成默认的压缩文件名
    set default_zip_name "$folder_name.zip"

    # 提示用户输入自定义压缩文件名
    echo "Default zip file name: $default_zip_name"
    echo -n "Enter a custom zip file name (or press Enter to use default): "
    read custom_zip_name

    # 如果用户输入了自定义文件名，则使用它；否则使用默认文件名
    if test -n "$custom_zip_name"
        set zip_name "$custom_zip_name"
    else
        set zip_name "$default_zip_name"
    end

    # 确保文件名以 .zip 结尾
    if not string match -q "*.zip" $zip_name
        set zip_name "$zip_name.zip"
    end

    # 检查目标压缩文件是否已存在
    if test -f $zip_name
        echo "File already exists: $zip_name"
        echo -n "Overwrite? (y/N): "
        read overwrite
        if test "$overwrite" != "y" -a "$overwrite" != "Y"
            echo "Operation cancelled."
            return 1
        end
    end

    # 执行压缩操作
    echo "Compressing folder '$folder' into '$zip_name'..."
    zip -r -q $zip_name $folder

    # 检查压缩是否成功
    if test $? -eq 0
        echo "Compression successful: $zip_name"
    else
        echo "Compression failed."
        return 1
    end
end
