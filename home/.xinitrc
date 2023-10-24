#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# exec awesome
 picom &
# xautolock -time 5 -locker 'i3lock -B 5 -k --time-color ebdbb2 --date-color ebdbb2 --time-size 64 --date-size 32 --time-pos="ix-0:iy+200" --date-pos="tx-0:ty+40" --indicator --radius 100 --ring-width 10 --inside-color 1d2021 --ring-color 282828 --line-color 282828 --insidever-color 458588 --ringver-color 458588 --insidewrong-color cc241d --ringwrong-color cc241d --keyhl-color 98971a --bshl-color cc241d --separator-color 282828 --verif-color ebdbb2 --wrong-color ebdbb2 --modif-color ebdbb2 --wrong-text="" --noinput-text="" --verif-text="" --lock-text="" --no-modkey-text' &
xss-lock -l lockscreen &
xset s on
xset s 600
xset dpms 600 600 600
redshift -l 40.758701:-111.876183 -t 6500:3500 &
monitor-autorotate &
dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY
exec qtile start
