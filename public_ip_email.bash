#/bin/bash

# Purpose: Determine a change in public IP address and send the new IP
# over email. The assumption is mailx is already set up

# Global vars
STORED_PUBLIC_IP_FILE=~/.stored_public_ip.txt
EMAIL="XXX"

# Determine public IP
PUBLIC_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo "Public IP:${PUBLIC_IP}"

# Check if the public IP has changed
STORED_PUBLIC_IP=$(cat ${STORED_PUBLIC_IP_FILE})

if [[ "${PUBLIC_IP}" != ${STORED_PUBLIC_IP} ]]; then
   echo "IP Address has changed!"
   # Store IP address for future comparision
   echo ${PUBLIC_IP} >| ${STORED_PUBLIC_IP_FILE}
   # Email IP to user
   echo "New Public IP" | mailx -s "New Public IP Address:${PUBLIC_IP}" ${EMAIL}
else
   echo "IP Address has not changed!"
fi

