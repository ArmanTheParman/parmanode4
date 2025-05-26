function make_javascript_server_service {
#only needed for development
if [[ $(uname) == "Darwin" ]] ; then return 0 ; fi

echo "[Unit]
Description=Parmanode JavaScript Server
After=network.target

[Service]
ExecStart=python3 -m http.server 58002 --directory=$HOME/parman_programs/parmanode4/parmaview/js/
KillMode=process
User=$USER
Group=$USER

[Install]
WantedBy=multi-user.target         #parmanode.target if no autostart at boot
" | sudo tee /etc/systemd/system/parmanode/pn4_js.service >$dn 2>&1

sudo ln -s /etc/systemd/system/parmanode/pn4_js.service /etc/systemd/system/parmanode.target.wants/pn4_js.service >$dn 2>&1
sudo systemctl daemon-reload
}