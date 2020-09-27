#!/bin/sh

#######################################################################################
#   ▄████████    ▄████████ ███▄▄▄▄   ████████▄    ▄▄▄▄███▄▄▄▄      ▄████████ ███▄▄▄▄  # 
#  ███    ███   ███    ███ ███▀▀▀██▄ ███   ▀███ ▄██▀▀▀███▀▀▀██▄   ███    ███ ███▀▀▀██▄# 
#  ███    █▀    ███    ███ ███   ███ ███    ███ ███   ███   ███   ███    ███ ███   ███# 
#  ███          ███    ███ ███   ███ ███    ███ ███   ███   ███   ███    ███ ███   ███# 
#▀███████████ ▀███████████ ███   ███ ███    ███ ███   ███   ███ ▀███████████ ███   ███# 
#         ███   ███    ███ ███   ███ ███    ███ ███   ███   ███   ███    ███ ███   ███# 
#   ▄█    ███   ███    ███ ███   ███ ███   ▄███ ███   ███   ███   ███    ███ ███   ███# 
# ▄████████▀    ███    █▀   ▀█   █▀  ████████▀   ▀█   ███   █▀    ███    █▀   ▀█   █▀ # 
#######################################################################################

echo "-------------------------------------------------"
echo "      _____     _     _   _____         _        "
echo "     |     |_ _|_|___| |_|  _  |___ ___| |_      "
echo "     |  |  | | | |  _| '_|     |  _|  _|   |     "
echo "     |__  _|___|_|___|_,_|__|__|_| |___|_|_|     "
echo "        |__|                                     "
echo "                                                 "
echo "         --A fast way to install Arch--          "
echo "   --For more information go to the Arch wiki--  "
echo "                --Post install--                 "
echo "-------------------------------------------------"
echo "                                                 "
echo "-------------------------------------------------"
echo "|               -- WARNINGS! --                 |"
echo "|  This code may not suite your needs, so make  |"
echo "|           your own versions of it!            |"
echo "-------------------------------------------------"
echo "                                                 "
echo "                                                 "

pacman -Sy

echo "--              Create a user                 --"

#make users in the wheel group be able to run sudo commands
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

#set up a user
echo "Please enter username:"
read USERNAME

useradd -G wheel -m ${USERNAME}
passwd ${USERNAME}

echo "--        Descktop Environment Install         --"
echo "                                                 "

#ask for the Desktop Environment which the user will want to install
echo "Please Enter the number which coresponds with the desktop environment you wish to install:"
echo "1 : Gnome     4 : Cinnamon       7 : LXDE     10 : Sugar   13 : None"
echo "2 : KDE       5 : Deepin         8 : LXQt     11 : UKUI"
echo "3 : Budgie    6 : Enlightenment  9 : MATE     12 : Xfce"

read DE

