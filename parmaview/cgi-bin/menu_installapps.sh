#!/bin/bash
echo "Content-Type: text/plain"
echo ""

gsed -n '/<body>/,/<\/body>/p' $HOME/parman_programs/parmanode4/parmaview/menu_installapps.html | sed '1d;$d;'
