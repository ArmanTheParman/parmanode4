echo "Content-type: application/json"
echo ""

echo -n "{
    \"parmanode\":$(cat $HOME/.parmanode/parmanode.json),
    \"installed\":$(cat $HOME/.parmanode/installed.json)
}"