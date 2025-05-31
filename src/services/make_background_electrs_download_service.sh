function make_background_electrs_download_service {

if [[ $(uname) == "Darwin" ]] ; then return 0 ; fi

cat <<EOF | sudo tee /etc/systemd/system/parmanode/electrs_download.service >$dn 2>&1
[Unit]
Description=Download Electrs Server
After=network.target

[Service]
ExecStart=$HOME/parman_programs/parmanode4/scripts/background_electrs_download.sh
KillMode=process
User=$USER
Group=$USER

[Install]
WantedBy=parmanode.target         
EOF

sudo ln -s /etc/systemd/system/parmanode/electrs_download.service /etc/systemd/system/parmanode.target.wants/electrs_download.service >$dn 2>&1
sudo systemctl daemon-reload
}