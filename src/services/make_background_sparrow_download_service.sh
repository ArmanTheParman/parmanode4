function make_background_sparrow_download_service {

cat <<EOF | sudo tee /etc/systemd/system/parmanode_sparrow_install.service >$dn 2>&1
[Unit]
Description=Download Sparrow
After=network.target

[Service]
ExecStart=$HOME/parman_programs/parmanode4/scripts/background_sparrow_download.sh
KillMode=process
User=$USER
Group=$USER

[Install]
WantedBy=parmanode.target         
EOF

sudo ln -s /etc/systemd/system/parmanode_sparrow_install.service /etc/systemd/system/parmanode.target.wants/parmanode_sparrow_install.service >$dn 2>&1
sudo systemctl daemon-reload
}