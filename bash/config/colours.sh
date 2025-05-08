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