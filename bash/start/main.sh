function main {            

#source files
for file in $HOME/parman_programs/parmanode4/bash/**/*.sh ; do
source $file
done

debug_startup "Pause beggining of main"

#source_premium

#source variables
load_parmanode_variables $@ #check_architecture, add in function later
source $pc
source $ic



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
