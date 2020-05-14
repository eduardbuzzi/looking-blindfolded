#!/bin/bash

principal () {
echo
echo -e "Script \033[01;34mlooking-blindfolded\033[01;00m
echo -e "Created by: \033[01;32mEduardo Buzzi\033[01;00m"
echo -e "More Scripts in: \033[01;31mhttps://github.com/eduardbuzzi\033[01;00m"
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
read -p "Name of the list that will receive the IPs that are Online: " FILE
TIME=$(( 2 * $FINAL / 60 ))
echo "On average, it will take $TIME minutes to complete the search for public IPs"
echo
for i in `seq 1 $FINAL`
do
NUM1=$(shuf -i 1-217 -n1)
NUM2=$(shuf -i 1-254 -n1)
NUM3=$(shuf -i 1-254 -n1)
NUM4=$(shuf -i 0-254 -n1) 
HOST="$NUM1.$NUM2.$NUM3.$NUM4"    
echo "Checking if the IP $HOST is Online.."
PING=$(nmap -sn -T5 $HOST | grep "host up")
if [ -n "$PING" ]
then
echo -e "\033[01;32mIP => $HOST » ONLINE!\033[01;00m"
echo $HOST >> .$FILE
else
echo -e "\033[01;31mIP => $HOST » OFFLINE!\033[01;00m"
fi
done
awk 'NF>0' .$FILE >> $FILE
rm .$FILE 2> /dev/null
principal
}

locate () {
echo
read -p "Name of the list that has the IPs: " FILE
LINES=$(wc -l $FILE | cut -d ' ' -f1)
for i in `seq 1 $LINES`
do
IP=$(cat $FILE | head -n$i | tail -n1)
wget -qq https://whatismyipaddress.com/ip/$IP
COUNTRY=$(cat $IP | grep "<tr><th>Country:" | cut -d '>' -f5 | cut -d '<' -f1)
STATE=$(cat $IP | grep "<tr><th>State/Region:" | cut -d '>' -f5 | cut -d '<' -f1)
CITY=$(cat $IP | grep "<tr><th>City:" | cut -d '>' -f5 | cut -d '<' -f1)
if [ -z "$COUNTRY" ]
then
COUNTRY="NOT FOUND"
fi
if [ -z "$STATE" ]
then
STATE="NOT FOUND"
fi
if [ -z "$CITY" ]
then
CITY="NOT FOUND"
fi
rm $IP 2> /dev/null
echo
echo "IP -> $IP"
echo "Country: $COUNTRY"
echo "State/Region: $STATE"
echo "City: $CITY"
sleep 2.5
done
principal
}

portscan () {
apt-get -qq install nmap -y
echo
read -p "Name of the list that has the IPs: " FILE
echo
echo "[1] SUPER SLOW and SUPER QUIET"
echo "[2] SLOW and QUIET"
echo "[3] NORMAL"
echo "[4] FAST and NOISY"
echo "[5] SUPER FAST and SUPER NOISY"
echo
read -p "What is your choice? " CHOICE
echo
case $CHOICE in
1)
LINES=$(wc -l $FILE | cut -d ' ' -f1)
for i in `seq 1 $LINES`
do
IP=$(cat $FILE | head -n$i | tail -n1)
nmap -v -sV -T1 -Pn $IP
echo
echo "=-=-=-=-=-=-=-="
echo
done
;;
2)
LINES=$(wc -l $FILE | cut -d ' ' -f1)
for i in `seq 1 $LINES`
do
IP=$(cat $FILE | head -n$i | tail -n1)
nmap -v -sV -T2 -Pn $IP
echo
echo "=-=-=-=-=-=-=-="
echo
done
;;
3)
LINES=$(wc -l $FILE | cut -d ' ' -f1)
for i in `seq 1 $LINES`
do
IP=$(cat $FILE | head -n$i | tail -n1)
nmap -v -sV -T3 -Pn $IP
echo
echo "=-=-=-=-=-=-=-="
echo
done
;;
4)
LINES=$(wc -l $FILE | cut -d ' ' -f1)
for i in `seq 1 $LINES`
do
IP=$(cat $FILE | head -n$i | tail -n1)
nmap -v -sV -T4 -Pn $IP
echo
echo "=-=-=-=-=-=-=-="
echo
done
;;
5)
LINES=$(wc -l $FILE | cut -d ' ' -f1)
for i in `seq 1 $LINES`
do
IP=$(cat $FILE | head -n$i | tail -n1)
nmap -v -sV -T5 -Pn $IP
echo
echo "=-=-=-=-=-=-=-="
echo
done
;;
*)
LINES=$(wc -l $FILE | cut -d ' ' -f1)
for i in `seq 1 $LINES`
do
IP=$(cat $FILE | head -n$i | tail -n1)
nmap -v -sV -T3 -Pn $IP
echo
echo "=-=-=-=-=-=-=-="
echo
done
;;
esac
principal
}

principal
