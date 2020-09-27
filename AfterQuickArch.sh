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

echo "--           Window Manager Install            --"
echo "                                                 "

#ask for the Window Manager which the user will want to install
echo "Please Enter the number which coresponds with the window manager you wish to install:"
echo "1 : Awesome         6 : Openbox    11 : Qtile       16 : Fluxbox   21 : JWM"
echo "2 : i3              7 : Bswm       12 : xmonad      17 : FVWM      22 : lwm"
echo "3 : i3-gaps         8 : spectrwm   13 : Blackbox    18 : IceWM     23 : Marco"
echo "4 : Metacity        9 : WMW        14 : PekWm       19 : ukwm      24 : Xfwm"
echo "5 : Herbstluftwm   10 : Notion     15 : Ratpoison   20 : sway      25 : none"

read WM

echo "--         Terminal Emulator Install           --"
echo "                                                 "

#ask for the Terminal Emulator which the user will want to install
echo "Please Enter the number which coresponds with the window manager you wish to install:"
echo "1 : Alacritty       3 : Konsole              5 : kitty             7 : Liri Terminal   9 : moserial"
echo "2 : PuTTY           4 : Qterminal            6 : Terminology       8 : urxvt          10 : xterm"
echo "3 : Yakuake         6 : Deepin Terminal      9 : GNOME Terminal   12 : Guake          15 : LXTerminal"
echo "4 : MATE terminal   8 : Pantheon Terminal   12 : sakura           16 : Terminator     20 : Termite"
echo "5 : Tilda          10 : Tilix               15 : Xfce Termianl    20 : KMSCON         25 : None"

read WM
