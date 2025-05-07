function main {                 debug_startup "Pause beggining of main"

#check files and directories exist
[[ -e $HOME/parman_programs ]] || mkdir -p $HOME/parman_programs
[[ -e $HOME/.parmanode4 ]]     || mkdir -p $HOME/.parmanode4
[[ -e $HOME/.parmanode4/installed.conf ]]     || mkdir -p $HOME/.parmanode4/installed.conf
[[ -e $HOME/.parmanode4/parmanode.conf ]]     || mkdir -p $HOME/.parmanode4/parmanode.conf
[[ -e $HOME/.parmanode4/parmanode.log ]]      || mkdir -p $HOME/.parmanode4/parmanode.log
[[ -e $HOME/.parmanode4/debug.log ]]          || mkdir -p $HOME/.parmanode4/debug.log

#source files
for file in $HOME/parman_programs/parmanode4/bash/**/*.sh ; do
source $file
done

#source_premium

#source variables
load_parmanode_variables $@ #check_architecture, add in function later
source $pc
source $ic

#check programs exist, and install
intsall_brew || sww
install_git  || sww
install_curl || sww
gsed_symlink || sww
bash_version_check || sww
install_parmashedll || sww

#Deactivate stray virtual environments
deactivate >/dev/null 2>&1


#Apply patches


#run counter

clean_exit #trap conditions
motd
custom_startup && exit
menu_main
exit
}
