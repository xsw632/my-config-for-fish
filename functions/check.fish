#!/usr/bin/env fish
function check
for i in $argv
    printf "%s: " $i
    if string match -q "*.o" $i
        echo OBJ file
    else if string match -q "*.f" $i || string match -q "*.c" $i
        echo SRC file
    else
        echo other file
    end
end
end
