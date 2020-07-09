#!/bin/bash

FOLDER="<SET IT UP PROPERLY>"
FILE="passwords.json"
WEBHOOK="<MATTERMOST INCOMING WEBHOOK>"

function send_message() {
  MSG=$1
  printf -v json -- '{"text": "INTRUDER ALERT IN SUBNETWORK XX.XX.XX.XX/XX. SOURCE IP: %s"}' "$MSG"
  RES=$(curl -i -X POST -H 'Content-Type: application/json' -d "$json" $WEBHOOK)
}


inotifywait -e modify,close_write,moved_to,create -m $FOLDER |
while read -r directory events filename; do
  if [ "$filename" = "$FILE" ]; then
    MESSAGE=$(cat $FOLDER/$FILE | tail -1 | jq -r '.src_ip')
    send_message $MESSAGE
  fi
done

