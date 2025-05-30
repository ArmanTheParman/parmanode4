function enter_continue {
echo -en "$1\n"
unset enter_cont

echo -e "${yellow}Hit ${cyan}<enter>${yellow} to continue.$orange\n"  
read enter_cont </dev/tty ; fi
export enter_cont

case $enter_cont in
q) exit ;;
d)
    if [[ $debug == 1 ]] ; then export debug=0 ; fi
    if [[ $debug == 0 ]] ; then export debug=1 ; fi
    ;;
x)  set +x ;;
esac
}