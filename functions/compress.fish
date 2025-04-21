#!/usr/bin/env fish
function compress
    # 检查参数
    if test (count $argv) -ne 1
        echo "Usage: compress <file>"
        return 1
    end

    set file $argv[1]

    # 检查文件是否存在
    if not test -f $file
        echo "File does not exist: $file"
        return 1
    end

    # 获取文件名并去除扩展名作为默认文件夹名
    set filename (basename $file)
    set name (string replace -r '\.(tar\.gz|tar\.bz2|tar\.xz|zip|gz|bz2|xz|7z|rar|tar)$' '' $filename)

    # 提示用户是否使用默认的文件夹名称，或自定义名称
    echo "Default folder name: $name"
    echo -n "Enter a custom folder name (or press Enter to use default): "
    set custom_name (read)

    # 如果用户输入了自定义名称，使用自定义名称
    if test -n "$custom_name"
        set name $custom_name
    end

    # 创建文件夹
    mkdir -p $name

    # 解压文件
    switch $file
        case "*.tar.gz"
            tar -xzf $file -C ../  # 解压到上一级目录
        case "*.tar.bz2"
            tar -xjf $file -C ../  # 解压到上一级目录
        case "*.tar.xz"
            tar -xJf $file -C ../  # 解压到上一级目录
        case "*.zip"
            unzip -q $file -d ../  # 解压到上一级目录
        case "*.gz"
            gunzip -c $file > ../(basename $file .gz)  # 解压到上一级目录
        case "*.bz2"
            bunzip2 -c $file > ../(basename $file .bz2)  # 解压到上一级目录
        case "*.xz"
            unxz -c $file > ../(basename $file .xz)  # 解压到上一级目录
        case "*.7z"
            7z x $file -o../  # 解压到上一级目录
        case "*.rar"
            unrar x $file ../  # 解压到上一级目录
        case "*.tar"
            tar -xf $file -C ../  # 解压到上一级目录
        case '*'
            echo "Unsupported file type: $file"
            return 1
    end
end

