#!/bin/sh
echo "-------------------------------------------------"
echo "               -- Quick Arch --                  "
echo "         --A fast way to install Arch--          "
echo "   --For more information go to the Arch wiki--  "
echo "-------------------------------------------------"
echo "                                                 "
echo "-------------------------------------------------"
echo "|               -- WARNINGS! --                 |"
echo "|  This code may not suite your needs, so make  |"
echo "|   your own versions of it! You need a basic   |"
echo "|     understanding of how to install arch.     |"
echo "-------------------------------------------------"
echo "                                                 "
echo "                                                 "

echo "                                                 "
echo "-------------------------------------------------"
echo "--   Update the system clock and pick mirrors  --"
echo "-------------------------------------------------"

#install nano
pacman -Sy nano --noconfirm

#update sytem clock
timedatectl set-ntp true

echo "--            pick your mirrors                --"

#open the mirrorlist to pick mirrors
nano /etc/pacman.d/mirrorlist

#refresh mirrors
pacman -Sy --noconfirm

echo "------------------------------------------------"
echo "--               Partitioning                 --"
echo "------------------------------------------------"


#show list of disks
lsblk

#ask for disk name
echo "Please enter disk: (example /dev/sda)"
read DISK

#instructions
echo "--          Partition your hardrive           --"

#open cfdisk
cfdisk ${DISK}

#select root partition
echo "Please enter root partition: (example /dev/sda1)"
read ROOT

echo "------------------------------------------------"
echo "--       Warning all data will be lost!       --"
echo "------------------------------------------------"

#format root partition
mkfs.ext4 ${ROOT}

#mount root partition
mount ${ROOT} /mnt

#ask if you made a swap partition
echo "Do you have a swap partition: (yes,no)"
read YESNO

if [ ${YESNO} == "yes" ]
then
    #select swap partition
    echo "Please enter swap partition: (example /dev/sda1)"
    read SWAP

    #format swap partition
    mkswap ${SWAP}
    swapon ${SWAP}
fi

#ask for an existing home partition
echo "Did you have a seperate Home partition set up before the install: (yes, no)"
read YNHOME

if [ ${YNHOME} == "yes" ]
then
    #ask for the existing home partition
    echo "Please enter home partition: (example /dev/sda1)"
    read HOME

    #mount home partition
    mount ${HOME} /mnt/home
else
   #ask for a new home partition if you didn't have an existing one
    echo "Did you make a new Home partition: (yes, no)"
    read YESNOHOME

    if [ ${YESNOHOME} == "yes" ]
    then
        #ask for new home partition
        echo "Please enter home partition: (example /dev/sda1)"
        read NEWHOME
        
        #format new home partition
        mkfs.ext4 ${NEWHOME}

        #mount new home parition
        mount ${NEWHOME} /mnt/home

    fi
fi


#ask if you have made an efi partition
echo "Did you make an efi partition: (yes, no)"
read YESNOEFI

if [ ${YESNOEFI} == "yes"]
then
    #ask for efi partition
    echo "Please enter the efi partition: (example /dev/sda1)"
    read EFI
    
    echo "------------------------------------------------"
    echo "--       Warning all data will be lost!       --"
    echo "------------------------------------------------"

    #format efi partition
    mkfs.fat32 ${EFI}

    #mount efi partition
    mount ${EFI} /mnt/efi

fi

echo "------------------------------------------------"
echo "--         Arch Install on Main Drive         --"
echo "------------------------------------------------"

#install arch with some other packages
pacstrap /mnt base base-devel linux linux-firmware nano sudo --noconfirm --needed

echo "------------------------------------------------"
echo "--           Configure the system             --"
echo "------------------------------------------------"

#generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

#change root into the new system
arch-chroot /mnt 

#ask for time zone
echo "Please enter time zone: (example Canada)"
read ZONE

echo "Please enter time subzone: (example Eastern)"
read SUBZONE

#set the time zone
timedatectl set-timezone ${Zone}/${SubZone}
ln -sf /usr/share/zoneinfo/${ZONE}/${SUBZONE} /etc/localtime

echo "-- pick locale --"

#edit /etc/locale.gen
nano /etc/locale.gen

#generate locales
locale-gen

#generate hostname
echo "Please enter hostname:"
read HOSTNAME
echo ${HOSTNAME} > /etc/hostname

#install network manager
pacman -S network-manager dhclient --noconfirm --needed
systemctl enable --now NetworkManager

#set the root password
passwd

#install grub
pacman -S grub-bios --noconfirm --needed

if [ ${YESNOEFI} == "yes" ]
then
    grub-install --target=x86_64-efi --efi-directory=/mnt/efi --bootloader-id=GRUB
else
    grub-install ${DISK}
fi

#create a new initramfs
mkinitcpio -P

#create grub config file
grub-mkconfig -o /boot/grub/grub.cfg

#exit out of chroot
exit

echo "------------------------------------------------"
echo "--            You may now reboot              --"
echo "------------------------------------------------"
