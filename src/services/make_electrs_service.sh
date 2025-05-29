function make_electrs_service {

cat <<EOF | sudo tee /etc/systemd/system/electrs.service >$dn 2>&1
[Unit]
Description=Electrs
After=bitcoind.service

[Service]
WorkingDirectory=$hpa/parmanode_apps/electrs
ExecStart=$hpa/electrs/target/release/electrs --conf $HOME/.electrs/config.toml 
User=$USER
Group=$(id -ng)
Type=simple
KillMode=process
TimeoutSec=60
Restart=always
RestartSec=60

Environment=\"RUST_BACKTRACE=1\"

# Hardening measures
PrivateTmp=true
ProtectSystem=full
NoNewPrivileges=true
MemoryDenyWriteExecute=true

# Logging
StandardOutput=append:$HOME/.electrs/run_electrs.log
StandardError=append:$HOME/.electrs/run_electrs.log

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload >$dn
sudo systemctl enable electrs.service >$dn

}