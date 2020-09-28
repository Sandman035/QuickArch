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
echo "|               -- WARNING! --                  |"
echo "|  This code may not suite your needs, so make  |"
echo "|           your own versions of it!            |"
echo "-------------------------------------------------"
echo "                                                 "
echo "                                                 "

#array of the package names for the available display servers
display_server=(xorg '')
#array of the package names for the available display drivers
display_driver=(mesa  '')
#array of the package names for the available desktop environments
desktop_environments=(gnome plasma budgie-desktop cinnamon deepin enlightenment lxde lxqt mate gnome-flashback ukui xfce4 '')
#array of the package names for the available window managers
window_managers=(awesome i3-wm i3-gaps metacity herbstluftwm openbox bspwm spectrwm openmotif notion qtile xmonad blackbox pekwm ratpoison fluxbox fvwm icewm ukwm sway jwm lwm marco xfwm4 '')

pacman -Sy

echo "--              Create a user                 --"

#make users in the wheel group be able to run sudo commands
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

#set up a user
echo "Please enter username:"
read USERNAME

useradd -G wheel -m ${USERNAME}
passwd ${USERNAME}

echo "--           Display Server Install            --"
echo "                                                 "

#ask for the Display Server which the user will want to install
echo "Please Enter the number which coresponds with the display server you wish to install:"
echo "1 : Xorg    2 : none"

read DS

echo "--           Display Driver Install            --"
echo "                                                 "

#ask for the Display Driver which the user will want to install
echo "Please Enter the number which coresponds with the display driver you wish to install:"
echo "1 : Intel    4 : none"

read DD

echo "--        Descktop Environment Install         --"
echo "                                                 "

#ask for the Desktop Environment which the user will want to install
echo "Please Enter the number which coresponds with the desktop environment you wish to install:"
echo "1 : Gnome     4 : Cinnamon       7 : LXDE     10 : GNOME Flashback   13 : None"
echo "2 : KDE       5 : Deepin         8 : LXQt     11 : UKUI"
echo "3 : Budgie    6 : Enlightenment  9 : MATE     12 : Xfce"

read DE

echo "--           Window Manager Install            --"
echo "                                                 "

#ask for the Window Manager which the user will want to install
echo "Please Enter the number which coresponds with the window manager you wish to install:"
echo "1 : Awesome         6 : Openbox    11 : Qtile       16 : Fluxbox   21 : JWM"
echo "2 : i3              7 : Bspwm      12 : xmonad      17 : FVWM      22 : lwm"
echo "3 : i3-gaps         8 : spectrwm   13 : Blackbox    18 : IceWM     23 : Marco"
echo "4 : Metacity        9 : MWM        14 : PekWm       19 : ukwm      24 : Xfwm"
echo "5 : Herbstluftwm   10 : Notion     15 : Ratpoison   20 : sway      25 : none"

read WM

echo "--         Terminal Emulator Install           --"
echo "                                                 "

#ask for the Terminal Emulator which the user will want to install
echo "Please Enter the number which coresponds with the terminal emulator you wish to install:"
echo "1 : Alacritty       3 : Konsole              5 : kitty             7 : Liri Terminal   9 : moserial"
echo "2 : PuTTY           4 : Qterminal            6 : Terminology       8 : urxvt          10 : xterm"
echo "3 : Yakuake         6 : Deepin Terminal      9 : GNOME Terminal   12 : Guake          15 : LXTerminal"
echo "4 : MATE terminal   8 : Pantheon Terminal   12 : sakura           16 : Terminator     20 : Termite"
echo "5 : Tilda          10 : Tilix               15 : Xfce Termianl    20 : KMSCON         25 : None"

read TERMINAL

echo "--             Text Editor Install             --"
echo "                                                 "

#ask for the Text editor which the user will want to install
echo "Please Enter the number which coresponds with the text editor you wish to install:"
echo "1 : e3        9 : JOE                    17 : mcedit            25 : nano             33 : Acme"
echo "2 : Adie     10 : Atom                   18 : Beaver            26 : Deepin Editor    34 : FeatherPad"
echo "3 : gedit    11 : Gobby                  19 : Howl              27 : jEdit            35 : Kate"
echo "4 : Kwrite   12 : L3afpad                20 : leafpad           28 : Liri Text        36 : Mousepad"
echo "5 : NEdit    13 : Notepadqq              21 : Pantheon Code     29 : Pluma            37 : Sam"
echo "6 : SciTE    14 : Visual Studio Code     22 : xed               30 : XEdit            38 : Emacs"
echo "7 : mg       15 : Zile                   23 : Kakoune           31 : Neovim           39 : None"
echo "8 : vi       16 : vim                    24 : Vis               32 : Neovim-Qt"

read TEXT

#substracts one from each input giving by user because arrays start at 0 and not 1
DS=$(($DS - 1))
DD=$(($DD - 1))
DE=$(($DE - 1))
WM=$(($WM - 1))
TERMINAL=$(($TERMINAL - 1))
TEXT=$(($TEXT - 1))

#the actuall instalation of the packages chosen above (I could have done this in one line but I chose not to)
pacman -S ${display_server[${DS}]}
pamcan -S ${display_driver[${DD}]} --noconfirm --needed
pacman -S ${desktop_environments[${DE}]} --noconfirm --needed
pacman -S ${window_managers[${WM}]} --noconfirm --needed
