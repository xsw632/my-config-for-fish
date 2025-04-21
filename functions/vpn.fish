#!/usr/bin/env fish

function vpn
    ~/Downloads/Clash/cfw > /dev/null 2>&1 &
    gsettings set org.gnome.system.proxy mode 'manual'

end
