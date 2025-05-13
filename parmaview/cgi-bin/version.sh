#!/bin/bash
echo "Content-Type: text/plain"
echo ""

head -n1 $HOME/parman_programs/parmanode4/version.conf | cut -d \" -f 2