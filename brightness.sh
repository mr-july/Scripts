#!/bin/sh
SRC="/sys/class/backlight/backlight"

ACPI_MODE_DEFAULT=1

ACPI_MODE=${ACPI_MODE:-$ACPI_MODE_DEFAULT}

[[ -z $1 ]] && { 
    if (( ACPI_MODE != 1)) && which xbacklight > /dev/null; then
        printf "%.f" $(xbacklight -get)
    else
        cat $SRC/brightness
    fi
    exit 1
}

function _xbacklight()
{
     case $1 in
        up|+|UP)
            xbacklight -inc 25 -steps 1
            ;;
        down|-|DOWN)
            xbacklight -dec 25 -steps 1
            ;;
        max|=|MAX)
            xbacklight -set 100 -steps 1
            ;;
        min|\*|MIN)
            xbacklight -set 25 -steps 1
            ;;
        *)
            ;;
    esac
   
}

function _brightness()
{
    local NEW=""
    local MIN=0
    local MAX=$(cat $SRC/max_brightness)
    local CURR=$(cat $SRC/brightness)

    [[ -z $MAX ]] || [[ -z $CURR ]] && return 1

    local AMT_STEPS=8

    local STEP=$(expr $MAX / $AMT_STEPS)
    local ROUNDED_TOTAL=$(expr $STEP \* $AMT_STEPS)

    case $1 in
        up|+|UP)
            [ "$CURR" -lt "$MAX" ] && {
                NEW=$(expr $CURR + $STEP)
                if [ "$NEW" -gt "$MAX" ]; then
                    NEW="$MAX"
                fi
            }
            ;;
        down|-|DOWN)
            [ "$CURR" -gt "$MIN" ] && {
                NEW=$(expr $CURR - $STEP)
                if [ "$NEW" -lt "$MIN" ]; then
                    NEW="$MIN"
                fi
            }
            ;;
        max|=|MAX)
            NEW="$MAX"
            ;;
        min|\*|MIN)
            NEW="$MIN"
            ;;
        *)
            if [ "$1" -ge "$MIN" -a "$1" -le "$MAX" ]; then
                NEW="$1"
            fi
            ;;
    esac

    if [ -n "$NEW" ]; then
        echo $NEW > $SRC/brightness
    fi
}

ACPI_MODE=${ACPI_MODE:-$ACPI_MODE_DEFAULT}

if (( ACPI_MODE != 1)) && which xbacklight > /dev/null; then
    _xbacklight $@
else   
    _brightness $@
fi
exit $?
