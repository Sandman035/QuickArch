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

#select EFI partition
echo "Please enter EFI partition: (example /dev/sda1)"
read EFI

#format EFI partition
mkfs.fat -F32 ${EFI}

#mount EFI partition
mount ${EFI} /mnt/efi

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
arch-chroot /mnt /bin/bash -c 'echo "Please enter time zone: (example Canada)"; read ZONE; echo "Please enter time subzone: (example Eastern)"; read SUBZONE; timedatectl set-timezone ${Zone}/${SubZone}; ln -sf /usr/share/zoneinfo/${ZONE}/${SUBZONE} /etc/localtime; echo "-- pick locale --"; nano /etc/locale.gen; locale-gen; echo "Please enter hostname:"; read HOSTNAME; echo ${HOSTNAME} > /etc/hostname; pacman -S networkmanager dhclient --noconfirm --needed; systemctl enable NetworkManager.service; passwd; pacman -S grub-bios --noconfirm --needed; echo "Please enter disk: (example /dev/sda)"; read DISK; grub-install --target=i386-pc ${DISK}; grub-mkconfig -o /boot/grub/grub.cfg'

##ask for time zone
#echo "Please enter time zone: (example Canada)"
#read ZONE

#echo "Please enter time subzone: (example Eastern)"
#read SUBZONE

##set the time zone
#timedatectl set-timezone ${Zone}/${SubZone}
#ln -sf /usr/share/zoneinfo/${ZONE}/${SUBZONE} /etc/localtime

#echo "-- pick locale --"

##edit /etc/locale.gen
#nano /etc/locale.gen

#generate locales
#locale-gen

##generate hostname
#echo "Please enter hostname:"
#read HOSTNAME
#echo ${HOSTNAME} > /etc/hostname

##install network manager
#pacman -S networkmanager dhclient --noconfirm --needed
#systemctl enable NetworkManager.service

##set the root password
#passwd

##install grub
#pacman -S grub-bios --noconfirm --needed

#grub-install --target=i386-pc ${DISK}

##create grub config file
#grub-mkconfig -o /boot/grub/grub.cfg

echo "------------------------------------------------"
echo "--            You may now reboot              --"
echo "------------------------------------------------"
