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

# Copying commands in /usr/local/bin/
install_cmds() {

	if ! command -v $LIGHTTHEME_DST; then
	
		cp $LIGHTTHEME_SRC $LIGHTTHEME_DST || {
			echo cannot install binaries
			return 1
		}

		[[ -e $LIGHTTHEME_DST ]] || {
			echo cannot install binaries
			return 1
		}
	fi

	# TODO: if a lighttheme command already exists 
	#		ask the user if they want to overwrite it

	if ! command -v $DARKTHEME_DST; then
	
		cp $DARKTHEME_SRC $DARKTHEME_DST || {
			echo cannot install binaries
			return 1
		}

		[[ -e $DARKTHEME_DST ]] || {
			echo cannot install binaries
			return 1
		}
	fi
	
	# TODO: if a lighttheme command already exists 
	#		ask the user if they want to overwrite it

	return 0
}

# Copying units in /home/${USER}/.config/systemd/user/
install_units() {

	for unit in $UNITS_SRC; do

		unit_dst="$SYSTEMD_DIR/$(basename $unit)"

		if [[ ! -e $unit_dst ]]; then
			
			cp $unit $unit_dst || {
				echo cannot install $(basename $unit) unit
				continue
			}

		fi

	# TODO: use variables
	cp "./units/*" $SYSTEMD_DIR || {
		echo cannot install systemd units
		return 1
	}

	# TODO: if units with same name are already installed
	#		ask the user if they want to overwrite them.

	# TODO: check for good installation

	return 0
}
