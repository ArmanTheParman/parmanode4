#!/bin/bash

unset test_all_passed

#source files
for file in $HOME/parman_programs/parmanode4/src/**/*.sh ; do
source $file
done
parmanode_variables

function swwtest {
echo -e "Something went wrong \n$1\n\nHit <enter> to continue\n q to exit."
read choice
export test_all_passed="false"
case $choice in x|q) exit ;; esac
}

########################################################################################################################

clear
echo -e "Testing installation. Please wait..." ; sleep 1.5

docker ps >$dn || { echo -e "\n    Docker not detected. Either it didn't install properly, or the
    the computer needs a little reboot. Hit <enter> to continue tests." ; read ; }

test -d $HOME/parman_programs || swwtest "no parman_programs"
test -d $HOME/parman_programs/parmanode4 || swwtest "no parman_programs/parmanode4"
test -d $HOME/.parmanode4 || swwtest "no $HOME/.parmanode4"
sudo test -d $wwwparmaviewdir || swwtest "no $wwwparmaviewdir"

[[ $(uname) == "Darwin" ]] && ! which brew && { echo -e "HomeBrew not detected. Maybe try installing it yourself. 
    Hit <enter> to continue tests." ; read ; }

which netcat >$dn 
which jq
which vim
which tmux
which tor
which gsed
sudo which nginx

[[ $OS == "Linux" ]] && { sudo ls /usr/sbin/fcgiwrap >$dn 2>&1 || swwtest "fcgiwrap not detected." ; }