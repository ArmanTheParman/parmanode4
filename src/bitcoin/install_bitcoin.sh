function install_bitcoin {
# Installs with parmanode4 installation.

# Make compatible with Mac, Linux, Docker, VPS
# Knots is the default

#   -- detect if in a docker container
#   -- detect bitcoin running and in path.
#   -- detect presence of .bitcoin directory and manage
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
true
}