function install_bitcoin {
return 0
#User Experience Plan...

# Downloads in the background with parmanode4 installation.
    --Files get collected in the background and stored for later to save time.
    --Needs to be robust and check itself, no user disturbance; maybe a service file/script.
    --Needs file flags to indicate success

# First choice to make
   -- Bitcoin version, including connecting to a different computer

# Select data location
   -- Store path in config
   -- bind mount it to $HOME/.bitcoin, and add to fstab
   -- if data in .bitcoin exists, will mount over it so no problem

#   -- Choice of bitcoin data directory
#           * External drive (parmanode drive at $pd)
#                 ** detect, or format
#                     *** detect with  remove/attach target drive sequence, then:
#                     *** devid=$(readlink -f /dev/disk/by-diskseq/$(ls -1v /dev/disk/by-diskseq/ | tail -n1))
#           * Internal drive ($HOME/.bitcoin) 
#                 ** use any existing data
#           * Import a drive (Umbrel/Mynode/RaspiBlitz)
#           * Custom path (You type where you want the directory or where it exists now)
#                 ** make path or use if it exists
#
#  -- Detect any existing bitcoin conf file
#           * offer to prune if overwriting or creating new bitcoin.conf
#
}