#!/bin/bash

function install_apt_dependencies {
    echo "Installing basic dependencies with apt..."
    sudo apt update && \
        sudo apt install -y git emacs25 vim mercurial stow
}

function stow_config {
	# remove existig files first
	rm -f ~/.bashrc || true
	rm -f ~/.profile || true

	stow -vt ~/ bash git
}

function main {
	echo "Bootstraping your system configuration!"

	install_apt_dependencies
	stow_config
}

# There we go!
main
