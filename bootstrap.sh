#!/bin/bash

function install_apt_dependencies {
	echo "Installing basic dependencies with apt..."
	sudo apt update && \
		sudo apt install -y curl git emacs25 vim mercurial stow
}

function install_cht_sh {
	echo "Installing cht.sh command line client..."

	curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh > /dev/null
    	sudo chmod +x /usr/local/bin/cht.sh	
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
	install_cht_sh
	stow_config
}

# There we go!
main
