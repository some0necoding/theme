#!/bin/bash
#
#		---------------- install.sh ----------------
#
#		This script installs settheme utility.
#

# TODO: check packages
# TODO: put units in /home/${USER}/.config/systemd/user/

# Check desktop environment
check_de() {

	[[ $XDG_CURRENT_DESKTOP != "KDE" || $DESKTOP_SESSION != "plasma" ]] && {
		echo "settheme works only on KDE plasma desktop"
		return 1
	}

	return 0
}

check_packages() {

}

# Copying commands in /usr/local/bin
install_cmds() {

	# TODO: use absolute paths
	# TODO: use variables
	cp ./bin/lighttheme /usr/local/bin/lighttheme || {
		echo cannot install binaries
		return 1
	}

	# TODO: use variables
	[[ -e /usr/local/bin/lighttheme ]] || {
		echo cannot install binaries
		return 1
	}

	# TODO: use absolute paths
	# TODO: use variables
	cp ./bin/darktheme /usr/local/bin/darktheme || {
		echo cannot install binaries
		return 1
	}

	# TODO: use variables
	[[ -e /usr/local/bin/darktheme ]] || {
		echo cannot install binaries
		return 1
	}

}

install_units() {

}
