#!/bin/bash
source $HOME/parman_programs/parmanode4/src/config/parmanode_variables.sh
parmanode_variables

if jq '.parmanode' $pj | grep "electrum_downloaded" | grep -q "true" ; then exit ; fi
jq '.parmanode += {electrum_download: started}' $pj >$pj.tmp && mv $pj.tmp $pj

mkdir -p $HOME/.electrum

cat << 'EOF' | tee $HOME/.electrum/config 
{
    "auto_connect": false,
    "check_updates": false,
    "config_version": 3,
    "decimal_point": 8,
    "is_maximized": false,
    "oneserver": true,
    "server": "127.0.0.1:50005:t",
    "show_addresses_tab": true,
    "show_utxo_tab": true
} 
EOF

mkdir -p $hpa/electrum

cd $hpa/electrum
export electrum_version="4.5.8"

if [[ $computer_type == "LinuxPC" ]] ; then
    curl -LO https://download.electrum.org/$electrum_version/electrum-${electrum_version}-x86_64.AppImage 
    curl -LO https://download.electrum.org/${electrum_version}/electrum-${electrum_version}-x86_64.AppImage.asc
    curl -LO https://raw.githubusercontent.com/spesmilo/electrum/master/pubkeys/ThomasV.asc 
    sudo chmod +x electrum*.AppImage 
fi

if [[ $computer_type == "Pi" ]] ; then
    sudo apt-get install python3-pyqt5 libsecp256k1-dev python3-cryptography -y
    curl -LO https://download.electrum.org/${electrum_version}/Electrum-${electrum_version}.tar.gz
    curl -LO https://download.electrum.org/${electrum_version}/Electrum-${electrum_version}.tar.gz.asc
    curl -LO https://raw.githubusercontent.com/spesmilo/electrum/master/pubkeys/ThomasV.asc 
    tar -xvf Ele*.tar.gz
    mv ./Ele*/* ./
    #find . -type d -name 'Electrum-*' -exec rm -rf {} + # removes all directories that start with Electrum-
                                                         # leaving in case user needs to verify
fi

if [[ $OS == "Mac" ]] ; then

    pip3 install pyqt5 cryptography

    curl -LO https://download.electrum.org/${electrum_version}/electrum-${electrum_version}.dmg 
    curl -LO https://download.electrum.org/${electrum_version}/electrum-${electrum_version}.dmg.asc 
    curl -LO https://raw.githubusercontent.com/spesmilo/electrum/master/pubkeys/ThomasV.asc 

    git clone --depth 1 https://github.com/bitcoin-core/secp256k1.git
    cd secp256k1
    ./autogen.sh
    ./configure
    make
    sudo make install

    hdiutil attach $HOME/parmanode/electrum/electrum*dmg
    cp -r /Volumes/Electrum/Electrum.app /Applications
    diskutil unmountDisk /Volumes/Electrum
fi


gpg --import ./*Thomas*

if [[ $computer_type == "LinuxPC" ]] ; then
    if ! gpg --verify --status-fd 1 electrum*.asc electrum*.AppImage 2>&1 | tee -a $dp/verification/electrum| grep -i "GOOD" ; then 
       exit 1
    fi 
fi

if [[ $computer_type == "Pi" ]] ; then
    if ! gpg --verify --status-fd 1 Electrum*.asc Electrum*.tar.gz 2>&1 | tee -a $dp/verification/electrum | grep -i "GOOD" ; then
        exit 1
    fi
fi

if [[ $OS == "Mac" && $python_install != "true" ]] ; then
    if ! gpg --verify --status-fd 1 electrum*.asc electrum*.dmg 2>&1 |  tee -a $dp/verification/electrum | grep -i "GOOD" ; then 
        exit 1
    fi
elif [[ $OS == "Mac" && $python_install == "true" ]] ; then
    if ! gpg --verify --status-fd 1 Electrum*.asc Electrum*.gz 2>&1 | tee -a $dp/verification/electrum grep | -i "GOOD" ; then 
        exit 1
    fi
fi


jq 'del(.parmanode.electrum_download)' $pj >$pj.tmp && jq '.parmanode += {electrum_downloaded: true}' $pj.tmp >$pj && rm $pj.tmp
