#!/bin/bash

set -e

ROOTDIR=~/.dotfiles

function install_apt_dependencies {
    # see for more details about polybar dependencies: https://github.com/jaagr/polybar/wiki/Compiling
    echo "Installing basic dependencies with apt..."
    sudo add-apt-repository -y ppa:kgilmer/speed-ricer && \
    sudo add-apt-repository -y ppa:deadsnakes/ppa && \
    sudo apt update && \
    sudo apt install -y curl git emacs vim rxvt-unicode stow net-tools ranger feh cmake libasound2-dev libpulse-dev libcurl4-openssl-dev libmpdclient-dev libiw-dev xcb-proto python3-xcbgen libpam0g-dev libjpeg-turbo8-dev compton htop fonts-font-awesome fonts-inconsolata openvpn scrot pwgen libxcb-randr0-dev libxcb-xtest0-dev libxcb-xinerama0-dev libxcb-shape0-dev libxcb-xkb-dev libxcb-composite0 libxcb-composite0-dev libxcb-ewmh-dev clang libjsoncpp-dev i3-gaps xautolock blueman npm python3-pip python3.7 keepass2 fzf

    # install other software (vmd to preview markdown in emacs)
    sudo npm install -g vmd
}

function install_cht_sh {
    echo "Installing cht.sh command line client..."

    curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh > /dev/null
    sudo chmod +x /usr/local/bin/cht.sh
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
    rm -Rf ~/.config/nvim || true

    # symlink configuration using stow
    stow -vt ~/ bash git xserver i3 emacs nvim polybar
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
    install_docker
    stow_config
    clear_font_cache
}

# There we go!
main
