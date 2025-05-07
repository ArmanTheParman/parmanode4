function uninstall_parmanode4 {

yesorno "Are you sure you want to uninstall Parmanode4? You will first have the option to remove installed programs" || return 1

uninstall_apps || return 1

sudo rm -rf $dp
sudo rm -rf $pn4

#remove bind mount
sudo unmount $macprefix/var/www/parmanode_cgi 

#clean up bashrc/zshrc
#unmount
#clearn up crontab

success "Parmanode4 has been uninstalled"
return 0
}