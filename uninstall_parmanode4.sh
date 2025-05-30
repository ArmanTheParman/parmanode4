#!/bin/bash
#accessed from parmanode.com with:
# curl https://parmanode.com/uninstall_parmanode4 | bash

#source files
for file in $HOME/parman_programs/parmanode4/src/**/*.sh ; do
source $file
done
parmanode_variables

test -d $HOME/parman_programs/parmanode4 || { echo -e "\nParmanode4 wasn't found.\n" ; sleep 1.5 ; exit ; }

yesorno "Are you sure you want to uninstall Parmanode4? 
    You will first have the option to remove installed programs" || exit 1
clear
echo "Please wait..."

#uninstall_apps || exit 1

sudo rm -rf $HOME/.parmanode4
sudo rm -rf $HOME/parman_programs/parmanode4
sudo test -L /usr/bin/gsed && sudo rm /usr/bin/gsed

#uninstall_cgi
    sudo umount $wwwparmaviewdir 2>$dn && sudo rm -rf $wwwparmaviewdir 2>$dn
    sudo rm -rf $parmaviewnginx 2>$dn

    if [[ $(uname) == "Linux" ]] ; then 
        sudo rm -rf /etc/systemd/system/fcgiwrap.service.d 2>$dn
        sudo systemctl disable fcgiwrap >$dn 2>&1
        sudo systemctl daemon-reload >$dn 2>&1
        sudo systemctl restart nginx >$dn 2>&1
    fi
        
#clean up bashrc/zshrc
if [[ $(uname) == "Linux" ]] ; then
gsed -i '/#ADDED by Parmanode4 ...start flag/,/#ADDED by Parmanode4 ...end flag/d' $HOME/.bashrc >$dn 2>&1
else
gsed -i '/#ADDED by Parmanode4 ...start flag/,/#ADDED by Parmanode4 ...end flag/d' $HOME/.bashrc#unmount >$dn 2>&1
fi

#clearn up crontab

sudo rm -rf $HOME/tmp_parmanode
rm $HOME/Desktop/parmanode4_info.txt 2>$dn

#stop connections
tmux kill-session -t ws1 2>$dn


#clean up parmanode.service
sudo systemctl stop parmanode.target 2>$dn
sudo rm -rf /etc/systemd/system/parmanode.target
sudo rm -rf /etc/systemd/system/parmanode.target.wants
sudo rm -rf /etc/systemd/system/parmanode
sudo rm /etc/systemd/system/multi-user.target.wants/parmanode.target 

echo -e "\n\nParmanode4 has been uninstalled\n\n"
sleep 1.5
exit 0