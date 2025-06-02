#!/bin/bash
source $HOME/parman_programs/parmanode4/src/config/parmanode_variables.sh
parmanode_variables
export sparrowconf="$HOME/.sparrow/config"

if jq '.parmanode' $pj | grep "sparrow_downloaded" | grep -q "true" ; then exit ; fi
jq '.parmanode += {sparrow_download: “started"}' $pj >$pj.tmp && mv $pj.tmp $pj

mkdir -p $HOME/.sparrow
mkdir -p $hpa/sparrow

cd $dp/tmp/sparrow
export sparrow_version="2.2.2"

#sparrow has inconsistent filenames for various versions, so some ugly code here to work around it
if [[ $OS == "Linux" ]] ; then
    if [[ $chip == "x86_64" || $chip == "amd64" ]] ; then
        if    curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrow-${sparrow_version}-x86_64.tar.gz  ; then
              curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrow-${sparrow_version}-x86_64.tar.gz
        elif    curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrowwallet-${sparrow_version}-x86_64.tar.gz  ; then
                curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrowwallet-${sparrow_version}-x86_64.tar.gz
        elif    curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrow-${sparrow_version}-x86_64.tar.gz  ; then
              curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrow-${sparrow_version}-x86_64.tar.gz
        elif    curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrowwallet-${sparrow_version}-x86_64.tar.gz ; then
                curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrowwallet-${sparrow_version}-x86_64.tar.gz
        else
              echo "Unable to find file for Sparrow version $sparrow_version." | tee -a $dp/verification/sparrow
              exit 1
        fi
    fi

    if [[ $chip == "aarch64" ]] ; then
        if   curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrow-${sparrow_version}-aarch64.tar.gz  ; then 
             curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrow-${sparrow_version}-aarch64.tar.gz 
        elif   curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrowwallet-${sparrow_version}-aarch64.tar.gz  ; then
               curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrowwallet-${sparrow_version}-aarch64.tar.gz 
        elif   curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrow-${sparrow_version}-aarch64.tar.gz  ; then
             curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrow-${sparrow_version}-aarch64.tar.gz 
        elif   curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrowwallet-${sparrow_version}-aarch64.tar.gz  ; then
               curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrowwallet-${sparrow_version}-aarch64.tar.gz 
        else
              echo "Unable to find file for Sparrow version $sparrow_version." | tee -a $dp/verification/sparrow
              exit 1
        fi
    fi

fi

if [[ $OS == "Mac" ]] ; then

    if [[ $chip == "aarch64" || $(uname -m) == arm64 || $(uname -m) == ARM64 ]] ; then

        if   curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrow-${sparrow_version}-aarch64.dmg  ; then
             curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrow-${sparrow_version}-aarch64.dmg
        elif   curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrowwallet-${sparrow_version}-aarch64.dmg  ; then
               curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrowwallet-${sparrow_version}-aarch64.dmg
        elif   curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrow-${sparrow_version}-aarch64.dmg  ; then
               curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrow-${sparrow_version}-aarch64.dmg
        elif   curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrowwallet-${sparrow_version}-aarch64.dmg  ; then
               curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrowwallet-${sparrow_version}-aarch64.dmg
        else
              echo "Unable to find file for Sparrow version $sparrow_version." | tee -a $dp/verification/sparrow
              exit 1
        fi
    fi

    if [[ $chip == "x86_64" ]] ; then
        if    curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrow-${sparrow_version}-x86_64.dmg  ; then
              curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrow-${sparrow_version}-x86_64.dmg
        elif    curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrowwallet-${sparrow_version}-x86_64.dmg  ; then
                curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrowwallet-${sparrow_version}-x86_64.dmg
        elif    curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrow-${sparrow_version}-x86_64.dmg  ; then
                curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrow-${sparrow_version}-x86_64.dmg
        elif    curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrowwallet-${sparrow_version}-x86_64.dmg  ; then
                curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrowwallet-${sparrow_version}-x86_64.dmg
        else
              echo "Unable to find file for Sparrow version $sparrow_version." | tee -a $dp/verification/sparrow
              exit 1
        fi
    fi
fi

if   curl -sfI  https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrow-${sparrow_version}-manifest.txt  ; then
     curl -LO   https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrow-${sparrow_version}-manifest.txt
elif  curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrow-${sparrow_version}-manifest.txt  ; then
      curl -LO  https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrow-${sparrow_version}-manifest.txt 
else
        echo "Unable to find file for Sparrow version $sparrow_version." | tee -a $dp/verification/sparrow
        exit 1
fi

if curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrow-${sparrow_version}-manifest.txt.asc  ; then
   curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/sparrow-${sparrow_version}-manifest.txt.asc
elif curl -sfI https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrow-${sparrow_version}-manifest.txt.asc  ; then
     curl -LO https://github.com/sparrowwallet/sparrow/releases/download/${sparrow_version}/Sparrow-${sparrow_version}-manifest.txt.asc
else
        echo "Unable to find file for Sparrow version $sparrow_version." | tee -a $dp/verification/sparrow
        exit 1
fi


curl https://keybase.io/craigraw/pgp_keys.asc | gpg --import

if ! gpg --verify sparrow*.asc sparrow*.txt | tee -a $dp/verification/sparrow ; then
echo "GPG verification failed. Aborting. Contact Parman for help." | tee -a $dp/verification/sparrow ; exit 1 ; fi

echo -e "${green}gpg verification passed" | tee -a $dp/verification/sparrow

if which sha256sum ; then
    if ! sha256sum --ignore-missing --check *parrow*.txt |& tee -a $dp/verification/sparrow ; then echo -e "Checksum$red failed$orange. Aborting. Contact Parman for help." | \
        tee -a $dp/verification/sparrow
        exit 1 
    fi
else
    if ! shasum -a 256 --check *parrow*.txt |& tee -a $dp/verification/sparrow | grep -q OK ; then echo "Checksum$red failed$orange. Aborting. Contact Parman for help." | \
    tee -a $dp/verification/sparrow
    exit 1 ; fi
fi

echo -e "${green}SHA256 verification passed" | tee -a $dp/verification/sparrow

rm $HOME/.sparrow/config 
cp $pn/src/config/sparrow_config $HOME/.sparrow/config # copies template across

sudo gsed -i "/coreDataDir/c\\    \"coreDataDir\": \"$HOME/.bitcoin\"," $sparrowconf
sudo gsed -i "/coreAuth\":/c\\    \"coreAuth\": \"parman:parman\"," $sparrowconf


sudo gsed -i "/serverType/c\\  \"serverType\": \"ELECTRUM_SERVER\","  $sparrowconf
sudo gsed -i "/electrumServer/c\\  \"electrumServer\": \"ssl:\/\/127.0.0.1:50006\"," $sparrowconf
sudo gsed -i "/useProxy/c\\  \"useProxy\": false," $sparrowconf

if [[ $OS == "Linux" ]] ; then
    tar -xvf sparrow*.gz
    cd sparrow*
    mv ./* $hpa/sparrow/
elif [[ $OS == "Mac" ]] ; then 
    hdiutil attach $HOME/parmanode/Sparrow*
    sudo cp -r /Volumes/Sparrow/Sparrow.app /Applications
    diskutil unmountDisk /Volumes/Sparrow
fi

jq 'del(.parmanode.electrum_download)' $pj >$pj.tmp && jq '.parmanode += {electrum_downloaded: true}' $pj.tmp >$pj && rm $pj.tmp


