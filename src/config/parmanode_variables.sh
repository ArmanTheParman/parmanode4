function parmanode_variables {

#system
export dn=/dev/null
export bashversionmajor=$(bash --version | head -n1 | cut -d \. -f 1 | grep -Eo '[0-9]+')
export bashversion=$(bash --version | head -n1 | awk '{print $4}' | sed -nE 's/.*([0-9]+\.[0-9]+\.[0-9]+).*/\1/p')

#OS specific
if [[ $(uname) == "Linux" ]] ; then
    export macprefix=""
    export parmanode_drive="/media/$USER/parmanode"
    export bashrc="$HOME/.bashrc"
    export torrc="/etc/tor/torrc"
    export varlibtor="/var/lib/tor"

elif [[ $(uname) == "Darwin" ]] ; then
    export macprefix="$(brew --prefix 2>/dev/null)" ; if [[ -z $macprefix ]] ; then export macprefix="/usr/local" ; fi
    export parmanode_drive="/Volumes/parmanode"
    export bashrc="$HOME/.zshrc"
    export torrc="$macprefix/etc/tor/torrc"
    export varlibtor="$macprefix/var/lib/tor"
fi

#parmanode4 dirs
export pp=$HOME/parman_programs
export dp=$HOME/.parmanode4
export hp=$HOME/parmanode4_apps
export hpa=$hp
export pn=$pp/parmanode4
export pd=$parmanode_drive

#parmanode4 jsons/confs
export pdc=$dp/parmadrive.conf
export pj=$dp/parmanode.json
export ij=$dp/installed.json
export oj=$dp/overview.json
export hm=$dp/hide_messages.json

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