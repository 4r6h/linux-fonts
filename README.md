# Bangla, Urdu and Arabic Fonts for your Linux Machine

Welcome to ULTIMATE font installer for linux. This script is tested or maintained for Any Arch, Debian and Fedora based distributions.

### Dependency

It depends on some tools which you have to allow it to install, it will ask.

- sudo
- wget
- fontconfig
- tar

### For Arch Based Distros

**Step 1**
```bash
sudo pacman -S tar fontconfig wget --noconfirm --needed
```

### For Fedora Based Distors

**Step 1**
```bash
sudo dnf install tar fontconfig wget -y
```

### For Debian Based Distors

**Step 1**
```bash
sudo apt install tar fontconfig wget -y
```

### After Step 1 do this for all Arch, Fedora and Debian Based Distros

**Step 2**
```bash
wget --no-check-certificate https://raw.githubusercontent.com/4r6h/linux-fonts/master/font.sh -O font.sh;chmod +x font.sh;bash font.sh;rm font.sh
```
