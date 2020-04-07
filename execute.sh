#!/bin/bash
principal () {
echo
echo "[1] Search Public IPs"
echo "[2] Locate IPs"
echo "[3] Portscan IPs"
echo "[4] Exit"
read -p "Your choice: " CHOICE

case $CHOICE in
  1) search;;
  2) locate;;
  3) portscan;;
  4) exit;;
  *) sleep 0.5 && principal;;
esac
}

search () {
echo 
}

locate () {
echo 
}

portscan () {
echo 
}
principal
