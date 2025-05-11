#!/bin/bash

source $HOME/parman_programs/parmanode4/bash/config/parmanode_variables.sh

yesorno "Are you sure you want to uninstall Parmanode4? You will first have the option to remove installed programs" || return 1

#uninstall_apps || return 1

sudo rm -rf $HOME/.parmanode4
sudo rm -rf $HOME/parman_programs/parmanode4

#uninstall_cgi
    sudo umount $wwwparmaviewdir && sudo rm -rf $wwwparmaviewdir
    sudo rm -rf $parmaviewnginx
    if [[ $(uname) == "Linux" ]] ; then 
        sudo rm -rf /etc/systemd/system/fcgiwrap.service.d 
        sudo systemctl disable fcgiwrap >$dn 
        sudo systemctl daemon-reload
        sudo systemctl restart nginx 
    elif [[ $(uname == "Darwin" ]] ; then 
        sudo rm -rf $macprevix

        
#clean up bashrc/zshrc
#unmount
#clearn up crontab

#stop connections
tmux kill-session -t ws1


success "Parmanode4 has been uninstalled"
return 0
}