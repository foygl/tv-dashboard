#!/bin/bash

export DISPLAY=:0.0

while read -n1 char
do
  xxd <<< $char 
  char="$( sed 's/+/plus/; s/@/at/; s/\./period/; s/[\t#]/Tab/; s/[\n~]/Return/; s/\x7f/BackSpace/' <<< $char )"
  xdotool search --sync --onlyvisible --class "chromium-browser" key "$char"
done
