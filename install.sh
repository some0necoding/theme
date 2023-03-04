#!/bin/bash
#
#		---------------- install.sh ----------------
#
#		This script installs settheme utility.
#

# TODO: put units in /home/${USER}/.config/systemd/user/

packages=( "bash" "systemd" "sed" "grep" "plasma-workspace" "coreutils" )

LIGHTTHEME_BIN="/usr/local/bin/lighttheme"
DARKTHEME_BIN="/usr/local/bin/darktheme"

# Check desktop environment.
check_de() {

	[[ $XDG_CURRENT_DESKTOP != "KDE" || $DESKTOP_SESSION != "plasma" ]] && {
		echo "settheme works only on KDE plasma desktop"
		return 1
	}

	return 0
}

# Check if packages are installed.
check_packages() {

	for package in packages; do
		if ! command -v $package; then
			echo $package is not installed
			return 1
		fi
	done

	return 0
}

# Copying commands in /usr/local/bin
install_cmds() {

	if ! command -v $LIGHTTHEME_BIN; then
	
		# TODO: use absolute paths
		# TODO: use variables
		cp ./bin/lighttheme $LIGHTTHEME_BIN || {
			echo cannot install binaries
			return 1
		}

		[[ -e $LIGHTTHEME_BIN ]] || {
			echo cannot install binaries
			return 1
		}
	fi

	if ! command -v $DARKTHEME_BIN; then
	
		# TODO: use absolute paths
		# TODO: use variables
		cp ./bin/darktheme $DARKTHEME_BIN || {
			echo cannot install binaries
			return 1
		}

		[[ -e $DARKTHEME_BIN ]] || {
			echo cannot install binaries
			return 1
		}
	fi

	return 0
}

install_units() {

}
