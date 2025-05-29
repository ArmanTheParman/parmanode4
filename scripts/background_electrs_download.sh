#!/bin/bash
source $HOME/parman_programs/parmanode4/src/config/parmanode_variables.sh
parmanode_variables

#Executed by service file - starts AFTER bitcoin downloaded.
#Downloads Electrs and compiles
# if pruning, electrs will still download and compile, but won't run - need warning to user.
# socat service for SSL communication made when parmanode installed

export electrsversion="v0.10.9"
mkdir -p $HOME/.electrs #for certificates and config file
#make symlink for database directory later when user installs electrs. This is just background download and compile.

if jq '.parmanode' $pc | grep "elects_downloaded" $pj | grep -q true ; then exit ; fi
jq '.parmanode += {electrs_download: started}' $pj >$pj.tmp && mv $pj.tmp $pj

cd $hpa && git clone --branch $electrsversion --single-branch https://github.com/romanz/electrs 
cd $hpa/electrs && cargo build --locked --release 

if [[ ! -e "$hpa/electrs/target/release/electrs" ]] ; then
    echo "$(date) - electrs compile failed, no $HOME/parmanode/electrs/target/releases/electrs file" | tee -a $HOME/.parmanode/errors/electrs.error
    exit
fi

cd $HOME/.electrs/
openssl req -newkey rsa:2048 -nodes -x509 -keyout key.pem -out cert.pem -days 36500 -subj "/C=/L=/O=/OU=/CN=$IP/ST/emailAddress=/" >$dn 2>&1

# choose_and_prepare_drive - this can be done when user wants to install.
# Do later: 
#       mkdir -p $pd/electrs_db
#       sudo chown -R $USER $parmanode_drive/electrs_db >$dn 2>&1
#       prepare_drive_electrs - make symlink if using external drive

cat<<'EOF' | tee -a $HOME/.elects/config.toml
daemon_rpc_addr = "127.0.0.1:8332"
daemon_p2p_addr = "127.0.0.1:8333"
db_dir = "CHANGETHIS"
network = "bitcoin"
electrum_rpc_addr = "0.0.0.0:50005"
log_filters = "INFO" # Options are ERROR, WARN, INFO, DEBUG, TRACE
auth = "parman:parman"
EOF
gsed -i "s/CHANGETHIS/$HOME\/.electrs_db/" $HOME/.electrs/config.toml

jq 'del(.parmanode.electrs_download)' $pj >$pj.tmp && jq '.parmanode += {electrs_downlaoded: true}' $pj.tmp >$pj && rm $pj.tmp
