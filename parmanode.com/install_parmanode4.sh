return 0
#To be stored on parmanode.com

#!/bin/bash

function colours {

export black="\033[30m"
export red="\033[31m"
export green="\033[32m"
export yellow="\033[1;33m"
export blue="\033[34m"
export magenta="\033[35m"
export cyan="\033[36m"
export white="\033[37m"
export reset="\033[0m"
export orange="\033[1m\033[38;2;255;145;0m"
export pink="\033[38;2;255;0;255m"

export bright_black="\033[90m" ; export grey="\033[90m"

export bright_red="\033[91m"
export bright_green="\033[92m"
export bright_yellow="\033[93m"
export bright_blue="\033[94m"
export bright_magenta="\033[95m"
export bright_cyan="\033[96m"
export bright_white="\033[97m"
export blinkon="\033[5m"
export blinkoff="\033[0m"

if [[ $(uname) == Darwin ]] ; then export orange="$yellow" 
fi
}

function check_tmp {
if [[ -d "/tmp" ]] ; then
    export tmp="/tmp"
elif [[ -d "$HOME/tmp" ]] ; then
    export tmp="$HOME/tmp" 
else
   mkdir -p $HOME/tmp >/dev/null 2>&1
   export tmp="$HOME/tmp" 
fi
}

function sww {
echo -e "Something went wrong \n$1\n\nHit <enter> to continue\n"
read
}

function check_parmanode_exists {
if [[ -d $HOME/.parmanode4 ]] ; then

    clear

    echo -e "\nParmanode4 seems to already be installed. Updating and exiting.\n"  #update parmanode if it exists...

    if which git >/dev/null
        if ! git config --global user.email ; then git config --global user.email sample@parmanode.com ; fi
        if ! git config --global user.name ; then git config --global user.name Parman ; fi
        cd $HOME/parman_programs/parmanode4 && git config pull.rebase false && git pull >/dev/null 2>&1
    fi

    exit 
fi
}

function yesornoinstallparmanode {
clear
printf "$orange
############################################################$blue
                   P A R M A N O D E ${red}4$orange
############################################################


  Good call on installing Parmanode. This installation 
  will add a few directories and files here and there, 
  and also install some programs that are necessary for 
  Parmanode to function. You will be asked to confirm 
  on the next page.

  If Parmanode${blue}3$orange is installed on your machine, Parmanode${red}4$orange
  will detect that, and any programs you have installed 
  with it, and migrate them across.
    
  Once that is done, Parmanode${red}4$orange will remove Parmanode${blue}3$orange
  for you. If you ever lose your mind and uninstall 
  Parmanode${red}4$orange, it will leave your machine nice and clean.


############################################################
$yellow Hit <enter> to continue or 'q' and <enter> to quit$orange

"
read choice
case $choice in q|Q) exit ;; esac
}

function check_docker {

if which docker >/dev/null && return 0

if [[ $(uname) == "Darwin" ]] ; then

    export MacOSVersion=$(sw_vers | grep ProductVersion | awk '{print $ 2}')
    export MacOSVersion_major=$(sw_vers | grep ProductVersion | cut -d \. -f 1 | grep -Eo '[0-9]+$')
    export MacOSVersion_minor=$(sw_vers | grep ProductVersion | cut -d \. -f 2)
    export MacOSVersion_patch=$(sw_vers | grep ProductVersion | cut -d \. -f 3)

    if [[ $MacOSVersion_major -lt 12 ]] ; then
    clear
    echo -e "
    \r########################################################################################

    \r    Sorry, you need MacOS version 12.0 or later to use Parmanode.

    \r    The main issue is that Parmanode4 needs docker on Macs, and Docker is increasingly
    \r    requiring higher and higher versions of MacOS to function.

    \r    You can still salvage the situation by finding an old version of Docker and 
    \r    manually installing it. Then if you run this Parmanode4 installer again, it will
    \r    detect that docker is already installed and running and won't bother you with
    \r    version detection.

    \r########################################################################################
    \r    Hit <enter> to exit.
    "
    read
    exit 0
    fi
    
    install_docker_mac

if [[ $(uname) == "Linux" ]] ; then

    install_docker_linux

fi

}


function install_docker_mac {
#called by check_docker

docker ps >/dev/null && return 0

#Downloads and installs for mac

if [[ $(uname -m) == "arm64" ]] ; then
download_docker_file="https://desktop.docker.com/mac/main/arm64/Docker.dmg"
else
download_docker_file="https://desktop.docker.com/mac/main/amd64/Docker.dmg"
fi

echo -e "
########################################################################################
$cyan
                               Downloading Docker...
$orange
########################################################################################
please wait
"

#Download Docker Desktop
if [[ ! -f $tmp/docker/Docker.dmg ]] ; then 
    clear
    mkdir -p $tmp/docker
    cd $tmp/docker && curl -LO $download_docker_file 
fi

#Mount and copy to Applications
if [[ -f $tmp/docker/Docker.dmg ]] ; then 
    hdiutil attach $tmp/docker/Docker.dmg
    sleep 3
    sudo cp -r /Volumes/Docker/Docker.app /Applications 
    diskutil unmount /Volumes/Docker
else
    echo -e "\nDocker.dmg does not exist, can't attach as volume. Aborting.\n"
    exit
fi

nohup open -a "Docker Desktop" >$dn 2>&1 & 

while true ; do
if docker ps >$dn 2>&1  ; then return 0 ; fi
clear ; echo -e "$orange
########################################################################################$green
                         DOCKER$orange is starting, please wait...
########################################################################################

    Docker should be loading; it sometimes could take a minute or so. There may be a
    graphical pop-up: Make sure to accept the terms and conditions if that appears,
    otherwise Parmanode (& Docker) will not work. 

    If there's a problem after a few minutes, try starting Docker yourself. If you
    still have issues installing Docker using Parmanode, try installing Docker
    manually yourself. Parmanode will detect it and use it.
    
    After accepting the terms, you can close the Docker WINDOW. 

    If Parmanode doesn't successfully install Docker, and you fail to as well, then
    carefully place the computer in the bin and buy a new one, preferably Linux, 
    not Mac, and not, God forbid, Windows.

$red
               ####################################################
                 HIT <ENTER> ONCE YOU CONFIRMED DOCKER IS RUNNING 
               ####################################################
$orange
   If you hit <enter> too early, this text will loop. To abort, hit 'q' and <enter>

########################################################################################
"
read choice
case $choice in Q|q|Quit|QUIT) exit 0 ;; *) clear ; continue ;; 
esac 
done

return 0
}

function install_docker_linux {
clear ; echo -e "$orange
########################################################################################
$cyan
                                     DOCKER
$orange 
    Docker is a technology that allows software applications to be packaged and run 
    in a way that is more efficient and portable. With Docker, developers can create 
    "containers" that include all the necessary parts of an application, such as the 
    code, operating system, and other dependencies. These containers are like mini
    virtual computers that run inside real computers.

    Docker is required to run some Apps that Parmanode can install for you.

    Hit <enter> to continue and install, and type 'skip' and <enter> to skip it.

########################################################################################
"
read choice ; case $choice in skip) return 0 ;; esac

clear
echo -e "${green}Cleaning up first...\n"

    sudo apt-get purge docker docker-engine docker.io containerd runc docker-ce \
    docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
    docker-ce-rootless-extras -y

# download_docker_linux
sudo apt-get update -y
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update -y

source /etc/os-release 

    if grep -q UBUNTU_CODENAME /etc/os-release ; then 
    CODENAME=$UBUNTU_CODENAME
    else
    CODENAME=$DEBIAN_CODENAME
    fi

    #url ID value tweaking...
    if [[ $NAME == LMDE ]] ; then
        ID=debian #for docker url
        parmanode_conf_add "ID=debian"
    elif [[ $ID == linuxmint ]] ; then 
        debug "ID, 1.5, in linux mint. ID=$ID"
        ID=ubuntu
        parmanode_conf_add "ID=ubuntu"
    else
        ID=$ID
        parmanode_conf_add "ID=$ID"
    fi

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$ID $(echo $CODENAME) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list >$dn 

#fix ubuntu label to debian if needed:
if [[ $ID == "debian" ]] ; then 
    sudo sed -i 's/ubuntu/debian/g' /etc/apt/sources.list.d/docker.list >> $dp/sed.log 2>&1
fi

sudo apt-get update -y

sudo apt-get install containerd.io docker-ce docker-ce-cli docker-buildx-plugin docker-compose-plugin docker-compose -y 

sudo usermod -aG docker $USER 

clear ; echo -e "$orange
######################################################################################## 

    In order for Docker to run properly, the computer must be restarted.

    But not now, just remember to do it later before running Parmanode.
    
########################################################################################
    Hit <enter> to continue
"
case $choice in q|Q) exit 0 ;; esac
return 0
}

function make_desktop_text {
#make desktop text document...
if [ ! -e $HOME/Desktop/parmanode4_info.txt ] ; then
cat <<'EOF' | tee $HOME/Desktop/run_parmanode4.txt >/dev/null

To run Parmanode, simply open a browser and visit:

http://parmanode4.local:58000

Good idea to bookmarket that address, then you can delete this text document.
EOF

echo "See new text document on Desktop."
fi
}

check_brew_macs

function install_xcode_for_macs {
while true ; do #loop 1
if xcode-select -p >/dev/null 2>&1 ; then break ; fi

#Install cldts
clear
sudo -k
echo "
########################################################################################
   
   Command Line Developer Tools is needed.

   There will be a pop up question which you'll need to respond to (It may actually
   be minimised, so look at the task bar below if you don't see it). The install
   estimate will initially say some HOURS, but ignore that, it's wrong.

   Once Command Line Tools have successfully installed, enter your computer password,
   then <enter> to continue.

   Hit <enter> ONLY after the pop up has finished installeding, and not before, or 
   your computer will melt.
 
   If you want to abandon, you can hit <control> c now.

####################################################################################### 
"
xcode-select --install

sudo sleep 0.1break
done #ends loop 1
}




function install_homebrew {

if ! [[ $(uname) == "Darwin" ]] ; then return 0 ; fi

clear
while true ; do
echo -e "
########################################################################################$cyan
                              HOMEBREW INSTALLATION$orange
########################################################################################

    Homebrew is$red necessary$orange to run Parmanode4. It is a package (software install) 
    manager for MacOS. 

    This can take a while, sometimes with very litte feedback during the process. 

    You may or may not need to respond to some prompts; if there is a recommendation 
    to run a command related to 'git unshallow', then follow that instruction.

    If this fails, you can try to look up instructions to install HomeBrew on your
    Mac yourself, and try the Parmanode4 installation again.

    Proceed or abort? 
$green
                             y)$orange    Install Homebrew
$red
                             n)$orange     Skip (exit)

########################################################################################    
"
read choice ; clear
case $choice in
q|Q) exit ;; n|No|no) exit ;; 
y|Y|yes)

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 

echo "PATH=/opt/homebrew/bin:\$PATH" | sudo tee -a $HOME/.zshrc >$dn 2>&1

echo -e "\n\nYou may get a prompt to update the PATH - don't worry, Parmanode has done 
it for you.\n\nHit <enter> to continue."

sleep 4

return 0
;;
*)
clear
echo -e "Invalid choice. Hit <enter> then try again."
;;
esac
done
}

function install_homebrew_packages {

if ! [[ $(uname) == "Darwin" ]] ; then return 0 ; fi

brew update

brew install git
brew install bash
brew install netcat
brew install jq
brew install vim
brew install tmux
brew install tor
brew install gnu-sed
brew install gsed
}

function install_linux_packages {

if [[ $(uname) == "Darwin" ]] ; then return 0 ; fi

sudo apt-get update -y
sudo apt-get install -y curl python3 pip3 socat vim nano ssh || sww
sudo apt-get install -y net-tools git procps gnupg tmux x11-apps ca-certificates netcat-traditional jq || sww
sudo apt-get install -y unzip tor ufw mdadm e2fsprogs tune2fs fuse3 libfuse2 || sww
{ pip3 install websockets || pip3 install websockets --break-system-packages ; } || sww
}

function gsed_symlink {
if [[ $(uname) == "Linux" ]] && ! which gsed >/dev/null 2>&1 ; then
    sudo ln -s $(which sed) /usr/bin/gsed 
fi
}

function parmanode_directories {
#Check files and directories exist
mkdir -p $HOME/parman_programs
mkdir -p $HOME/parmanode4_apps
mkdir -p $HOME/.parmanode4
touch    $HOME/.parmanode4/installed.conf
touch    $HOME/.parmanode4/parmanode.conf
touch    $HOME/.parmanode4/parmanode.log
touch    $HOME/.parmanode4/debug.log
touch    $HOME/.parmanode4/temp
return 0
}

function  configure_git {
    if ! git config --global user.email ; then git config --global user.email parman@parmanode.com ; fi
    if ! git config --global user.name ; then git config --global user.name parmanode_user ; fi
}

function clone_parmanode {
git clone https://github.com/armantheparman/parmanode4.git $HOME/parman_programs/parmanode4
cd $HOME/parman_programs/parmanode4 && git config pull.rebase false >/dev/null 2>&1
}


colours
check_parmanode_exists
yesornoinstallparmanode
check_temp
check_docker
install_homebrew
install_homebrew_packages
install_linux_packages
gsed_symlink 
parmanode_directories
configure_git 
clone_parmanode

#migrate_from_parmanode3


echo "\n\n\n    SUCCESS!\n\n\nPlease reboot before using Parmanode."
sleep 1.5
exit

