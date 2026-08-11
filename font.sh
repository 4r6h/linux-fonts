#!/bin/bash

# ***************************************
# * Author: 4r6h/Rahat		        *
# * github: https://www.github.com/4r6h *
# ***************************************

   Off='\033[0m'	     # Text Reset

   # Regular Colors
   Black='\033[0;30m'        # Black
   Red='\033[0;31m'          # Red
   Green='\033[0;32m'        # Green
   Yellow='\033[0;33m'       # Yellow
   Blue='\033[0;34m'         # Blue
   Purple='\033[0;35m'       # Purple
   Cyan='\033[0;36m'         # Cyan
   White='\033[0;37m'        # White

   # Bold
   BBlack='\033[1;30m'       # Black
   BRed='\033[1;31m'         # Red
   BGreen='\033[1;32m'       # Green
   BYellow='\033[1;33m'      # Yellow
   BBlue='\033[1;34m'        # Blue
   BPurple='\033[1;35m'      # Purple
   BCyan='\033[1;36m'        # Cyan
   BWhite='\033[1;37m'       # White


echo -e "\n${BBlue}Welcome to Linux Font Installer from 4r6h/Rahat !!!"
echo -e "------------------------------------"
wgetexists=`/usr/bin/which wget`
fontcacheexists=`/usr/bin/which fc-cache`
if [[ `/usr/bin/which sudo` != "/usr/bin/sudo" ]];
then
    echo -e "\n${BRed}Sorry, you are not eligible to install these fonts.\n";\
    exit;
fi
echo -e "\n${BGreen}Now starting to download and install all fonts..........."
echo -e "------------------------------------\n"

if [ "$wgetexists" != "/usr/bin/wget" -o $fontcacheexists != "/usr/bin/fc-cache" ]
then
    if [ -z "$1" ]
    then
        echo -e "\n${BRed}No argument supplied.";
        echo -e "This script needs specific tools to work perfectly.";
        echo -e "The required tools need to be installed before continuing.\n";
        echo -e "${BGreen}1. wget";
        echo -e "${BGreen}2. fontconfig\n";
        read -p "${BRed}Continue (y/n)? " choice;
        case "$choice" in 
          y|Y ) if [ "$wgetexists" != "/usr/bin/wget" -o $fontcacheexists != "/usr/bin/fc-cache" ]; then sudo pacman -Syy fontconfig wget --noconfirm --needed;fi;;
          n|N ) echo -e "${BRed}Bye Bye !\n";exit;;
          * ) echo -e "${BRed}Invalid !\n"; exit;;
        esac
    fi
fi
#--
if [ ! -z "$1" ]
  then
    echo -e "${BRed}Argument supplied: $1";
    if [[ "$1" == "install" ]];
    then
        if [ "$wgetexists" != "/usr/bin/wget" -o $fontcacheexists != "/usr/bin/fc-cache" ]
        then
            sudo pacman -Syy fontconfig wget --noconfirm --needed;
        fi
    else
        echo -e "\n${BRed}Invalid Argument Passed !";
        exit;
    fi
fi

urls=(
'https://raw.githubusercontent.com/4r6h/linux-fonts/master/archieve/Linux-Arabic-Fonts.tar.gz'
'https://raw.githubusercontent.com/4r6h/linux-fonts/master/archieve/Linux-Bangla-Fonts.tar.gz' 
'https://raw.githubusercontent.com/4r6h/linux-fonts/master/archieve/Linux-Urdu-Fonts.tar.gz'
'https://raw.githubusercontent.com/4r6h/linux-fonts/master/archieve/Linux-Urdu-Arabic-Fonts.tar.gz'
)

# Directory
echo -e "\n${BYellow}Now creating the font directory for user: $USER."
if [ $USER = "root" ]; then
  fontsDir="/root/.fonts/Linux-Fonts/"
fi

if [ $USER != "root" ]; then
  fontsDir="/home/$USER/.fonts/Linux-Fonts/"
fi

if [ ! -d "$fontsDir" ]; then
  mkdir -p $fontsDir;
else
  echo -e "\n${BGreen}Upgrading bangla fonts provided by us....";
  rm -r $fontsDir;
  mkdir -p $fontsDir;
fi

echo -e "\n${BGreen}Downloading compressed files from github.com....\n"

for url in "${urls[@]}"; do
	if echo $url | grep -q "Arabic"; then
		echo -e "\n${BPurple}Downloading $url\n" | sed 's|https://raw.githubusercontent.com/4r6h/linux-fonts/master/archieve/||'
	elif echo $url | grep -q "Bangla"; then
		echo -e "${BRed}Downloading $url\n" | sed 's|https://raw.githubusercontent.com/4r6h/linux-fonts/master/archieve/||'
	elif echo $url | grep -q "Urdu"; then
		echo -e "${BBlue}Downloading $url\n" | sed 's|https://raw.githubusercontent.com/4r6h/linux-fonts/master/archieve/||'
	else
		echo -e "${BCyan}Downloading $url\n" | sed 's|https://raw.githubusercontent.com/4r6h/linux-fonts/master/archieve/||'
	fi
		/usr/bin/wget -cqP $fontsDir "$url"
done

# Check if file is there and extractable
#fonts=(
#'Linux-Bangla-Fonts.tar.gz'
#'Linux-Urdu-Fonts.tar.gz'
#'Linux-Arabic-Fonts.tar.gz'
#)

cd $fontsDir

list=$(ls | grep ".*.tar.gz")

if [[ -e "Linux-Arabic-Fonts.tar.gz"  || -e "Linux-Bangla-Fonts.tar.gz" || -e "Linux-Urdu-Fonts.tar.gz" ]];
then
	echo -e "\n${BYellow}Downloaded font packages successfully to extract and install fonts !\n"
	for font in ${list}; do
		if [[ $font == "Linux-Bangla-Fonts.tar.gz" ]]; then 
			echo -e "\n${BRed}Extracting $font\n"

		elif [[ $font == "Linux-Urdu-Fonts.tar.gz" ]]; then 
			echo -e "\n${BBlue}Extracting $font\n"

		elif [[ $font == "Linux-Arabic-Fonts.tar.gz" ]]; then 
			echo -e "\n${BPurple}Extracting $font\n"
		else
			echo -e "\n${BCyan}Extracting $font\n"
		fi

		tar -zxvf $font
	done
		rm ${list}
else
	echo -e "${BRed}Fonts couldn't be retrieved. So exiting the installation.\n"
	exit
fi

cd

echo -e "\n"
echo -e "${BGreen}Initiating font refresh......\n"
/usr/bin/fc-cache -f -v
echo -e "\n"

echo -e "------------------------------------"
echo -e "Download and Installation Complete !!!"
echo -e "\n${BBlue}This Script was Created by 4r6h/Rahat"
echo -e "${BGreen}Follow me on Github github.com/4r6h${Off}\n"
