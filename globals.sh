#!/bin/bash
#
#		---------------- globals.sh ----------------
#
#		This script contains functions and variables
#		needed by more scripts file.
#


# TODO: make this variables editable by user.
LIGHT_THEME="org.kde.breeze.desktop"
DARK_THEME="org.kde.breezedark.desktop"

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


#
#	Set theme activation time.
#
#	SYNTAX:		set_time PATH_TO_TIMER TIME
#
set_time() {

	# Argument check.
	[[ -z $1 || -z $2 ]] && { echo "missing arguments"; return 1; }

	# Check if file ($1) is either $DARKTHEME_TIMER or $LIGHTTHEME_TIMER.
	[[ $1 == $DARKTHEME_TIMER || $1 == $LIGHTTHEME_TIMER ]] || { 
		echo "Theme activation time can be retrieved only by either $LIGHTTHEME_TIMER or $DARKTHEME_TIMER"; 
		return 1;
	}
	
	# Check if file ($1) exists. If not settheme is not installed.
	[[ -e $1 ]] || { echo "$1 doesn't exist. You might have to run install.sh."; return 1; }

	# Check good date format.
	[[ $2 =~ ^[0-9]{2}:[0-9]{2}:[0-9]{2}$ ]] || { echo "$2 is not a valid date format. Use instead HH:MM:SS"; return 1; }

	# Check if date is valid.
	[[ $2 =~ ^([01][0-9]|[2][0-3]):[0-5][0-9]:[0-5][0-9]$ ]] || { echo "Date not valid. It can range from 00:00:00 to 23:59:59"; return 1; }

	# Replace time in .timer file.
	sed -Ei "s/^OnCalendar=\*-\*-\* ([01][0-9]|[2][0-3]):[0-5][0-9]:[0-5][0-9]\$/OnCalendar=*-*-* $2/" $1 || { echo Cannot change light theme activation time; return 1; }

	# Get current theme activation time.
	local current_time=$(sed -nE '/^OnCalendar=\*-\*-\* ([01][0-9]|[2][0-3]):[0-5][0-9]:[0-5][0-9]$/p' $1 | grep -oE "[0-9]{2}:[0-9]{2}:[0-9]{2}")

	# If activation time has not changed, throw an error.
	[[ $current_time != $2 ]] && { echo Cannot change light theme activation time; return 1; }

	return 0
}

