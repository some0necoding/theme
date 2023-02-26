#!/bin/bash
#
#		---------------- globals.sh ----------------
#
#		This script contains functions and variables
#		needed by more scripts file.
#


DARKTHEME_TIMER="/home/${USER}/.config/systemd/user/darktheme.timer"
LIGHTTHEME_TIMER="/home/${USER}/.config/systemd/user/lighttheme.timer"


#
#	Get theme activation time.
#
#	SYNTAX:		get_time PATH_TO_TIMER
#
get_time() {

	# Argument check
	[[ -z $1 ]] && { echo "missing arguments"; return 1; }

	# Check if file ($1) is either $DARKTHEME_TIMER or $LIGHTTHEME_TIMER.
	[[ $1 == $DARKTHEME_TIMER || $1 == $LIGHTTHEME_TIMER ]] || { 
		echo "theme activation time can be retrieved only by either $LIGHTTHEME_TIMER or $DARKTHEME_TIMER"; 
		return 1;
	}

	# Check if file ($1) exists. If not settheme is not installed.
	[[ -e $1 ]] || { echo "$1 doesn't exist. You might have to run install.sh."; return 1; }

	# Dark theme activation time
	local d_time=$(sed -n '/OnCalendar/p' $1 | \
			 grep -oE "([01][0-9]|[2][0-3]):[0-5][0-9]:[0-5][0-9]")

	echo $d_time
	return 0
}
