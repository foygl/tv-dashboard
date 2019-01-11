#!/bin/sh

# Setup:
#   - Run bootstrap.sh
#   - Add URLs to cycle through to urls.txt. Ideally these should not require logins, but if necessary you can modify below to send key presses.

# Config:

RESOLUTION_X=`xdpyinfo | grep dimensions | awk '{ print $2 }' | sed 's/x.*//'`
RESOLUTION_Y=`xdpyinfo | grep dimensions | awk '{ print $2 }' | sed 's/.*x//'`

TAB_SWITCH_INTERVAL=30

########

SOURCE_DIR=$( dirname $( readlink -f "$0" ) )

# Disable DMPS (Display Power Management Signaling) and prevent screen from blanking
xset s off -dpms

# Keep mouse hidden and out of the way
xdotool mousemove 0 0
unclutter -idle 0 &

# TODO Remove this when --disable-session-crashed-bubble works
sed -i 's/\("exited_cleanly": *\)false/\1true/; s/\("exit_type": *\)"Crashed"/\1"None"/' ~/.config/chromium/Default/Preferences

chromium-browser --window-size=${RESOLUTION_X},${RESOLUTION_Y} --window-position=0,0 --start-maximized \
    --fast --fast-start \
    --no-first-run \
    --noerrdialogs \
    --disable-infobars \
    --disable-session-crashed-bubble \
    --disable-suggestions-service \
    --kiosk \
    $( grep -v '^#' $SOURCE_DIR/urls.txt | tr '\n' ' ' ) &

PID=$!

# NOTE: If you save your login it is possible to press the right keys to log in, but it can be flakey with some websites
## If the password has been saved in the browser this will log in
#for i in $( grep -v '^#' $SOURCE_DIR/urls.txt )
#do
#  sleep 20
#  xdotool search --sync --onlyvisible --class "chromium-browser" key Tab
#  sleep 1
#  xdotool search --sync --onlyvisible --class "chromium-browser" key Tab
#  sleep 1
#  xdotool search --sync --onlyvisible --class "chromium-browser" key Return
#  sleep 5
#  xdotool search --sync --onlyvisible --class "chromium-browser" key ctrl+Tab
#done

# While PID is running cycle through tabs
i=1
while [ -n "$( ps -p $PID -o pid= )" ]
do
  sleep ${TAB_SWITCH_INTERVAL}

  # Refresh at regular intervals
  if [ $(( $i % 13 )) -eq 0 ] || [ $(( $i % 17 )) -eq 0 ]
  then
    xdotool search --sync --onlyvisible --class "chromium-browser" key ctrl+shift+r
    sleep 1
  fi

  xdotool search --sync --onlyvisible --class "chromium-browser" key ctrl+Tab

  i=$(( $i + 1 ))
done

wait $PID
