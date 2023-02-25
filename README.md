utility to handle light/dark theme changes in KDE.

check:
 - $XDG_CURRENT_DESKTOP == KDE
 - $DESKTOP_SESSION == plasma

needed packages:
 - bash >= 5.1.16
 - systemd
 - sed
 - grep
 - plasma-workspace
 - coreutils
