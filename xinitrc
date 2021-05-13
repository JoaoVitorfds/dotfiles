#!/bin/sh

# xinitrc runs automatically when you run startx.

# There are some small but important commands that need to be run when we start
# the graphical environment. I keep those commands in ~/config/xprofile because
# that file is run automatically if someone uses a display manager (login
# screen) and so they are needed there. To prevent doubling up commands, I
# source them here with the line below.

# export STATUSBAR="i3blocks" # Uncomment this line when using i3.
# setxkbmap -layout br -variant thinkpad &
. ~/.xprofile

# Your default LARBS WM is determined in your `~/.profile` on login.  Here we
# run the proper command to run when the graphical environment starts.

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_LOCK
export _JAVA_AWT_WM_NONREPARENTING=1

# Comment/uncomment these lines depending on what wm you want to use. Also
# check the i3blocks line above.
ssh-agent dwm
# ssh-agent i3
#xrdb -merge .Xresources &

#while true; do
#    # Log stderror to a file 
#    dwm 2> ~/.dwm.log
#    # No error logging
#    #dwm >/dev/null 2>&1
#done

exec dwm &
