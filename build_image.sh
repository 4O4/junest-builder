#!/bin/bash

# ARCH can be one of: x86, x86_64, arm
# The optional ARCH is only used to identify the oldest images
# that need to be deleted in dropbox
ARCH=""
[ "$1" != "" ] && ARCH=$1

set -eu

JUNEST_BUILDER=/home/builder/junest-builder

# Cleanup and initialization
[ -e "${JUNEST_BUILDER}" ] && sudo rm -rf ${JUNEST_BUILDER}
mkdir -p ${JUNEST_BUILDER}/tmp

# ArchLinux System initialization
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git
git clone https://github.com/4O4/junest-aur-pkg.git /tmp/junest-git
cd /tmp/junest-git
makepkg -si

sudo systemctl start haveged

# Building JuNest image
cd ${JUNEST_BUILDER}
JUNEST_TEMPDIR=${JUNEST_BUILDER}/tmp /opt/junest/bin/junest -b

sudo rm -rf ${JUNEST_BUILDER}
