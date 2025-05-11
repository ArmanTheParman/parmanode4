function uninstall_parmanode4 {

#source files
for file in $HOME/parman_programs/parmanode4/src/**/*.sh ; do
source $file
done
parmanode_variables

test -d $HOME/parman_programs/parmanode4 || { echo -e "\nParmanode4 wasn't found.\n" ; sleep 1.5 ; exit ; }

yesorno "Are you sure you want to uninstall Parmanode4? 
    You will first have the option to remove installed programs" || return 1

#uninstall_apps || return 1

sudo rm -rf $HOME/.parmanode4
sudo rm -rf $HOME/parman_programs/parmanode4
sudo test -L /usr/bin/gsed && sudo rm /usr/bin/gsed

#uninstall_cgi
    sudo umount $wwwparmaviewdir 2>$dn && sudo rm -rf $wwwparmaviewdir 2>$dn
    sudo rm -rf $parmaviewnginx 2>$dn

    if [[ $(uname) == "Linux" ]] ; then 
        sudo rm -rf /etc/systemd/system/fcgiwrap.service.d 
        sudo systemctl disable fcgiwrap >$dn 
        sudo systemctl daemon-reload
        sudo systemctl restart nginx 
    fi
        
#clean up bashrc/zshrc
if [[ $(uname) == "Linux" ]] ; then
sed -i '/#ADDED by Parmanode4 ...start flag/,/#ADDED by Parmanode4 ...end flag/d' $HOME/.bashrc >$dn 2>&1
else
sed -i '/#ADDED by Parmanode4 ...start flag/,/#ADDED by Parmanode4 ...end flag/d' $HOME/.bashrc#unmount >$dn 2>&1
fi

#clearn up crontab

sudo rm -rf $HOME/tmp_parmanode
rm $HOME/Desktop/parmanode4_info.txt 2>$dn

#stop connections
tmux kill-session -t ws1 2>$dn

echo -e "\n\nParmanode4 has been uninstalled\n\n"
sleep 1.5
return 0
}