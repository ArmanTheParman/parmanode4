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
" | sudo tee /etc/systemd/system/parmanode_socat.service >$dn 2>&1

sudo ln -s /etc/systemd/system/parmanode_socat.service /etc/systemd/system/parmanode.target.wants/parmanode_socat.service >$dn 2>&1
sudo systemctl daemon-reload >$dn 2>&1
sudo systemctl enable --now socat.service >$dn 2>&1
}
