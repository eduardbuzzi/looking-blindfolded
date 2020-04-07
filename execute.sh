#!/bin/bash
principal () {
echo
echo "[1] Search Public IPs"
echo "[2] Locate IPs"
echo "[3] Portscan IPs"
echo "[4] Exit"
echo
read -p "Your choice: " CHOICE

case $CHOICE in
  1) search;;
  2) locate;;
  3) portscan;;
  4) echo && exit;;
  *) sleep 0.5 && principal;;
esac
}

search () {
echo
read -p "How many random IPs do you want to check if are online? " FINAL
read -p "Name of the list that will receive the IPs that are Online: " LISTNAME
echo
for i in `seq 1 $FINAL`
do
NUM1=$(shuf -i 1-217 -n1)
NUM2=$(shuf -i 1-254 -n1)
NUM3=$(shuf -i 1-254 -n1)
NUM4=$(shuf -i 0-254 -n1) 
HOST="$NUM1.$NUM2.$NUM3.$NUM4"    
echo "Checking if the IP $HOST is Online.."
PING=$(ping -c 1 $HOST | grep "64 bytes" | cut -d ' ' -f4 | sed 's/.$//')
echo $PING >> .$LISTNAME
done
awk 'NF>0' .$LISTNAME >> $LISTNAME.txt
rm .$LISTNAME 2> /dev/null
principal
}

locate () {
echo 
}

portscan () {
echo 
}
principal
