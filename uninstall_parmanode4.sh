#!/bin/bash
#accessed from parmanode.com with:
# curl https://parmanode.com/uninstall_parmanode4 | bash

#source files
for file in $HOME/parman_programs/parmanode4/src/**/*.sh ; do
source $file
done
parmanode_variables

test -d $HOME/parman_programs/parmanode4 || { echo -e "\nParmanode4 wasn't found.\n" ; sleep 1.5 ; exit ; }
clear
echo -e "    Are you sure you want to uninstall Parmanode4?\n    You will first have the option to remove installed programs.

        \r    y) yes, uninstall
        \r    n) no, exit this
" 
read choice < /dev/tty 
case $choice in y) true ;; *) exit ;; esac

clear
echo "Please wait..."

#uninstall_apps || exit 1

sudo rm -rf $HOME/.parmanode4
sudo rm -rf $HOME/parman_programs/parmanode4
sudo test -L /usr/bin/gsed && sudo rm /usr/bin/gsed

#uninstall_cgi
    [[ -n $wwwparmaviewdir ]] && {
    sudo umount $wwwparmaviewdir 2>$dn && sudo rm -rf $wwwparmaviewdir 2>$dn
    sudo rm -rf $parmaviewnginx 2>$dn
    }

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

#reminder to add code to clean up crontab here

sudo rm -rf $HOME/tmp_parmanode >$dn 2>&1
rm $HOME/Desktop/parmanode4_info.txt 2>$dn

#stop connections
tmux kill-session -t ws1 2>$dn

#clean up parmanode.service
if [[ $(uname) == "Linux" ]]  ; then
    ls /etc/systemd/system/parmanode* >$dn 2>&1 | while IFS= read x ; do
        sudo rm -rf $x
    done
fi

echo -e "\n\nParmanode4 has been uninstalled\n\n"
sleep 1.5
exit 0