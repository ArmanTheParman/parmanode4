function make_parmanode_service {
if [[ $(uname) == "Darwin" ]] ; then return 0 ; fi
# because parmanode.target exists, parmanode.target.wants dir becomes active, and symlinks 
# inside are run, which will point to /etc/systemd/system/parmanode/*

cat <<EOF | sudo tee /etc/systemd/system/parmanode.target >$dn 2>&1 
[Unit]
Description=Parmanode Group
EOF

sudo mkdir -p /etc/systemd/system/parmanode.target.wants >$dn 2>&1 
sudo mkdir -p /etc/systemd/system/parmanode >$dn 2>&1 

#Starts at boot if uncommented...
#sudo ln -s /etc/systemd/system/parmanode.target /etc/systemd/system/multi-user.target.wants/parmanode.target >$dn 2>&1
sudo systemctl daemon-reload
}

