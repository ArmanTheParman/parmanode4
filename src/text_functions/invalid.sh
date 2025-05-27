function invalid {
clear
enter_continue "Invalid choice, hit enter to try again or q to quit."
if [[ $enter_cont == "q" ]] ; then
exit 0
fi

return 0
}