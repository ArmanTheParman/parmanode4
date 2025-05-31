function make_background_bitcoin_download_service {
if [[ $(uname) == "Darwin" ]] ; then return 0 ; fi

cat <<EOF | sudo tee /etc/systemd/system/parmanode_bitcoin_install.service >$dn 2>&1
[Unit]
Description=Download Bitcoin Client
After=network.target

[Service]
ExecStart=$HOME/parman_programs/parmanode4/scripts/background_bitcoin_download.sh
KillMode=process
User=$USER
Group=$USER

[Install]
WantedBy=parmanode.target         
EOF

sudo ln -s /etc/systemd/system/parmanode_bitcoin_install.service /etc/systemd/system/parmanode.target.wants/parmanode_bitcoin_install.service >$dn 2>&1
sudo systemctl daemon-reload
}