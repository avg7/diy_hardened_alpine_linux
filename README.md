Alpine Linux Live USB Stick or Memory Card (incl. Sway) + DIY Linux kernel & hardening (e.g. for Single-Board Computers incl. U-Boot)  
--------------------------------------------------------------------------

Note: 
Always read the notes in the text file named "LICENSE.txt" (which is located in the same folder as this text file) regarding copyrights, licenses and copying rights before using or distributing text contents and files. All content and files are copyrighted according to the information in the file named "LICENSE.txt".

1. Download Alpine Linux at alpinelinux.org/downloads.

Optional: Compile Linux Kernel (follow the instructions from the section "Compiling Linux Kernel" at the end of this text file). After that (and whenever Alpine Linux (with your compiled Linux Kernel) needs to be updated) follow the instructions from the section "Creating and modifying needed Alpine Linux files" at the end of this text file. If you need U-boot, compile U-boot (follow the instructions from the "Compiling U-boot" section at the end of this text file). 

2. Open or mount the downloaded Alpine Linux ISO image file and copy the included folders named "apks", "boot", and "efi" to an empty storage medium with FAT32 file system. Alpine Linux is then located on this storage medium. Add in the file "boot/extlinux/extlinux.conf" or "boot/grub/grub.cfg" to the end of the line, which containing the string "modules=", this: "vsyscall=none mce=0 slab_nomerge init_on_free=1 mds=full,nosmt page_alloc.shuffle=1 extra_latent_entropy module.sig_enforce=1 randomize_kstack_offset=on apparmor=1 lsm=landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo"

Optional: If you compiled the Linux Kernel, use your folder named "boot" (which contains your files "config-X.X.X", "initramfs-ready", "modloop-ready", "System.map-X.X.X" and "vmlinuz-X.X.X" and optionally the folders "dtbs" and "extlinux").

Open terminal on your Alpine Linux storage medium, and create a checksum-file:

```
    find . -type f -exec sha512sum {} \; > 512checksums.sha
```

3. Adapt the scripts server-apk.sh and sway-apk.sh to install additional software. Then place the scripts server-apk.sh, sway-apk.sh and addapk.sh on the storage medium from step 2, on which Alpine Linux is located. Disconnect all storage media from the PC (e.g. ROCK64 or ROC-RK3328 Renegade board), then connect only the Alpine Linux storage media to the PC and boot the PC. Connect PC to the Internet, login with username "root" without password, configure keyboard layout with command "setup-keymap", enter the following command and follow the instructions:

Note: Always replace "usb" in the following with the name of the storage medium

```
    sh /media/usb/addapk.sh
```
4. Switch on other operating system and connect Alpine Linux storage medium to PC, open it and copy the contained folders "serverapk" and "swayapk" to PC. Format Alpine Linux storage medium and repeat step 2, then continue here. Copy the folders "serverapk", "swayapk", "files", "historyserver", "historysway" and "admin" and the files "server.sh", "server2.sh" and "sway.sh" to the Alpine Linux storage medium.

5. Disconnect all storage media from the PC, then connect only the Alpine Linux storage medium to the PC and start the PC, log in with the user name "root" without password, configure the keyboard layout with the command "setup-keymap", enter the following commands and follow the instructions:
```
    sh /media/usb/server.sh  
    sudo sh /media/usb/server2.sh
```
If you need Sway

    sudo sh /media/usb/sway.sh

Done.

##### Note: Since a kernel panic can occur at any time, while using your DIY Linux kernel with e.g. Alpine Linux, you should back up important files regularly. If the ROCK64 board does not boot, reboot it by pressing the button on the side of the board until it works.

For more information see wiki.alpinelinux.org/wiki/Sway

Translated with www.DeepL.com/Translator (free version)

#### Please read the following notes!



Important Tips:
---------------

#### Always after you start Alpine Linux:
The script "/etc/files/startscript.sh" runs automatically at boot (see "/etc/local.d/boot.start").
After you login you can control the checksums from this file (displayed after you login with the user "admin"): localhost.apkovl.tar.gz

You can also control the number of files which are on your usb storage device (displayed after you login with the user "admin").

If you want to save all changes and files in the user folders or if you have installed software, you must run the the following commands whereby the usb storage device with Alpine Linux must be connected to your pc:

    sudo sh save.sh

You can run "sudo sh umount.sh" to remove the usb storage device with Alpine Linux (Important: Then you can not run "sudo sh save.sh" in this session)

If you want monitoring the logfiles "/var/log/messages" (with logwatch) and "/var/log/audit/audit.log" (with aureport) and processes (with ps) and see the audit system and service status, open a terminal and run:

    sudo sh /etc/files/log.sh

To connect to the Internet run:

    sh inet.sh

You can remove the user "admin" from "/etc/sudoers" with the command "sudo sed -i '/admin/d' /etc/sudoers", or run "sudo sh /etc/files/noroot.sh" or "sudo sh end.sh" (after you have started sway) (Important: Then nobody can use sudo, you can not use "sudo lbu commit" in this session).

To create a checksum-file with SHA512 checksums open terminal in a folder and run:

    find . -type f -exec sha512sum {} \; > 512checksums.txt
    Verify files in checksum-file:
    sha512sum -c 512checksums.txt


#### Before you start Sway with the command "sway":

Read "/etc/sway/config".

If you want to enable xwayland, remove the line "xwayland disable" from "/etc/sway/config".

You can set time and date with this commands:

    sudo date --set YYYY-MM-DD
    sudo date --set HH:MM:SS 


#### After you have started Sway:

Before you connect your pc to the internet you should open a terminal and run: 

    sudo sh end.sh 

(Important: Then nobody can use sudo, you can not use "sudo lbu commit" in this session. With the command "sudo sh end.sh" you also remove the usb storage device with Alpine Linux.). You should also find out if Sway is running as root: For example run the command "top" and search a process with the name "sway", which is running as "root" (the process is running as root if in the field "user" you can see "root"). Then run the following command (replace pid with the process ID): 

    kill pid

With the command "sh ffc.sh" you can copy the file "user.js" in the right folder, to use it with Firefox.

#### Mount usb storage devices:
Start Sway and connect the usb storage device to your pc. Then the usb storage device symbol is displayed in the Yambar-Status-Bar, click on this symbol to mount and unmount it.

How it works:
#### How to edit "/etc/fstab" to mount usb storage devices without sudo:
Find the name of the usb storage device (eg. "sda1" etc.) with eg. the command "sudo fdisk -l" or "lsblk".

Run (replace "usb" with the name of the usb storage device):

    mkdir /media/usb

Insert in "/etc/fstab" this line (replace "usb" with the name of the usb storage device):

    /dev/usb /media/usb auto noauto,nosuid,nodev,noexec,user 0 0

Run:

    sudo visudo

Then insert the following line (replace "account" with your username or with a group in which you are (then add "%" to the beginning of the group name: "%group") and replace "usb" with the name of the usb storage device):

    account ALL=(ALL) NOPASSWD: /bin/umount /dev/usb

Now you can mount the usb storage device with (You must run at first "sudo chmod +s /bin/su"):

    mount /dev/usb

To unmount:

    sudo umount /dev/usb

#### Mount usb storage devices automatically without having to change the file "/etc/fstab" eg.:
Install eg. udevil or udisks2 and dbus (Important: You must run at first "sudo chmod +s /bin/su" or "sudo sh vor_sway.sh"):
 
For udisks2 you must enable dbus, run: 

    sudo rc-update add dbus

Then save the changes and restart the pc.


Recommendations for Firefox etc.: kuketz-blog.de/firefox-ein-browser-fuer-datenschutzbewusste-firefox-kompendium-teil1, wiki.kairaven.de, privacy-handbuch.de, madaidans-insecurities.github.io/guides/linux-hardening.html, kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings

You can contact us (Website: avg7.de) eg. if you need a Single-Board Computer, Chaoskey, Nitrokey, uSDlocker (https://www.tindie.com/products/crimier/usdlocker-make-true-read-only-microsd/), SD card locker (https://www.tindie.com/products/CRImier/sd-card-locker-make-true-read-only-sdmicrosd/) or other Open-Source-Hardware.


### Compiling Linux Kernel for eg. ROCK64 or ROC-RK3328-CC Board
Why we chose a ROCK64 or ROC-RK3328-CC Board for Alpine Linux & kernel compiling: Open Source & immune to original Spectre and Meltdown and 4 GB RAM. (the following instructions also work for other boards if you modify them)

You can compile the current stable kernel from https://www.kernel.org/ on Debian (Armbian) without problems on a computer with an ARM processor (for example rock64 or ROC-RK3328-CC (Renegade) board).

Download for example the operatingsystem Armbian (Debian) from https://www.armbian.com/rock64/. Check download integrity and authenticity (https://docs.armbian.com/User-Guide_Getting-Started/) and install the operatingsystem on the two microSD cards.

If you want do optional section 1, then in "/etc/apt/sources.list" must be the same mirror as in optional section 1 (for example "http://ftp.debian.org/debian/"), then download requiered packages for compiling:

    sudo apt-get update

For Debian (if you use latest Debian for server): 

    sudo apt-get --no-install-suggests --no-install-recommends install --reinstall --download-only build-essential dpkg-dev fakeroot gcc-10 libncurses5-dev libssl-dev make squashfs-tools unzip zip lzop bc 
    
Otherwise use the following command:

    sudo apt-get --no-install-suggests --no-install-recommends install --reinstall --download-only bison g++-arm-linux-gnueabi gcc-10-arm-linux-gnueabi zlib1g-dev fakeroot wget libusb-1.0-0 libusb-dev cpp-10-arm-linux-gnueabihf g++-arm-linux-gnueabihf gcc-10-arm-linux-gnueabihf-base flex binutils-arm-linux-gnueabihf u-boot-tools swig4.0 make bc gcc-10 gcc-10-arm-linux-gnueabihf build-essential curl device-tree-compiler dosfstools flex python3.9-dev gdisk git gnupg gperf libc6-dev libncurses5-dev gcc libpython3.9-dev libssl-dev libssl1.1 libelf-dev lzop mtools parted repo swig tar zip devscripts libncurses5 squashfs-tools unzip 

Packages for gcc-plugins (replace "X" with current version number)

    sudo apt-get --no-install-suggests --no-install-recommends install --reinstall --download-only gcc-X-plugin-dev
 
To cross-compile:

    sudo libasan6-armel-cross libasan6-armhf-cross gcc-10-cross-base libc6-armel-cross libc6-armhf-cross libatomic1-armel-cross libatomic1-armhf-cross libgcc-s1-armel-cross libgcc-s1-armhf-cross libc6-dev-armel-cross libc6-dev-armhf-cross libgomp1-armel-cross libgomp1-armhf-cross libgcc-10-dev-armel-cross libgcc-10-dev-armhf-cross libubsan1-armel-cross libubsan1-armhf-cross libstdc++-10-dev-armel-cross linux-libc-dev-armel-cross linux-libc-dev-armhf-cross libstdc++-10-dev-armhf-cross cpp-10-aarch64-linux-gnu gcc-10-aarch64-linux-gnu gcc-10-aarch64-linux-gnu-base libasan6-arm64-cross libatomic1-arm64-cross libc6-arm64-cross libgcc-10-dev-arm64-cross libgcc-s1-arm64-cross libgomp1-arm64-cross libitm1-arm64-cross liblsan0-arm64-cross libstdc++6-arm64-cross libtsan0-arm64-cross libubsan1-arm64-cross cpp-aarch64-linux-gnu gcc-aarch64-linux-gnu gcc-10-arm-linux-gnueabihf-base  g++-10-arm-linux-gnueabi g++-10-arm-linux-gnueabihf cpp-10-arm-linux-gnueabi cpp-10-arm-linux-gnueabihf binutils-aarch64-linux-gnu binutils-arm-linux-gnueabi binutils-arm-linux-gnueabihf gcc-10-arm-linux-gnueabi gcc-10-arm-linux-gnueabi-base gcc-10-arm-linux-gnueabihf 
 
Optional information:
Almost all packages for compile a linux kernel with Armbian (Debian):

    sudo apt-get install --download-only binutils binutils-common bison build-essential cpp-10 curl devscripts dh-python dirmngr dosfstools dpkg-dev fakeroot file flex g++-10 gcc-10 gcc-10-plugin-dev gdisk genisoimage git git-man gnupg gnupg-l10n gnupg-utils gperf gpg gpg-agent gpgconf gpgsm gpgv gpg-wks-client gpg-wks-server haveged libasan6 libatomic1 libb-hooks-op-check-perl libbinutils libbison-dev libc6-dev libcc1-0 libc-dev-bin libclass-method-modifiers-perl libcurl4 libdevel-callchecker-perl libdevel-globaldestruction-perl libdpkg-perl libdynaloader-functions-perl libelf-dev libencode-locale-perl liberror-perl libexpat1 libexpat1-dev libfakeroot libfile-homedir-perl libfile-listing-perl libfile-which-perl libgcc-10-dev libgdbm6 libgdbm-compat4 libgmp-dev libgmpxx4ldbl libgomp1 libhavege2 libhtml-parser-perl libhtml-tagset-perl libhtml-tree-perl libhttp-cookies-perl libhttp-date-perl libhttp-message-perl libhttp-negotiate-perl libimport-into-perl libio-html-perl libio-pty-perl libio-socket-ssl-perl libipc-run-perl libisl23 libitm1 liblsan0 liblwp-mediatypes-perl liblwp-protocol-https-perl liblzo2-2 liblzo2-2 libmagic1 libmagic-mgc libmodule-runtime-perl libmoo-perl libmpc3 libmpc-dev libmpdec3 libmpfr6 libmpfr-dev libncurses5 libncurses5-dev libncursesw6 libncursesw6 libnet-http-perl libnet-ssleay-perl libparams-classify-perl libperl5.32 libpython3.9 libpython3.9-dev libpython3.9-minimal libpython3.9-stdlib libpython3.9-dev libpython3-all-dev librole-tiny-perl libsigsegv2 libssl1.1 libssl-dev libstdc++-10-dev libstrictures-perl libsub-exporter-progressive-perl libsub-quote-perl libtimedate-perl libtinfo6 libtinfo-dev libtry-tiny-perl libtsan0 libubsan1 liburi-perl libusb-1.0-0-dev libwww-perl libwww-robotrules-perl linux-libc-dev lzop m4 make mime-support mtools patch patchutils perl perl-modules-5.32 perl-openssl-defaults python3.9 python3.9-dev python3.9-minimal python3-distutils python3-lib2to3 python3-kerberos repo squashfs-tools swig4.0 wdiff zip zlib1g-dev device-tree-compiler bc gzip unzip u-boot-tools

End of the optional information

The downloaded software packages will be saved in /var/cache/apt/archives directory.

Optional section 1:
Create new folder and open terminal in this new folder.
Verify integrity of software packages for compiling offline
Download at first the Archive Signing Keys:

    wget https://ftp-master.debian.org/keys/archive-key-11.asc
    wget https://ftp-master.debian.org/keys/archive-key-11-security.asc

Compare the fingerprints of the keys with the fingerprints on https://ftp-master.debian.org/keys/:
    
    gpg --import-options show-only --import archive-key-11.asc
    gpg --import-options show-only --import archive-key-11-security.asc

Import the keys:

    gpg --import archive-key-11.asc
    gpg --import archive-key-11-security.asc

Check if the keys has been signed:

    gpg --list-sig

Download the following files or create a textfile with text from the files on following sites:

    wget https://ftp.debian.org/debian/dists/stable/InRelease
    wget https://ftp.debian.org/debian/dists/stable/main/binary-arm64/Packages.gz
    wget https://ftp.debian.org/debian/dists/stable/contrib/binary-arm64/Packages.gz
    wget https://security.debian.org/debian-security/dists/stable-security/InRelease
    wget https://security.debian.org/debian-security/dists/stable-security/main/binary-arm64/Packages.gz
    wget https://security.debian.org/debian-security/dists/stable-security/contrib/binary-arm64/Packages.gz

Check the file integrity from all InRelease files:

    gpg --verify InRelease
    gpg --verify InRelease.1

Compare the checksums of the Packages.gz files with the checksums in the InRelease file

Copy the software packages from /var/cache/apt/archives files in a new folder and open terminal in this folder and run in this folder the following command (this creates a list with sha256 checksums):

    find . -type f -exec sha256sum {} \; > Packages256checksums.sha

Rename the files Packages.gz.1,  Packages.gz.2, Packages.gz.3 to Packages1.gz, Packages2.gz, Packages3.gz
Run the following commands to unpack the gz files and create output.txt with the sha256 checksums from the package files: 

    gunzip Packages Packages1.gz Packages2.gz Packages3.gz; grep 'Package\|SHA256' 'Packages' > 'output.txt'; grep 'Package\|SHA256' 'Packages1' >> 'output.txt'; grep 'Package\|SHA256' 'Packages2' >> 'output.txt'; grep 'Package\|SHA256' 'Packages3' >> 'output.txt'

Edit output.txt (remove „SHA256: “):

    sed 's/SHA256: //g' 'output.txt' > 'PackagesListReadyToCompare.txt'

Now copy the file Packages256checksums.sha from the packages folder in the current folder and run:

    sed 's%\./.*%%' 'Packages256checksums.sha' > 'ChecksumsReadyToCompare.txt'

Create a list with all checksums that match:

    grep -Fw -f 'PackagesListReadyToCompare.txt' 'ChecksumsReadyToCompare.txt' > 'ListWithChecksumsThatMatch.txt'

Control if all checksums match (number should match)

    wc -l 'ListWithChecksumsThatMatch.txt'
    wc -l 'ChecksumsReadyToCompare.txt'

End of the optional section 1

Copy the software packages to a emty USB stick or microSD card, then install the software packages on the operatingsystem which will never connected to the internet: Run in the software packages folder on the offline operatingsystem:

    sudo dpkg -i *

Compile Kernel
Download needed files for kernel compiling:
Download kernel source code from https://www.kernel.org or https://github.com/ayufan-rock64. Recommendation (2023): Use kernel 5.15 for Single-Board Computers.
 
Optional: Download kernelpatch and sig file for your downloaded linux kernel version from https://github.com/anthraxx/linux-hardened/releases.

Check signature of the patch
Search on a pgp-keyserver for the pgp-key from anthraxx (Levente Polyak) and download the pgp-key from the pgp key server: http://pgp.zdv.uni-mainz.de:11371/pks/lookup?op=index&search=Levente+Polyak

Compare fingerprints:

    gpg --import-options show-only --import pgpkey.asc

Import pgp-key:

    gpg --import pgpkey.asc

Check patch signature:

    sudo gpg –verify linux-hardened.patch.sig linux-hardened.patch

End of optional section

Check signature from kernel archiv file:
Open terminal where the downloaded linuxkernel folder are and run following command (replace: "linux.tar.xz" with the name of the downloaded linuxkernel file)

    unxz -v linux.tar.xz

Look at the fingerprints on https://www.kernel.org/category/signatures.html, for example the fingerprint from the developer Greg Kroah-Hartman and search on a pgp-keyserver his pgp-key (the last eight digits from the fingerprint are displayed with the pgp-keys on the pgp-server): http://pgp.zdv.uni-mainz.de:11371/pks/lookup?op=index&search=Greg+Kroah-Hartman

Download the pgp-key then compare fingerprints:

    gpg --import-options show-only --import pgpkey.asc

Then import the pgp-key:

    gpg --import pgpkey.asc

Check kernel signature:

    sudo gpg –verify linux.tar.sign linux.tar

End of section “Check signature from kernel archiv file“

Download our kernel configuration file avg_config or copy the text of the configuration file at the bottom of this website.

Copy now all downloaded files to the offline operatingsystem.

### Compiling kernel
(see also: https://wiki.alpinelinux.org/wiki/DIY_Fully_working_Alpine_Linux_for_Allwinner_and_Other_ARM_SOCs)

Unpack kernel archiv file and go into linux kernel folder.

Optional: Apply linux-hardened Patch
Copy patch in kernelfolder.
Open Terminal in Kernel folder and run:

    patch -p1 < linux-hardened.patch

End of section “Apply linux-hardened Patch“

Rename the downloaded kernel configuration file from avg7.de or your file with the kernel configuration text from the bottom of this website to .config and copy it into kernel folder.

Open terminal in linux kernel folder and run:

    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- oldconfig

To edit kernel configuration, run:

    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig

If you need a custom Kernel configuration notice that the following must be set:
CONFIG_SQUASHFS=m (Squashfs 4.0 is in File systems under Miscellaneous filesystems <M>SquashFS 4.0)

CONFIG_BLK_DEV_LOOP=m (Device drivers -> Block devices -> <M>Loopback device support)

CONFIG_MODULES ([*] Enable loadable module support)

CONFIG_FRAMEBUFFER_CONSOLE (Device Drivers --->Graphics support --->Console display driver support --->[*]Framebuffer Console support)

CONFIG_UEVENT_HELPER=y ( ---> Device Drivers ---> Generic Driver Options ---> [*]Support for uevent helper)

CONFIG_EXT4_FS=m ( ---> File systems ---> [*]<M> The Extended 4 (ext4) filesystem)

Now save configuration (your .config file in the linux folder is updated now)

Optional check your Kernel configuration with the Kconfig hardened check: https://github.com/a13xp0p0v/kconfig-hardened-check

Optional 2:
Download the list from https://libreplanet.org/wiki/LinuxLibre:Devices_that_require_non-free_firmware and save it as a textfile with the name unfreelist. Compare it with your kernel configuration:

Create list with you can easy compare:

    sed 's/^/CONFIG_/' '/home/linux/Desktop/unfreelist' > '/home/linux/Desktop/unfreelistnew'

Compare:

    grep -vw -F '/home/linux/Desktop/unfreelistnew' linuxkernel/.config

End of the optional section 2

Now compile kernel:
Go into the kernel folder and open terminal there. Then you have two options to compiling:

Cross-compile (if you not compile on a ROCK64 or ROC-RK3328-CC (RENEGADE) board):

    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- deb-pkg

If you compile on eg. your rock64 or ROC-RK3328-CC (RENEGADE) board you can use the following command:

    make deb-pkg

If the compilation process finished there are files in the parent folder with the name linux and .deb file extension. Unpack the kernel image archiv file: First create new folder then copy the kernel archiv file which begins with the name linux-image in the new folder (not the file which include dbg in its filename)
 
    cd newfolder

Run in  the newfolder

    ar x linux-image.deb

Now go into the linux-image folder and unpack the data.tar.xz

    tar xf data.tar.xz

Go in the folder boot, if the file wich filename begins with vmlinuz is a Archiv then add the file extension .gz to the file name and run:

    gunzip vmlinuz-X.X.X.gz

Optional 3: Get needed firmware (with our kernel configuration file you usually don't need firmware)
First copy all modules from the unpacked kernel linux-image.deb into a new folder with the name emty_folder, to do that go into the folder which is in /lib/modules/ and run

    find . -name \*.ko -exec cp {} 'emty_folder' \;

Go in emty_folder open terminal there and run: 

    modinfo -F firmware * > needed_firmware.txt

Open the needed_firmware.txt, if this file is emty you don't need firmware. If the file is not emty create emty_folder2 and download firmware and signature file (sig) from https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/.

Go in download folder and run:

    gunzip linux-firmware-.tar.gz

Search on a pgp-keyserver for the pgp-key from Josh Boyer and download the pgp-key from the pgp key server.

Compare fingerprints:

    gpg --import-options show-only --import pgpkey.asc

Import pgp-key:

    gpg --import pgpkey.asc

Check signature:

    sudo gpg –verify linux-firmware-.tar.sig  linux-firmware-.tar

Then go in the downloaded firmwarefolder now we copy all needed firmware in emty_folder2 with the following command, run in the firmwarefolder:

    tar cvf - -T needed_firmware.txt | tar xvf - -C emty_folder2

End of the optional section 3


### Creating and modify needed Alpine Linux files:
Unpack Alpine Linux download file:

    tar -xzf alpine.tar.gz

Go in the Alpine Linux folder and remove there the folders you don't need. If there is the folder extlinux, copy this folder into the folder boot. Go into the folder boot and remove there the folder grub.

Creating Initramfs File
Now move from the folder boot the file initramfs-lts in a new emty folder and run in this new folder:

    gunzip -c initramfs-lts | cpio -i
    rm initramfs-lts

Go now into /lib/modules/ and replace the folder which is in this folder with the folder which is in the /lib/modules/ folder from the unpacked kernel linux-image.deb.

If you need firmware replace the firmware files in the folder /lib/firmware with your firmware.

Go now back into the new folder and run (replace otherpath whith a path from a other folder):

    find . | cpio -H newc -o | gzip -9 > /otherpath/initramfs-new

Go now into the other folder and run:

    mkimage -n initramfs-new -A arm64 -O linux -T ramdisk -C none -d initramfs-new initramfs-ready

Now there in the other folder should be a file with the name initramfs-ready
Move the file initramfs-ready in the folder boot in the alpine folder.

Creating modloop File
Go now into the folder boot in the Alpine Linux folder and move from there the file which begins with the name modloop in a new emty folder.

Go into the new folder and run:

    unsquashfs -f -d modloop modloop-file

Now delete the modloop-file.
Go into the folder modloop and there in the folder modules.
Replace the folder which is in this folder (not the folder with the name firmware) with the folder which is in the /lib/modules/ folder from the unpacked kernel linux-image.deb

If you need firmware replace the firmwarefiles in the folder /lib/firmware with your firmware.

Then go back into the new folder where the modloop folder are and run there:

    mksquashfs modloop/ modloop-ready -comp xz -Xdict-size 100%

Now there in the other folder should be a file with the name modloop-ready.
Copy the file modloop-ready in the folder boot in the alpine folder.

Copy needed files:
Copy now the files in the boot folder from the unpacked kernel linux-image.deb into the folder boot in the Alpine Linux folder.

Create in the folder boot in the Alpine Linux folder a folder with the name dtbs and copy into this folder the file rk3328-rock64.dtb or rk3328-roc-cc.dtb which should be in the folder from the unpacked kernel linux-image.deb in a directory /usr/lib/ in a folder with the name rockchip.

Creating new extlinux.conf eg. for ARM SoCs ROCK64 and ROC-RK3328-CC Board
Go into the folder boot in the Alpine Linux folder. Create a folder with the name extlinux if there is no folder with this name. Is in the folder extlinux a file with the name extlinux.conf open this file otherwise create a file with the name extlinux.conf. Delete all text in extlinux.conf if its not emty and insert the following text in the extlinux.conf file (replace XXX with your filenames of the files in the boot folder which is in the Alpine Linux folder):

    LABEL Linux X.X.X
    KERNEL /boot/vmlinuz-X.X.X
    INITRD /boot/initramfs-X.X.X
    FDT /boot/dtbs/rk3328-rock64.dtb (or rk3328-roc-cc.dtb)
    APPEND modules=loop,squashfs,sd-mod,usb-storage 


### Compiling U-boot
Step 1: Get the file bl31.elf
You can build ATF with Upstream arm-trusted-firmware repository to get the file
"bl31.elf" (Way 1) or you use the rk322xh_bl31_vXXX.elf (Way 2) file from rockchip rkbin repository.

Way 1 (build ATF with Upstream arm-trusted-firmware repository to get "bl31.elf")

Install the required packages (Debian / Ubuntu):

    sudo apt-get install --no-install-suggests --no-install-recommends device-tree-compiler build-essential gcc make git libssl-dev


To cross-compile:

    sudo apt-get install --no-install-suggests --no-install-recommends cpp-10-aarch64-linux-gnu gcc-10-aarch64-linux-gnu gcc-10-aarch64-linux-gnu-base libasan6-arm64-cross libatomic1-arm64-cross libc6-arm64-cross libgcc-10-dev-arm64-cross libgcc-s1-arm64-cross libgomp1-arm64-cross libitm1-arm64-cross liblsan0-arm64-cross libstdc++6-arm64-cross libtsan0-arm64-cross libubsan1-arm64-cross cpp-aarch64-linux-gnu gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu gcc-10-cross-base


Go into your Download folder and open Terminal there, then run:

    git clone https://github.com/ARM-software/arm-trusted-firmware
    cd arm-trusted-firmware

Optional 4:
Verify code archive integrity (see also: https://restic.net/blog/2015-09-16/verifying-code-archive-integrity).
- Replace in the following Y.Y with the tag version number
Download pgp-key from the developer (you can find the gpg key ID on https://github.com/ARM-software/arm-trusted-firmware/tags) who has signed the tag, check fingerprints, import key and verify tag: Go into arm-trusted-firmware folder and run the following command and verify the fingerprint:

    git tag --verify vY.Y

Now create a archive that contain the same repository as the release with the tag version, run in arm-trusted-firmware folder the following command:

    git archive --format=tar --prefix=arm-trusted-firmware-Y.Y/ vY.Y | gzip -n > arm-trusted-firmware-Y.Y.tar.gz

Show the sha256 checksum from the archive that contain the repository from the release with the tag version and show sha256 checksum from the same archive https://github.com/ARM-software/arm-trusted-firmware/archiv/vY.Y.tar.gz which belongs to the tag and compare the checksums:

    sha256sum arm-trusted-firmware-Y.Y.tar.gz

    curl -s -L https://github.com/ARM-software/arm-trusted-firmware/archiv/vY.Y.tar.gz | sha256sum

End of the optional section 4
   
    cd arm-trusted-firmware
    make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3328 DEBUG=1 bl31 ERRATA_A53_836870 ERRATA_A53_1530924

Software Developers Errata Notice: developer.arm.com/documentation/epm048406/2100/

Go into your Download folder and open Terminal, then run:

    git clone git://git.denx.de/u-boot.git

or Download U-Boot source tree from https://ftp.denx.de/pub/u-boot/ (How to verify downloaded file with .sig file: https://stackoverflow.com/questions/15331015/how-to-verify-downloaded-file-with-sig-file)

Search now the "bl31.elf" file in the arm-trusted-firmware build folder and copy it in the U-Boot folder.

Way 2 (use "bl31.elf" file from rockchip rkbin repository)
Go into your Download folder and open Terminal, then run:

    git clone git://git.denx.de/u-boot.git

or Download U-Boot source tree from ftp://ftp.denx.de/pub/u-boot/

Go back into your Download folder and open Terminal, then run:

    git clone https://github.com/rockchip-linux/rkbin
    cd rkbin

Search the file „rk322xh_bl31_vY.YY.elf“ in the rkbin folder and change the name of this file to „bl31.elf“ and copy it in the U-Boot folder.

Step 2: Compile U-Boot

Install the required packages (for latest Debian):  

    sudo apt-get install --no-install-suggests --no-install-recommends bison dh-python flex gcc-10 libexpat1-dev libmpdec3 make mime-support swig4.0 u-boot-tools cpp-10 libpython3.9-stdlib libpython3.9-dev libpython3.9-minimal libpython3.9 python3.9 python3.9-minimal python3-distutils python3-lib2to3 python3-pkg-resources python3-setuptools python-pip-whl python3-pip python3.9-dev device-tree-compiler build-essential git libssl-dev 


To cross-compile:

    sudo apt-get install --no-install-suggests --no-install-recommends cpp-10-aarch64-linux-gnu gcc-10-aarch64-linux-gnu gcc-10-aarch64-linux-gnu-base libasan6-arm64-cross libc6-arm64-cross libgcc-10-dev-arm64-cross libgcc-s1-arm64-cross libgomp1-arm64-cross libitm1-arm64-cross liblsan0-arm64-cross libstdc++6-arm64-cross libtsan0-arm64-cross libubsan1-arm64-cross cpp-aarch64-linux-gnu gcc-aarch64-linux-gnu gcc-10-cross-base libatomic1-arm64-cross swig

    cd u-boot

# For the ROC-RK3328-CC RENEGADE Board replace "rock64" with "roc-cc"

    make CROSS_COMPILE=aarch64-linux-gnu- BL31=bl31.elf rock64-rk3328_defconfig

    make CROSS_COMPILE=aarch64-linux-gnu- BL31=bl31.elf all

### Flash U-Boot to microSD card
Create a ext4 partition with e.g. gparted or fdisk which begins at 16 mb.

Create partition with fdisk:
(replace sda1 with the name of your microSD card  with number (you can find it with fdisk -l))
sudo umount /dev/sda1

(replace sda with the name of your microSD card but now in the following without number (you can find it with fdisk -l))

    sudo fdisk /dev/sda
    d
    o
    n
    Enter
    Enter
    Enter
First sector (2048-62333951, default 2048): 32768
    Enter
    w
    sudo mkfs.ext4 /dev/sda1 (with number!)

    sudo fdisk /dev/sda
    p (at Boot must be a "*"  if there is not a "*" then press "a" and then "w")
    w

End of fdisk instructions.
 
Now run this command: 

    sudo umount /dev/sda1 (replace sda1 with the name of your microSD (with number at the end))

Open Terminal in the U-Boot folder and flash U-Boot to microSD card with following commands (you can find the name of your microSD card with e.g. gparted, we search for example /dev/sda (without number! not /dev/sda1)):

    sudo dd if=./idbloader.img of=/dev/sda seek=64
    sudo dd if=./u-boot.itb of=/dev/sda seek=16384

Now copy the Alpine Linux files on the microSD card.
