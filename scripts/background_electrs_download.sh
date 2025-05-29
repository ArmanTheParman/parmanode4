#!/bin/bash

#Executed by service file - starts AFTER bitcoin downloaded.
#Downloads Electrs and compiles
# if pruning, electrs will still download and compile, but won't run - need warning to user.



#Begin...

export electrsversion="v0.10.9"

if jq '.parmanode' $pc | grep "elects_downloaded" $pj | grep -q true ; then exit ; fi
jq '.parmanode += {electrs_download: started}' $pj >$pj.tmp && mv $pj.tmp $pj

source $HOME/parman_programs/parmanode4/src/services/make_socat_service

build_dependencies_electrs 
download_electrs 
compile_electrs 
make_ssl_certificates "electrs" 
choose_and_prepare_drive "Electrs" 
mkdir -p $pd/electrs_db
sudo chown -R $USER $parmanode_drive/electrs_db >$dn 2>&1
prepare_drive_electrs 
make_electrs_config 
make_electrs_service 
installed_config_add "electrs-end" 

