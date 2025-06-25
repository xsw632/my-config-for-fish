if status --is-interactive
    # Commanif status --is-interactive
    # Commands to run in interactive sessions can go here

    # 使用 fish_add_path 来安全地添加路径
    fish_add_path /usr/local/vim/bin
    fish_add_path /usr/bin
    fish_add_path /home/mingzhenjia/.local/bin
    fish_add_path /usr/sbin
    fish_add_path /home/mingzhenjia/miniconda3/bin  # 注意这里应该是 miniconda3 的 bin 目录
    fish_add_path /opt/riscv-newlib/bin
    fish_add_path /opt/riscv-linux/bin
    fish_add_path /opt/riscv-qemu/bin
    fish_add_path /opt/riscv/bin
    fish_add_path /home/mingzhenjia/Xilinx/Vivado/2022.2/bin
    fish_add_path /home/mingzhenjia/Xilinx/Vivado/2022.2/lib
    # 设置其他环境变量
    set -gx OPENAI_API_KEY https://mapi.fduer.com/api/v1
    set -gx NVBOARD_HOME /home/mingzhenjia/ysyx-workbench/nvboard
    set -gx NEMU_HOME /home/mingzhenjia/ysyx-workbench/nemu
    set -gx AM_HOME /home/mingzhenjia/ysyx-workbench/abstract-machine
    
    set -x GTK_IM_MODULE ibus
    set -x QT_IM_MODULE ibus
    set -x XMODIFIERS @im=ibus
    set -x IM_MODULE ibus
    #设置wezterm
    set -gx WEZTERM_CONFIG_FILE ~/.config/wezterm/wezterm.lua
    set -gx WEZTERM_CONFIG_DIR ~/.config/wezterm/





    # 别名定义
    alias copy="tmux show-buffer | xclip -sel clip"
    alias config="vim ~/.config/fish/config.fish"
    alias fresh="source ~/.config/fish/config.fish"
    alias vivado="/home/mingzhenjia/Xilinx/Vivado/2023.2/bin/vivado"
    alias nemu="cd ~/ysyx-workbench/nemu"
    alias sdb="cd ~/ysyx-workbench/nemu/src/monitor/sdb/"
    alias func="cd ~/.config/fish/functions/"
    alias surfer="~/surfer_linux/surfer"
    alias sv2v="/home/mingzhenjia/Downloads/sv2v-Linux/sv2v-Linux/sv2v"

end



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/mingzhenjia/miniconda3/bin/conda
    eval /home/mingzhenjia/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/mingzhenjia/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/mingzhenjia/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/mingzhenjia/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<


