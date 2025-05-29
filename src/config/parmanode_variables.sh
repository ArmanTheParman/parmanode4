#keep this function free of custom functions in other places, unless sourcing from here.
function parmanode_variables {

#system
export dn=/dev/null
export bashversionmajor=$(bash --version | head -n1 | cut -d \. -f 1 | grep -Eo '[0-9]+')
export bashversion=$(bash --version | head -n1 | awk '{print $4}' | sed -nE 's/.*([0-9]+\.[0-9]+\.[0-9]+).*/\1/p')
export chip="$(uname -m)" 

if   [[ $(uname) == "Darwin" ]] ; then
         export computer_type=Mac
elif sudo grep "Model" /proc/cpuinfo | grep -q "Raspberry" ; then 
         export computer_type=Pi 
else 
         export computer_type=LinuxPC
fi


if [[ -e /.dockerenv ]] ; then #docker container detected
    export IP=$( ip a | grep "inet" | grep 172 | awk '{print $2}' | cut -d '/' -f 1 | head -n1 )
else 
    export IP=$( ip a | grep "inet " | grep -v 127.0.0.1 | grep -v 172.1 | awk '{print $2}' | cut -d '/' -f 1 | head -n1 )
fi

#OS specific
if [[ $(uname) == "Linux" ]] ; then
    export OS="Linux"
    export macprefix=""
    export parmanode_drive="/media/$USER/parmanode"
    export bashrc="$HOME/.bashrc"
    export torrc="/etc/tor/torrc"
    export varlibtor="/var/lib/tor"

elif [[ $(uname) == "Darwin" ]] ; then
    export OS="Mac"
    export macprefix="$(brew --prefix 2>/dev/null)" ; if [[ -z $macprefix ]] ; then export macprefix="/usr/local" ; fi
    export parmanode_drive="/Volumes/parmanode"
    export bashrc="$HOME/.zshrc"
    export torrc="$macprefix/etc/tor/torrc"
    export varlibtor="$macprefix/var/lib/tor"
fi

#parmanode4 dirs
export pp=$HOME/parman_programs
export dp=$HOME/.parmanode4
export dpe=$dp/errors
export hp=$HOME/parmanode4_apps
export hpa=$hp
export pn=$pp/parmanode4
export pn4=$pn
export pd=$parmanode_drive

#parmanode4 jsons/confs
export pdc=$dp/config/parmadrive.conf
export pj=$dp/config/parmanode.json
export ij=$dp/config/installed.json
export oj=$dp/config/overview.json
export hm=$dp/config/hide_messages.json

#parmanode logs
export debug=$dp/debug.log

#Bitcoin
export b=$HOME/.bitcoin
export bc=$db/bitcoin.conf

#Fulcrum
export fc=$HOME/.fulcrum/fulcrum.conf

#Nostr 
export nk=$dp/.nostr_keys/nostr_keys.txt
export nkd=$dp/.nostr_keys

#Nginx
export parmaviewnginx="$macprefix/etc/nginx/conf.d/parmaview.conf"

#Parmaview
export wwwparmaviewdir="$macprefix/var/www/parmaview"
}