#!/bin/bash

set -e

ROOTDIR=~/.dotfiles

function install_apt_dependencies {
    # see for more details about polybar dependencies: https://github.com/jaagr/polybar/wiki/Compiling
    echo "Installing basic dependencies with apt..."
    sudo add-apt-repository -y ppa:kgilmer/speed-ricer && \
    sudo apt update && \
        sudo apt install -y curl git emacs vim rxvt-unicode stow net-tools ranger feh cmake libasound2-dev libpulse-dev libcurl4-openssl-dev libmpdclient-dev libiw-dev xcb-proto python3-xcbgen libpam0g-dev libjpeg-turbo8-dev compton htop fonts-font-awesome fonts-inconsolata openvpn scrot pwgen libxcb-randr0-dev libxcb-xtest0-dev libxcb-xinerama0-dev libxcb-shape0-dev libxcb-xkb-dev libxcb-composite0 libxcb-composite0-dev libxcb-ewmh-dev clang libjsoncpp-dev i3-gaps-wm
}

function install_cht_sh {
    echo "Installing cht.sh command line client..."

    curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh > /dev/null
    sudo chmod +x /usr/local/bin/cht.sh
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

    wget https://github.com/jaagr/polybar/releases/download/3.5.4/polybar-3.5.4.tar.gz && tar -xzvf polybar-3.5.4.tar.gz
    cd polybar-3.5.4 && ./build.sh --all-features -f -A

    cd $ROOTDIR
}

function install_spacemacs {
    sudo rm -rf ~/.emacs.d
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
}

function install_lockscreen {
    mkdir -p ~/.local/bin
    stow -vt ~/.local/bin betterlockscreen

    # update cache
    ~/.local/bin/betterlockscreen -u ~/.dotfiles/images/wallpaper.jpg
}

function install_docker {
    # install needed packages
    sudo apt-get update && \
        sudo apt-get install \
             apt-transport-https \
             ca-certificates \
             curl \
             gnupg-agent \
             software-properties-common

    # add the docker key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # add the docker repository
    sudo add-apt-repository \
         "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
         $(lsb_release -cs) \
         stable" && \
        sudo apt-get update

    # install docker
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

    # add current user to the docker group
    sudo usermod -aG docker $USER

    # install docker-compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&
        sudo chmod +x /usr/local/bin/docker-compose
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
    install_cht_sh
    install_polybar
    install_spacemacs
    install_i3_lock
    install_lockscreen
    install_docker
    stow_config
    clear_font_cache
}

# There we go!
main
