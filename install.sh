#!/bin/bash
#
#		---------------- install.sh ----------------
#
#		This script installs settheme utility.
#

# TODO: check packages
# TODO: put units in /home/${USER}/.config/systemd/user/
# TODO: put commands in /usr/local/bin

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

install_cmds() {

}

install_units() {

}
