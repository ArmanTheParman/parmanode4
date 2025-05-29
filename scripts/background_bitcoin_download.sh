#!/bin/bash
source $HOME/parman_programs/parmanode4/src/config/parmanode_variables.sh
parmanode_variables

#Executed by service file
#Downloads Bitcoin Core and Knots precompiled files, verifies, unpacks, and also downloads github repos,
#all ready to copy from hidden temp directory for the user once they make a selection - speeds things up.
#tmp directory is set in parmaonde.conf, currently $HOME/.parmanmode/tmp

#the config file contains flags to prevent re-downloading if already done
#the completed flag will signal to the frontend that the download is done
#the service file is run once at the end of parmanode4 installation

if jq '.parmanode' $pc | grep "bitcoin_downloaded" $pj | grep -q true ; then exit ; fi
jq '.parmanode += {bitcoin_download: started}' $pj >$pj.tmp && mv $pj.tmp $pj

export knotsversion=28.1 
export deisversion=28.1
export knotsdate=20250305 
export knotsmajor=28.x
export knotsextension="tar.gz"
export coreexternsion="tar.gz"
[[ $OS == "Mac" ]] && export knotsversion=28.1 && export knotsdate=20250305 && knotsmajor=28.x && knotsextension="zip" && coreexternsion="tar.gz"

while true ; do

	     if [[ $chip == "armv7l" || $chip == "armv8l" ]] ; then 		#32 bit Pi4
                cd $tmp/bitcoinknots
                curl -LO https://bitcoinknots.org/files/$knotsmajor/$knotsversion.knots$knotsdate/bitcoin-$knotsversion.knots$knotsdate-arm-linux-gnueabihf.$knotsextension 
                cd $tmp/bitcoin
		        curl -LO https://bitcoincore.org/bin/bitcoin-core-$version/bitcoin-$version-arm-linux-gnueabihf.tar.gz  
                break
         fi

	     if [[ $chip == "aarch64" && $OS == "Linux" ]] ; then 				

            if [[ $( file /bin/bash | cut -d " " -f 3 ) == "64-bit" ]] ; then
                cd $tmp/bitcoinknots
                curl -LO https://bitcoinknots.org/files/$knotsmajor/$knotsversion.knots$knotsdate/bitcoin-$knotsversion.knots$knotsdate-aarch64-linux-gnu.$knotsextension 
                cd $tmp/bitcoin
                curl -LO https://bitcoincore.org/bin/bitcoin-core-$version/bitcoin-$version-aarch64-linux-gnu.tar.gz 
                break
            else #32 bit
                cd $tmp/bitcoinknots
                curl -LO https://bitcoinknots.org/files/$knotsmajor/$knottsversion.knots$knotsdate/bitcoin-$knotsversion.knots$knotsdate-arm-linux-gnueabihf.$knotsextension 
                cd $tmp/bitcoin
                curl -LO https://bitcoincore.org/bin/bitcoin-core-$version/bitcoin-$version-arm-linux-gnueabihf.tar.gz 
                break
            fi
         fi

 	     if [[ $chip == "x86_64" && $OS == "Linux" ]] ; then 
                cd $tmp/bitcoinknots
                curl -LO https://bitcoinknots.org/files/$knotsmajor/$knotsversion.knots$knotsdate/bitcoin-$knotsversion.knots$knotsdate-x86_64-linux-gnu.$knotsextension
                cd $tmp/bitcoin
		        curl -LO https://bitcoincore.org/bin/bitcoin-core-$version/bitcoin-$version-x86_64-linux-gnu.tar.gz
                break
         fi

         if [[ ($chip == "arm64" && $OS == "Mac") || ( $chip == "aarch64" && $OS == "Mac") ]] ; then
            cd $tmp/bitcoinknots
            curl -LO https://bitcoinknots.org/files/$knotsmajor/$knotsversion.knots$knotsdate/bitcoin-$knotsversion.knots$knotsdate-arm64-apple-darwin.$knotsextension 
            cd $tmp/bitcoin
            curl -LO https://bitcoincore.org/bin/bitcoin-core-$version/bitcoin-$version-arm64-apple-darwin.zip 
            break
         fi

         if [[ $chip == "x86_64" && $OS == "Mac" ]] ; then
            cd $tmp/bitcoinknots
            curl -LO https://bitcoinknots.org/files/$knotsmajor/$knotsversion.knots$knotsdate/bitcoin-$knotsversion.knots$knotsdate-x86_64-apple-darwin.$knotsextension 
            cd $tmp/bitcoin
            curl -LO https://bitcoincore.org/bin/bitcoin-core-$version/bitcoin-$version-x86_64-apple-darwin.zip 
            break
         fi
done

cd $tmp/bitcoinknots
curl -LO https://bitcoinknots.org/files/$knotsmajor/$knotsversion.knots$knotsdate/SHA256SUMS 
curl -LO https://bitcoinknots.org/files/$knotsmajor/$knotsversion.knots$knotsdate/SHA256SUMS.asc
cd $tmp/bitcoin
curl -LO https://bitcoincore.org/bin/bitcoin-core-$version/SHA256SUMS 
curl -LO https://bitcoincore.org/bin/bitcoin-core-$version/SHA256SUMS.asc 

#ignore-missing option not available on shasum

shasum -a 256 --check SHA256SUMS |& tee shasumresult | grep -q ": OK" && mv shasumresult shasumpassed

gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys 658E64021E5793C6C4E15E45C2E581F5B998F30E >$dn 2>&1
gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys 1A3E761F19D2CC7785C5502EA291A2C45D0C504A >$dn 2>&1
gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys E777299FC265DD04793070EB944D35F9AC3DB76A >$dn 2>&1
curl https://raw.githubusercontent.com/bitcoin-core/guix.sigs/main/builder-keys/laanwj.gpg | gpg --import >$dn 2>&1
curl https://raw.githubusercontent.com/bitcoin-core/guix.sigs/main/builder-keys/Emzy.gpg | gpg --import >$dn 2>&1

gpg --verify --status-fd 1 SHA256SUMS.asc 2>&1 |& tee gpgresult | grep -iq GOOD && mv gpgresult gpgpassed

cd $tmp/bitcoin
if find $tmp/bitcoin/ -type f -name "*.zip" 2>$dn | grep -q . >$dn 2>&1 ; then #find returns true when found or not
unzip bitcoin*.zip
fi
mkdir -p ./tar ; tar -xf bitcoin-* -C ./tar/
git clone https://github.com/bitcoin/bitcoin.git bitcoin_github

cd $tmp/bitcoinknots
if find $tmp/bitcoinknots/ -type f -name "*.zip" 2>$dn | grep -q . >$dn 2>&1 ; then #find returns true when found or not
unzip bitcoin*.zip
mkdir -p ./tar ; tar -xf bitcoin-* -C ./tar/
fi
git clone https://github.com/bitcoinknots/bitcoin.git bitcoinknots_github
jq 'del(.parmanode.bitcoin_download)' $pj >$pj.tmp && jq '.parmanode += {bitcoin_downlaoded: true}' $pj.tmp >$pj && rm $pj.tmp