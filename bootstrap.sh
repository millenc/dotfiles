#!/bin/bash

ROOTDIR=~/.dotfiles

function install_apt_dependencies {
    # see for more details about polybar dependencies: https://github.com/jaagr/polybar/wiki/Compiling
    echo "Installing basic dependencies with apt..."
    sudo apt update && \
        sudo apt install -y curl git emacs25 vim mercurial rxvt-unicode stow net-tools ranger feh cmake libasound2-dev libpulse-dev libcurl4-openssl-dev libmpdclient-dev libiw-dev xcb-proto python-xcbgen libpam0g-dev libjpeg-turbo8-dev compton htop fonts-font-awesome fonts-inconsolata openvpn
}

function install_cht_sh {
    echo "Installing cht.sh command line client..."

    curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh > /dev/null
    sudo chmod +x /usr/local/bin/cht.sh
}

function install_i3_gaps {
    echo "Installing i3-gaps window manager from source..."

    # Source: https://gist.github.com/dabroder/813a941218bdb164fb4c178d464d5c23
    sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-*-dev i3status suckless-tools rofi

    cd /tmp

    # clone the repository
    git clone https://www.github.com/Airblader/i3 i3-gaps
    cd i3-gaps

    # pin the lastest release version
    git checkout 4.16.1

    # compile & install
    autoreconf --force --install
    rm -rf build/
    mkdir -p build && cd build/

    # Disabling sanitizers is important for release versions!
    # The prefix and sysconfdir are, obviously, dependent on the distribution.
    ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
    make
    sudo make install

    cd $ROOTDIR
}

function install_i3_lock {
    echo "Installing i3lock from source..."

    cd /tmp

    wget https://github.com/PandorasFox/i3lock-color/archive/2.12.c.tar.gz && tar -xvzf ./2.12.c.tar.gz
    cd i3lock-color-2.12.c

    autoreconf --force --install

    rm -rf build/
    mkdir -p build && cd build/

    ../configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --disable-sanitizers

    make
    sudo make install

    cd $ROOTDIR
}

function install_polybar {
    echo "Installing polybar..."

    cd /tmp

    wget https://github.com/jaagr/polybar/releases/download/3.3.1/polybar-3.3.1.tar && tar -xvf polybar-3.3.1.tar
    cd polybar && ./build.sh --all-features -f -A

    cd $ROOTDIR
}

function install_spacemacs {
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
}

function install_lockscreen {
    mkdir -p ~/.local/bin
    stow -vt ~/.local/bin betterlockscreen

    # update cache
    ~/.local/bin/betterlockscreen -u ~/.dotfiles/images/wallpaper.jpg
}

function stow_config {
    # Ensure needed folder exist
    mkdir -p ~/.fonts

    # remove existig config files before symlinking
    rm -f ~/.bashrc || true
    rm -f ~/.profile || true
    rm -Rf ~/.config/i3 || true
    rm -Rf ~/.config/polybar || true

    # symlink configuration using stow
    stow -vt ~/ bash git xserver i3 emacs polybar
    stow -vt ~/.fonts fonts
}

function clear_font_cache {
    # Make sure Source Code Pro (https://github.com/adobe-fonts/source-code-pro/releases) is available
    fc-cache -f -v
}

function main {
    echo "Bootstraping your system configuration!"

    cd $ROOTDIR

    install_apt_dependencies
    # install_cht_sh
    # install_i3_gaps
    # install_polybar
    # install_spacemacs
    # install_i3_lock
    # install_lockscreen
    stow_config
    # clear_font_cache
}

# There we go!
main
