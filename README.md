# Bangla, Urdu and Arabic Fonts for your Linux Machine

Welcome to Bangla font installer for linux. This script is tested or maintained for Arch base distributions like Arch Linux, Manjaro Linux, Arco Linux, Garuda Linux, Endeavour OS etc. And also for Debian based distributions like Debian, Ubuntu, Linux Mint, Deepin etc.


### Dependency

It depends on some tools which you have to allow it to install, it will ask.

- sudo
- wget
- fontconfig
- tar

## Install:
### pypi version
Make sure you pip3 installed

```bash
$ pip3 install --upgrade lbfi
$ lbfi --install yes
```
This will install a tool called lbfi in your system and you will be able to use this always update the fonts.

PyPi link: https://pypi.org/project/lbfi/

### For Bangla Fonts Only
```bash
wget --no-check-certificate https://raw.githubusercontent.com/4r6h/linux-fonts/master/dist/lbfi -O lbfi;chmod +x lbfi;./lbfi
```

### For Arch Based All Fonts

**Step 1**
```bash
sudo pacman -S tar fontconfig wget --noconfirm --needed
```
**Step 2**
```bash
wget --no-check-certificate https://raw.githubusercontent.com/4r6h/linux-fonts/master/Arch-font.sh -O Arch-font.sh;chmod +x Arch-font.sh;bash Arch-font.sh;rm Arch-font.sh
```


### For Debian Based All Fonts

**Step 1**
```bash
sudo apt install tar fontconfig wget -y
```
**Step 2**
```bash
wget --no-check-certificate https://raw.githubusercontent.com/4r6h/linux-fonts/master/Debian-font.sh -O Debian-font.sh;chmod +x Debian-font.sh;bash Debian-font.sh;rm Debian-font.sh
```


### For Fedora Based All Fonts

**Step 1**
```bash
sudo dnf install tar fontconfig wget -y
```
**Step 2**
```bash
wget --no-check-certificate https://raw.githubusercontent.com/4r6h/linux-fonts/master/Fedora-font.sh -O Fedora-font.sh;chmod +x Fedora-font.sh;bash Fedora-font.sh;rm Fedora-font.sh
```
