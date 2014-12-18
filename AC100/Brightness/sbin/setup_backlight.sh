#!/bin/sh

BRIGHTNESS="/sys/class/backlight/backlight/brightness"
OWNER="root:video"
MODE=664

/bin/chown $OWNER $BRIGHTNESS
/bin/chmod $MODE $BRIGHTNESS
