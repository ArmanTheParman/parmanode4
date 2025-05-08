#!/usr/bin/env bash

if [[ $1 == x ]] ; then set -x ; fi
#bash version
[[ $cgi == "true" ]] || export bashV_major=$(bash --version | head -n1 | cut -d \. -f 1 | grep -Eo '[0-9]+')

printf "$orange
############################################################$blue
                  P A R M A N O D E 4$orange
############################################################

  Good call on installing Parmanode. This installation 
  will add a few directories and files here and there, 
  and also install some programs that are necessary for 
  Parmanode to function. You will be asked to confirm 
  on the next page.

  If Parmanode3 is installed on your machine, Parmanode4
  will detect that, and any programs you have installed 
  with it, and migrate them across.
    
  Once that is done, Parmanode4 will Remove Parmanode3 
  for you. If you ever lose your mind and uninstall 
  Parmanode4, it will leave your machine nice and clean.

############################################################
  Hit <enter> to continue or 'q' and <enter> to quit
############################################################
"
read

#check files and directories exist
[[ -e $HOME/parman_programs ]]                || mkdir -p $HOME/parman_programs
[[ -e $HOME/.parmanode4 ]]                    || mkdir -p $HOME/.parmanode4
[[ -e $HOME/.parmanode4/installed.conf ]]     || mkdir -p $HOME/.parmanode4/installed.conf
[[ -e $HOME/.parmanode4/parmanode.conf ]]     || mkdir -p $HOME/.parmanode4/parmanode.conf
[[ -e $HOME/.parmanode4/parmanode.log ]]      || mkdir -p $HOME/.parmanode4/parmanode.log
[[ -e $HOME/.parmanode4/debug.log ]]          || mkdir -p $HOME/.parmanode4/debug.log
[[ -e $HOME/.parmanode4/temp ]]               || mkdir -p $HOME/.parmanode4/temp


#check programs exist, and print form...
#reponse from form creates json. Each install command below checks the json.
install_docker || sww
restart_after_docker_install
intsall_brew || sww
install_git  || sww
install_curl || sww
gsed_symlink || sww
install_python || sww
install_pip || sww
install_websockets || sww
bash_version_check || sww
install_parmashell || sww

cat <<EOF

Docker    Installed?
Brew      N/A
Git
Curl
gsed
python
pip
websockets
jq
netcat-traditional
vim
net-tools
unzip
tmux
ssh
tor
ufw
mdadm
e2fsprogs
tune2fs
fuse3
libfuse2
EOF