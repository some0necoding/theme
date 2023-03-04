#!/bin/bash
#
#		---------------- install.sh ----------------
#
#		This script installs settheme utility.
#


packages=( "bash" "systemd" "sed" "grep" "plasma-workspace" "coreutils" )

LIGHTTHEME_DST="/usr/local/bin/lighttheme"
DARKTHEME_DST="/usr/local/bin/darktheme"

LIGHTTHEME_SRC="./bin/lighttheme"
DARKTHEME_SRC="./bin/darktheme"

SYSTEMD_DIR="/home/${USER}/.config/systemd/user"

D_TIMER_SRC="./bin/darktheme.timer"
L_TIMER_SRC="./bin/lighttheme.timer"
D_SERVICE_SRC="./bin/darktheme.service"
L_SERVICE_SRC="./bin/lighttheme.service"

UNITS_SRC=( $D_TIMER_SRC $L_TIMER_SRC $D_SERVICE_SRC $L_SERVICE_SRC )

# Check desktop environment.
function check_de() {

	[[ $XDG_CURRENT_DESKTOP != "KDE" || $DESKTOP_SESSION != "plasma" ]] && {
		echo "settheme works only on KDE plasma desktop"
		return 1
	}

	return 0
}

# Check if packages are installed.
function check_packages() {

	for package in packages; do
		if ! command -v $package; then
			echo $package is not installed
			return 1
		fi
	done

	return 0
}

# Copy SOURCE to DESTINATION checking for success.
#
#	SYNTAX:		copy SOURCE DESTINATION
#
function copy() {
			
	cp $1 $2 || {
		return 1
	}

	[[ ! -e $2 ]] && {
		return 1
	}

	return 0
}

# Copy SOURCE to DESTINATION handling exceptions.
#
#	SYNTAX:		install SOURCE DESTINATION
#
function install() {

	if [[ ! -e $2 ]]; then

		copy $1 $2 || {
			echo cannot install $2
			return 1
		}

	else 

		echo $2 already exist
		echo -n "do you want to overwrite this file? [y/N]: "

		read input

		if [[ $input == "y" || $input == "Y" ]]; then

			copy $1 $2 || {
				echo cannot install $2
				return 1
			}

		fi
	fi

	return 0
}

# Copying units in /home/${USER}/.config/systemd/user/
function install_units() {

	for unit in $UNITS_SRC; do

		unit_dst="$SYSTEMD_DIR/$(basename $unit)"

		install $unit $unit_dst || {
			continue
		}

	done

	return 0
}


check_de || exit 1

check_packages || exit 1

install $LIGHTTHEME_SRC $LIGHTTHEME_DST || exit 1
install $DARKTHEME_SRC  $DARKTHEME_DST || exit 1

install_units
