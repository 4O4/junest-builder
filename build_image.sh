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
makepkg --noconfirm -si

sudo systemctl start haveged

# Building JuNest image
cd ${JUNEST_BUILDER}
JUNEST_TEMPDIR=${JUNEST_BUILDER}/tmp bash -x /opt/junest/bin/junest -b -n zsh glibc gcc ranger exa vim neovim python3 aur:aurman fasd aur:nnn thefuck tree fd progress ripgrep gawk aur:hstr mercurial cmake premake shellcheck diff-so-fancy tldr unp tmux grep unzip rsync zssh mc rclone glances nload netdata the_silver_searcher httpie speedtest-cli aur:urlview uriparser jq aur:gqlplus aur:pacvim-git fortune-mod cowsay lolcat ponysay go rust nodejs php composer typescript lua51 luajit clang gdb aur:python-gdbgui gtop

sudo rm -rf ${JUNEST_BUILDER}
