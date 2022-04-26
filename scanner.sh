#!/bin/bash

#Tester SUID, SGID and Capabilities by Miguel Ruiz

echo "Your Tester is ready!"
echo ""
echo "[1] SUID"
echo "[2] SGID"
echo "[3] Capabilities"
echo ""
read -p "Select an option: " n

case $n in

1)
  find / -perm -4000 -ls
  
  pkexec=`find / -perm -4000 -ls | grep "pkexec"`

  if [ $pkexec != "" ] then
    exploit="y"
    echo ""
    read -p "¡¡ This system is vulnerable to pkexec, do you want to exploit it? !! [Y,n]" exploit
    echo ""
    exploit=`echo $exploit | tr '[:upper:]' '[:lower:]'`

    if [ $exploit == "y" or $exploit == "yes" ] then

      bash tools/cve-2021-4034.sh
    
    fi
  fi

;;

2)
  find / -perm -2000 -ls
;;

3)
  getcap -r / 2>/dev/null
;;

*)
  echo "Sorry but your option isn´t in the list"
;;
esac
