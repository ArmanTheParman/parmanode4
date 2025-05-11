function signal_wait {

while [[ ! -f "/tmp/parmanode_signals/$1" ]] ; do 
    sleep 0.35 
done
return 0
}


function enter_continue_button {
mkdir -p /tmp/parmanode_signals
rm /tmp/parmanode_signals/enter 2>/dev/null
#to do ; render_button enter_continue 
#to do ; send html to websocket -- code reqeusts delete 'enter signal file' when clicked
}