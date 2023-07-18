#!/bin/bash
# Color Validation
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
RED='\033[0;31m'
BGWHITE='\e[0;47;30m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
CYAN='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
CYAN='\e[36m'
LIGHT='\033[0;37m'
tokengit=$(cat /etc/adminip/access.conf)
MYIP=$(wget -qO- ipinfo.io/ip);
adminip=$( curl -sS https://raw.githubusercontent.com/Jengkolonline/izinn/main/accessmenu | grep $MYIP )
if [ $adminip = $MYIP ]; then
echo -e "${green}Permission Accepted...${NC}"
else
rm -rf addip.sh
clear
echo -e "${red}Permission Denied!${NC}";
echo "OWNER AREA ONLY"
exit 0
fi

setadmin() {
#isi link git
linkinstall="wget --no-check-certificate https://jengkolonline.biz.id/install.sh && chmod +x install.sh && ./install.sh"
rm -rf /etc/adminip/
mkdir -p /etc/adminip
read -p "INPUT OWNER ACCESS TOKEN CODE " ans
echo -e "$ans" >> /etc/adminip/access.conf
wget -O /usr/bin/xp-ip ${linkinstall}/xp-ip.sh && chmod +x /usr/bin/xp-ip
clear
sed -i "/^# IPREGBEGIN_EXP/,/^# IPREGEND_EXPIP/d" /etc/crontab
cat << EOF >> /etc/crontab
# IPREGBEGIN_EXP
1 0 * * * root /usr/bin/xp-ip # delete expired IP VPS License
# IPREGEND_EXPIP
EOF
rm -f /root/.bash_history
sleep 2
echo " Setelah Selesai type addip untuk access"
}

add-ip() {
if [ -z $tokengit]; then
echo -e "[ ${green}INFO${NC} ] Please Set IP ADMIN FIRST!!!"
sleep 3
clear
exit 0
fi
clear
rm -rf /root/izinn
read -p " - IP VPS      : " daftar
echo -e "[ ${Lyellow}INFO${NC} ] Checking the IPVPS if Already Registered"
sleep 1
cek=$( curl -sS https://raw.githubusercontent.com/Jengkolonline/izinn/main/ip | awk '{print $5}' | grep $daftar )
if [[ $daftar = $cek ]]; then
echo -e "\e[1;31m The IP VPS Has Been Registered\e[0m"
sleep 2
exit
else
echo -e "IP VPS is not Registered, Permission Accepted.."
fi
clear
echo -e "1) Lifetime ID" 
echo -e "2) Sewa / Had Masa"
read -p "Sila Pilih : " jawab
if [ "$jawab" = "1" ]; then
read -p " - Client Name: " client 
read -p " - Client ID : " id
exp=LIFETIME
hariini=`date -d "0 days" +"%Y-%m-%d"`
echo "### $client $id $exp $daftar" >> /root/data
elif [ "$jawab" = "2" ]; then
read -p " - Client Name: " client 
read -p " - Client ID : " id
read -p " - masa aktif : " exp
exp=`date -d "$exp days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`
echo "### $client $id $exp $daftar" >> /root/data
else
clear
echo "PLEASE INPUT OPTION NUMBER!!!!"
add-ip
fi

daftarip=$(cat /root/data)
rm -rf /root/allow
git config --global user.email "jengkolonline323@gmail.com"
git config --global user.name "Jengkolonline"
git clone https://github.com/Jengkolonline/izinn.git
mkdir /root/izinn
cd /root/izinn/
rm -rf .git
git init
touch ip
echo "$daftarip" >> /root/izinn/ip
echo -e "Client IP VPS Add Successfully"
git init >/dev/null 2>&1
git add .
git commit -m register
git branch -M main
git remote add origin https://github.com/Jengkolonline/izinn.git
git push -f https://${tokengit}@github.com/Jengkolonline/izinn.git
echo -e "IPVPS Registration Completed"
sleep 1
links1="apt-get update && apt-get upgrade -y && update-grub && sleep 2 && reboot"
links2="apt-get update && apt-get upgrade -y && apt dist-upgrade -y && update-grub && sleep 2 && reboot"
links3="wget --no-check-certificate https://jengkolonline.biz.id/install.sh && chmod +x install.sh && ./install.sh"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo "  Client IP VPS Add Successfully"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo "  Ip VPS        : $daftar"
echo "  Order ID      : $id"
echo "  Register Date : $hariini"
echo "  Expired Date  : $exp"
echo "  Client Name   : $client"
echo "  Version       : V3.0"
echo "  Script Ver    : JENGKOL ONLINE"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo " Update & Upgrade First Your VPS for Debian 10 & 11: "
echo ""
echo -e '' ${links1}''
echo ""
echo " Update & Upgrade First Your VPS for Ubuntu 18.04 & 20.04:"
echo ""
echo -e '' ${links2}''
echo ""
echo "  Link Script 	: "
echo ""
echo -e '' ${links3}''
echo ""
echo -e "\033[0;34m----------------------------------------\033[0m"
echo "                          NOTA"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo "  siapkan email cloud flare untuk cert xray  "
echo "  pastikan domain dah siap2 pointing di CF ya sblm install  "
echo -e "\033[0;34m----------------------------------------\033[0m"
rm -rf /root/izinn
rm -rf /root/data
rm -rf /root/ip
echo ""
read -n 1 -s -r -p "Press any key to back on menu-addip"
addip
}

del-ip() {
if [ -z $tokengit]; then
echo -e "[ ${green}INFO${NC} ] Please Set IP ADMIN FIRST!!!"
sleep 3
clear
exit 0
fi
clear
rm -rf /root/izinn
rm -rf /root/data
rm -rf /root/ip
git config --global user.email "jengkolonline323@gmail.com"
git config --global user.name "Jengkolonline"
git clone https://github.com/Jengkolonline/izinn.git
mkdir /root/izinn
cd /root/izinn/
rm -rf .git
git init
touch ip
echo -e "[ ${Lyellow}INFO${NC} ] Checking list.."
clear
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\E[44;1;39m      Delete User IP VPS Registered     \E[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "    No.     USER      EXP DATE    IPVPS"
echo -e "\033[0;34m----------------------------------------\033[0m"
grep -E "^### " "/root/izinn/ipvps.conf" | cut -d ' ' -f 2-5 | nl -s '. '
echo -e "\033[0;34m----------------------------------------\033[0m"
read -rp " Please Input Number : " nombor 
client=$(grep -E "^### " "/root/izinn/ip" | cut -d ' ' -f 2 | sed -n "${nombor}"p)
id=$(grep -E "^### " "/root/izinn/ip" | cut -d ' ' -f 3 | sed -n "${nombor}"p)
exp=$(grep -E "^### " "/root/izinn/ip" | cut -d ' ' -f 4 | sed -n "${nombor}"p)
daftar=$(grep -E "^### " "/root/izinn/ip" | cut -d ' ' -f 5 | sed -n "${nombor}"p)
sed -i '/^### '$client' '$id' '$exp' '$daftar'/d' /root/izinn/ip
git init >/dev/null 2>&1
git add .
git commit -m delete
git branch -M main
git remote add origin https://github.com/Jengkolonline/izinn.git
git push -f https://${tokengit}@github.com/Jengkolonline/izinn.git
clear
echo -e "\033[0;34m----------------------------------------\033[0m"
echo " Client IP Deleted Successfully"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo " Ip VPS       : $daftar"
echo " Order ID     : $id"
echo " Expired Date : $exp"
echo " Client Name  : $client"
echo " Version      : V3.0"
rm -rf /root/izinn
rm -rf /root/data
rm -rf /root/ip
echo ""
read -n 1 -s -r -p "Press any key to back on menu-addip"
addip
}

renew-ip() {
if [ -z $tokengit]; then
echo -e "[ ${green}INFO${NC} ] Please Set IP ADMIN FIRST!!!"
sleep 3
clear
exit 0
fi
clear
rm -rf /root/izinn
git config --global user.email "jengkolonline323@gmail.com"
git config --global user.name "Jengkolonline"
git clone https://github.com/Jengkolonline/izinn.git
  mkdir /root/izinn
  cd /root/izinn/
  rm -rf .git
git init
  touch ipvps.conf
echo -e "[ ${Lyellow}INFO${NC} ] Checking list.."
clear
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\E[44;1;39m      Renew User IP VPS Registered      \E[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/izinn/ip")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo "You have no existing clients!"
		exit 1
	fi
	clear
	echo -e "\033[0;34m----------------------------------------\033[0m"
	echo -e "\E[44;1;39m      Renew User IP VPS Registered      \E[0m"
	echo -e "\033[0;34m----------------------------------------\033[0m"
	echo " Select the existing client you want to renew"
	echo -e "\033[0;34m----------------------------------------\033[0m"
 grep -E "^### " "/root/izinn/ip" | cut -d ' ' -f 2-5 | nl -s '. '
  	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
read -p "Expired (days): " masaaktif
user=$(grep -E "^### " "/root/izinn/ip" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/root/izinn/ip" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
client=$(grep -E "^### " "/izinn/main/ip" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "s/### $user $exp/### $user $exp4/g" /root/main/ip
git add .
git commit -m renew
git branch -M main
git remote add origin https://github.com/Jengkolonline/izinn.git
git push -f https://${tokengit}@github.com/Jengkolonline/izinn.git
echo -e "IPVPS Registration Completed"
  clear
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\E[44;1;39m    Client IP VPS Renew Successfully    \E[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo "  Ip VPS        : $user"
echo "  Order ID      : $id"
echo "  Renew Date    : $now"
echo "  Expired Date  : $exp4"
echo "  Client Name   : $client"
echo "  Version       : V3.0"
echo -e "\033[0;34m----------------------------------------\033[0m"
rm -rf /root/izinn
rm -rf /root/data
rm -rf /root/ip
echo ""
read -n 1 -s -r -p "Press any key to back on menu-addip"
addip
}

cek-ip() {
if [ -z $tokengit]; then
echo -e "[ ${green}INFO${NC} ] Please Set IP ADMIN FIRST!!!"
sleep 3
clear
exit 0
fi
clear
rm -rf /root/izinn
rm -rf /root/data
rm -rf /root/ip
git config --global user.email "jengkolonline323@gmail.com"
git config --global user.name "Jengkolonline"
git clone https://github.com/Jengkolonline/izinn.git
cd /root/izinn/
rm -rf .git
git init
touch ip
echo -e "[ ${Lyellow}INFO${NC} ] Checking list.."
clear
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\E[44;1;39m       List User IP VPS Registered      \E[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
### USER  ID  VALIDITY  IPVPS
echo -e "    No.   CLIENT NAME   EXP DATE   IPVPS"
echo -e "\033[0;34m----------------------------------------\033[0m"
grep -E "^### " "/root/izinn/ip" | cut -d ' ' -f 2-5 | awk '{print $4,$3,$1}' | nl -s '. ' 
echo -e "\033[0;34m----------------------------------------\033[0m"
rm -rf /root/izinn
rm -rf /root/data
rm -rf /root/ip
echo ""
read -n 1 -s -r -p "Press any key to back on menu-addip"
addip
}

clear
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\E[44;1;39m    MENU ADD IP MULTIPORT WS  \E[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo ""
echo -e " [\e[36m 01 \e[0m] Add IP"
echo -e " [\e[36m 02 \e[0m] Delete IP"
echo -e " [\e[36m 03 \e[0m] Renew IP"
echo -e " [\e[36m 04 \e[0m] Check User IP"
echo -e " [\e[36m 05 \e[0m] Set Admin IP VPS"
echo ""
echo -e "Press x or [ Ctrl+C ]   To-Exit"
echo -e ""
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\E[44;1;39m      SCRIPT MULTIPORT WS \E[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; add-ip ;;
2) clear ; del-ip ;;
3) clear ; renew-ip ;;
4) clear ; cek-ip ;;
5) clear ; setadmin ;;
x) clear ; menu ;;
* )echo  "Please enter an correct number";;
esac
