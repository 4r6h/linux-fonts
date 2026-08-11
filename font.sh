#!/bin/bash

###############################################################################
# ULTIMATE Linux Font Installer
#
# Author: 4r6h/Rahat
#
# Supported:
#   - Arch Linux / Manjaro / EndeavourOS
#   - Debian / Ubuntu / Linux Mint / Pop!_OS
#   - Fedora / RHEL / Rocky / AlmaLinux / CentOS
#   - openSUSE
#   - Alpine Linux
#
# Downloads fonts directly from GitHub.
# No .tar.gz archive is required.
###############################################################################

# =============================================================================
# Colors
# =============================================================================

Off='\033[0m'

Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
White='\033[0;37m'

BBlack='\033[1;30m'
BRed='\033[1;31m'
BGreen='\033[1;32m'
BYellow='\033[1;33m'
BBlue='\033[1;34m'
BPurple='\033[1;35m'
BCyan='\033[1;36m'
BWhite='\033[1;37m'


# =============================================================================
# Configuration
# =============================================================================

REPO="https://github.com/4r6h/linux-fonts/trunk"

FONT_DIRS=(
    "Arabic-Fonts"
    "Bangla-Fonts"
    "Urdu-Fonts"
    "Urdu-Arabic-Fonts"
)

# User font installation directory
FONTS_DIR="$HOME/.local/share/fonts/Linux-Fonts"


# =============================================================================
# Welcome
# =============================================================================

clear

echo -e "${BBlue}"
echo "*******************************************************"
echo "*                                                     *"
echo "*     ULTIMATE Linux Font Installer - 4r6h/Rahat      *"
echo "*                                                     *"
echo "*******************************************************"
echo -e "${Off}"

echo -e "${BBlue}Welcome to Linux Font Installer from 4r6h/Rahat !!!${Off}"
echo -e "------------------------------------"


# =============================================================================
# Check Linux
# =============================================================================

if [ "$(uname -s)" != "Linux" ]; then
    echo -e "${BRed}This script is designed for Linux only.${Off}"
    exit 1
fi


# =============================================================================
# Detect Distribution
# =============================================================================

echo -e "\n${BYellow}Detecting Linux distribution...${Off}\n"

if [ ! -f /etc/os-release ]; then
    echo -e "${BRed}Unable to detect Linux distribution.${Off}"
    exit 1
fi

# shellcheck disable=SC1091
source /etc/os-release

DISTRO_ID="${ID,,}"
DISTRO_LIKE="${ID_LIKE,,}"


# =============================================================================
# Detect Package Manager
# =============================================================================

PACKAGE_MANAGER=""

if command -v pacman >/dev/null 2>&1; then

    PACKAGE_MANAGER="pacman"

elif command -v apt-get >/dev/null 2>&1; then

    PACKAGE_MANAGER="apt"

elif command -v dnf >/dev/null 2>&1; then

    PACKAGE_MANAGER="dnf"

elif command -v yum >/dev/null 2>&1; then

    PACKAGE_MANAGER="yum"

elif command -v zypper >/dev/null 2>&1; then

    PACKAGE_MANAGER="zypper"

elif command -v apk >/dev/null 2>&1; then

    PACKAGE_MANAGER="apk"

fi


# =============================================================================
# Identify Distribution Family
# =============================================================================

case "$DISTRO_ID" in

    arch|manjaro|endeavouros|garuda)
        DISTRO_FAMILY="arch"
        ;;

    debian|ubuntu|linuxmint|pop|elementary|zorin|kali|mx)
        DISTRO_FAMILY="debian"
        ;;

    fedora|rhel|rocky|almalinux|centos|ol)
        DISTRO_FAMILY="fedora"
        ;;

    opensuse*|sles)
        DISTRO_FAMILY="suse"
        ;;

    alpine)
        DISTRO_FAMILY="alpine"
        ;;

    *)
        # Try ID_LIKE when ID isn't directly recognized

        case "$DISTRO_LIKE" in

            *arch*)
                DISTRO_FAMILY="arch"
                ;;

            *debian*|*ubuntu*)
                DISTRO_FAMILY="debian"
                ;;

            *fedora*|*rhel*)
                DISTRO_FAMILY="fedora"
                ;;

            *suse*)
                DISTRO_FAMILY="suse"
                ;;

            *)
                DISTRO_FAMILY="unknown"
                ;;

        esac
        ;;

esac


# =============================================================================
# Show Detection Result
# =============================================================================

echo -e "${BGreen}Distribution detected:${Off} ${BWhite}${PRETTY_NAME}${Off}"
echo -e "${BGreen}Distribution ID:${Off} ${BWhite}${DISTRO_ID}${Off}"
echo -e "${BGreen}Distribution family:${Off} ${BWhite}${DISTRO_FAMILY}${Off}"
echo -e "${BGreen}Package manager:${Off} ${BWhite}${PACKAGE_MANAGER:-Unknown}${Off}"

echo -e "------------------------------------"


# =============================================================================
# Determine sudo
# =============================================================================

if [ "$(id -u)" -eq 0 ]; then
    SUDO=""
else
    if command -v sudo >/dev/null 2>&1; then
        SUDO="sudo"
    else
        SUDO=""
    fi
fi


# =============================================================================
# Package Installation Function
# =============================================================================

install_dependencies() {

    echo -e "\n${BYellow}Installing required packages...${Off}\n"

    case "$PACKAGE_MANAGER" in

        pacman)

            echo -e "${BBlue}Using Pacman...${Off}"

            $SUDO pacman -Sy --needed subversion fontconfig --noconfirm

            ;;

        apt)

            echo -e "${BBlue}Using APT...${Off}"

            $SUDO apt-get update
            $SUDO apt-get install -y subversion fontconfig

            ;;

        dnf)

            echo -e "${BBlue}Using DNF...${Off}"

            $SUDO dnf install -y subversion fontconfig

            ;;

        yum)

            echo -e "${BBlue}Using YUM...${Off}"

            $SUDO yum install -y subversion fontconfig

            ;;

        zypper)

            echo -e "${BBlue}Using Zypper...${Off}"

            $SUDO zypper --non-interactive install subversion fontconfig

            ;;

        apk)

            echo -e "${BBlue}Using APK...${Off}"

            $SUDO apk add subversion fontconfig

            ;;

        *)

            echo -e "${BRed}"
            echo "Unable to determine a supported package manager."
            echo -e "${Off}"

            echo -e "${BYellow}Please manually install:${Off}"
            echo "  - subversion"
            echo "  - fontconfig"
            echo

            exit 1
            ;;

    esac


    if [ $? -ne 0 ]; then

        echo -e "\n${BRed}Failed to install required packages.${Off}"
        exit 1

    fi

}


# =============================================================================
# Check Dependencies
# =============================================================================

echo -e "\n${BYellow}Checking required tools...${Off}\n"

MISSING=0


if ! command -v svn >/dev/null 2>&1; then
    echo -e "${BRed}✗ subversion is missing.${Off}"
    MISSING=1
else
    echo -e "${BGreen}✓ subversion found.${Off}"
fi


if ! command -v fc-cache >/dev/null 2>&1; then
    echo -e "${BRed}✗ fontconfig is missing.${Off}"
    MISSING=1
else
    echo -e "${BGreen}✓ fontconfig found.${Off}"
fi


# =============================================================================
# Install Missing Dependencies
# =============================================================================

if [ "$MISSING" -eq 1 ]; then

    if [ -z "$SUDO" ] && [ "$(id -u)" -ne 0 ]; then

        echo -e "\n${BRed}Root privileges are required to install missing packages.${Off}"
        echo -e "${BYellow}Please install sudo or run this script as root.${Off}"
        exit 1

    fi

    echo

    read -p "$(echo -e "${BYellow}Install missing dependencies automatically? (y/n): ${Off}")" choice

    case "$choice" in

        y|Y)
            install_dependencies
            ;;

        n|N)
            echo -e "\n${BRed}Installation cancelled.${Off}"
            exit 1
            ;;

        *)
            echo -e "\n${BRed}Invalid option.${Off}"
            exit 1
            ;;

    esac

fi


# =============================================================================
# Verify Dependencies Again
# =============================================================================

if ! command -v svn >/dev/null 2>&1; then

    echo -e "${BRed}subversion is still unavailable.${Off}"
    exit 1

fi


if ! command -v fc-cache >/dev/null 2>&1; then

    echo -e "${BRed}fontconfig is still unavailable.${Off}"
    exit 1

fi


# =============================================================================
# Prepare Font Directory
# =============================================================================

echo -e "\n${BYellow}Preparing font directory...${Off}\n"

echo -e "${BWhite}Installation path:${Off}"
echo -e "${BCyan}$FONTS_DIR${Off}\n"


mkdir -p "$FONTS_DIR"


if [ $? -ne 0 ]; then

    echo -e "${BRed}Unable to create font directory.${Off}"
    exit 1

fi


# =============================================================================
# Download Font Directories
# =============================================================================

echo -e "${BGreen}Downloading fonts directly from GitHub...${Off}"
echo -e "${BWhite}Archive download is disabled.${Off}"
echo -e "${BWhite}Only selected directories will be downloaded.${Off}"
echo -e "------------------------------------\n"


SUCCESS_COUNT=0
FAILED_COUNT=0


for FONT_NAME in "${FONT_DIRS[@]}"; do

    SOURCE="$REPO/$FONT_NAME"
    TARGET="$FONTS_DIR/$FONT_NAME"


    echo -e "${BYellow}Downloading:${Off} ${BWhite}$FONT_NAME${Off}"


    # Remove previous version
    if [ -d "$TARGET" ]; then
        rm -rf "$TARGET"
    fi


    # Direct GitHub directory export
    svn export \
        "$SOURCE" \
        "$TARGET" \
        --force \
        --quiet


    if [ $? -eq 0 ]; then

        echo -e "${BGreen}✓ $FONT_NAME downloaded successfully.${Off}\n"

        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))

    else

        echo -e "${BRed}✗ Failed to download $FONT_NAME.${Off}\n"

        rm -rf "$TARGET"

        FAILED_COUNT=$((FAILED_COUNT + 1))

    fi

done


# =============================================================================
# Check Downloaded Fonts
# =============================================================================

echo -e "------------------------------------"
echo -e "${BYellow}Checking downloaded font files...${Off}\n"


FONT_COUNT=$(find "$FONTS_DIR" \
    -type f \
    \( \
        -iname "*.ttf" \
        -o -iname "*.otf" \
        -o -iname "*.ttc" \
        -o -iname "*.woff" \
        -o -iname "*.woff2" \
    \) \
    2>/dev/null | wc -l)


if [ "$FONT_COUNT" -eq 0 ]; then

    echo -e "${BRed}No font files were found.${Off}"
    echo -e "${BRed}Installation failed.${Off}"
    exit 1

fi


echo -e "${BGreen}✓ Found $FONT_COUNT font files.${Off}"


# =============================================================================
# Refresh Font Cache
# =============================================================================

echo -e "\n${BYellow}Refreshing font cache...${Off}\n"


fc-cache -f "$FONTS_DIR"


if [ $? -eq 0 ]; then

    echo -e "${BGreen}✓ Font cache refreshed successfully.${Off}"

else

    echo -e "${BRed}✗ Failed to refresh font cache.${Off}"
    exit 1

fi


# =============================================================================
# Final Result
# =============================================================================

echo -e "\n------------------------------------"

echo -e "${BGreen}"
echo "Download and Installation Complete !!!"
echo -e "${Off}"

echo -e "${BWhite}Distribution:${Off} ${BCyan}${PRETTY_NAME}${Off}"
echo -e "${BWhite}Font directory:${Off} ${BCyan}$FONTS_DIR${Off}"
echo -e "${BWhite}Font files:${Off} ${BCyan}$FONT_COUNT${Off}"
echo -e "${BWhite}Directories downloaded:${Off} ${BCyan}$SUCCESS_COUNT${Off}"
echo -e "${BWhite}Directories failed:${Off} ${BCyan}$FAILED_COUNT${Off}"


if [ "$FAILED_COUNT" -eq 0 ]; then

    echo -e "\n${BGreen}All font directories were installed successfully.${Off}"

else

    echo -e "\n${BYellow}Some font directories could not be downloaded.${Off}"

fi


echo -e "\n------------------------------------"

echo -e "${BBlue}This Script was Created by 4r6h/Rahat${Off}"
echo -e "${BGreen}Follow me on GitHub: github.com/4r6h${Off}\n"

echo -e "${Off}"

exit 0
