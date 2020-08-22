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

#ask if you want to continue with install
echo "Would you like to continue with the install: (yes,no)"
read INSTALL
if [${INSTALL} == no]
then
    reboot
fi

echo "                                                 "
echo "-------------------------------------------------"
echo "--   Update the system clock and pick mirrors  --"
echo "-------------------------------------------------"

#update sytem clock
timedatectl set-ntp true

#install nano
pacman -S nano --noconfirm

#open the mirrorlist to pick mirrors
nano /etc/pacman.d/mirrorlist

#refresh mirrors
pacman -Syyy --noconfirm

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

#format root partition
mkfs.etx4 ${ROOT}

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

#list time zones
timedatectl list-timezones

#ask for time zone
echo "Please enter time zone: (example Canada)"
read ZONE

echo "Please enter time subzone: (example Eastern)"
read SUBZONE

#set the time zone
timedatectl set-timezone ${Zone}/${SubZone}
ln -sf /usr/share/zoneinfo/${ZONE}/${SUBZONE} /etc/localtime

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
grub-install ${DISK}

#create a new initramfs
mkinitcpio -P

#create grub config file
grub-mkconfig -o /boot/grub/grub.cfg

#exit out of chroot
exit

echo "------------------------------------------------"
echo "--            You may now reboot              --"
echo "------------------------------------------------"
