#!/bin/bash

export DISPLAY=:0.0

xdotool search --sync --onlyvisible --class "chromium-browser" key Return
