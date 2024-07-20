#!/bin/bash

# Start xinetd for cups-bsd (lpd)
./start-xinetd.sh &

# Main process
./start-cupsd.sh &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
