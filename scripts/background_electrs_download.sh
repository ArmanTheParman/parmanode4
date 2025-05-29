#!/bin/bash

#Executed by service file - starts AFTER bitcoin downloaded.
#Downloads Electrs and compiles
# if pruning, electrs will still download and compile, but won't run - need warning to user.

function make_socat_service {

echo "[Unit]
Description=Socat SSL to TCP Forwarding Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/socat OPENSSL-LISTEN:50006,reuseaddr,fork,cert=$HOME/.electrs/cert.pem,key=$HOME/.electrs/key.pem,verify=0 TCP:127.0.0.1:50005
Restart=on-failure
RestartSec=10
KillMode=process

[Install]
WantedBy=multi-user.target
" | sudo tee /etc/systemd/system/parmanode/socat.service >$dn 2>&1

sudo systemctl daemon-reload >$dn 2>&1
sudo systemctl enable socat.service >$dn 2>&1
sudo systemctl start socat.service >$dn 2>&1
}

#Begin...

export electrsversion="v0.10.9"

if jq '.parmanode' $pc | grep "elects_downloaded" $pj | grep -q true ; then exit ; fi
jq '.parmanode += {electrs_download: started}' $pj >$pj.tmp && mv $pj.tmp $pj

make_socat_service
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

