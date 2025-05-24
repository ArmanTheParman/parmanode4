echo "Content-type: application/json"
echo ""

echo -n "{
    \"parmanode\":"
cat $HOME/.parmanode/parmanode.json
echo -n ",
    \"installed\":"
cat $HOME/.parmanode/installed.json
echo -n "}"
