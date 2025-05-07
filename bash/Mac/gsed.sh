function gsed_symlink {
    
#The sed command is not consistent between Linux and Mac, so I'll always use gsed (works on Mac like sed on Linux) and on Linux, the symlink gsed will point to sed, making code easier to write and read.


if [[ $(uname) == "Linux" ]] && ! which gsed >/dev/null 2>&1 ; then

    sudo ln -s $(which sed) /usr/bin/gsed 
fi
}

function get_gsed_mac {

if ! which gsed >$dn ; then 
    if ! which brew >$dn ; then
        install_brew || return 1
    fi

    brew install gsed || sww
fi

}
