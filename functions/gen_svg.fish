function gen_svg --wraps='' --description 'make verilog into .svg graph with colorized wires'
    set verilog_file $argv[1]

    if test -z "$verilog_file"
        echo "用法: gen_svg your_file.v"
        return 1
    end

    if not test -f $verilog_file
        echo "文件不存在: $verilog_file"
        return 1
    end

    if string match -q '*.sv' $verilog_file
        sv2v $verilog_file > (basename $verilog_file .sv).v
        set verilog_file (basename $verilog_file .sv).v
    end

    set base_name (basename $verilog_file .v)
    set top_module $base_name
    set json_file $base_name.json
    set svg_file $base_name.svg
    set temp_v_file "__tmp_$base_name.v"

    for tool in yosys netlistsvg awk sed xdg-open
        if not type -q $tool
            echo "缺少工具: $tool"
            return 1
        end
    end

    # Step 0: 屏蔽仿真系统任务
    sed '/\$(fopen\|fclose\|fread\|fwrite\|fdisplay\|fscanf\|feof\|rewind\|display\|monitor\|write\|strobe\|readmemh\|readmemb\|time\|stop\|finish)/d' $verilog_file > $temp_v_file

    # Step 1: Yosys生成JSON
    yosys -p "read_verilog $temp_v_file; hierarchy -check -top $top_module; proc; opt; write_json $json_file"
    if test $status -ne 0
        echo "Yosys 处理失败，请检查 Verilog 文件中是否有非法或不支持的语法。"
        rm -f $temp_v_file
        return 1
    end

    # Step 2: 生成SVG
    netlistsvg $json_file -o $svg_file
    if not test -f $svg_file
        echo "netlistsvg 生成失败，SVG 文件未创建。"
        rm -f $temp_v_file
        return 1
    end

    # Step 3: 添加白底
    if not grep -q '<rect width="100%" height="100%" fill="white"/>' $svg_file
        sed -i 's|<svg[^>]*>|&\n  <rect width="100%" height="100%" fill="white"/>|' $svg_file
    end

    # Step 4: 彩色路径着色
    awk '
    function randcolor() {
        r = int(rand() * 256)
        g = int(rand() * 256)
        b = int(rand() * 256)
        return sprintf("#%02x%02x%02x", r, g, b)
    }
    BEGIN { srand() }
    {
        if ($0 ~ /<(path|line|polyline)[^>]*>/) {
            if ($0 ~ /stroke="/) {
                sub(/stroke="[^"]*"/, "stroke=\"" randcolor() "\"")
            } else {
                sub(/<[^ >]+ /, "&stroke=\"" randcolor() "\" ")
            }
        }
        print
    }
    ' $svg_file > $svg_file.tmp && mv $svg_file.tmp $svg_file

    # Step 5: 打开 SVG
    xdg-open $svg_file &

    # 清理临时文件
    rm -f $temp_v_file
end

