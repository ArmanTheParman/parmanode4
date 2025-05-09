function uninstall_parmanode4 {

yesorno "Are you sure you want to uninstall Parmanode4? You will first have the option to remove installed programs" || return 1

uninstall_apps || return 1

sudo rm -rf $dp
sudo rm -rf $pn4

#uninstall_cgi
    sudo umount $wwwparmaviewdir && sudo rm -rf $wwwparmaviewdir
    sudo rm -rf $parmaviewnginx
    [[ $(uname) == "Darwin" ]] || { 
        sudo systemctl restart nginx 
        sudo systemctl disable fcgiwrap >$dn 
        sudo rm -rf /etc/systemd/system/fcgiwrap.service.d 
        sudo systemctl daemon-reload
    }

#clean up bashrc/zshrc
#unmount
#clearn up crontab

#stop connections
tmux kill-session -t ws1


success "Parmanode4 has been uninstalled"
return 0
}