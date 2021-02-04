#!/usr/bin/env bash

# Function for floating point division
div() {
	awk "BEGIN { print "$*" }"; 
}

#Wait for device to connect
adb wait-for-device

A=$(adb shell getprop sys.boot_completed | tr -d '\r')

while [ "$A" != "1" ]; do
        sleep 2
        A=$(adb shell getprop sys.boot_completed | tr -d '\r')
done

#Device is now connected

# Make emulator fill screen

# Check aspect ratio
LOC_X=0
LOC_Y=0
WIDTH=$SCREEN_WIDTH
HEIGHT=$SCREEN_HEIGHT
if [[ "$(div $SCREEN_WIDTH/$SCREEN_HEIGHT)" == "0.5625" ]]; then #9:16
	# These values were discovered by trial and error, and were only tested on a Smasung S5
	# Also tested on Note 4 but with the emulator res set to 1080x1920 and there were visable borders
	LOC_X=-150
	LOC_Y=-200
	WIDTH=$(( $SCREEN_WIDTH - 51 ))
	HEIGHT=$(( $SCREEN_HEIGHT - 150 ))
fi


wmctrl -r "Android Emulator - nexus_5_8.1:5554" -e 0,$LOC_X,$LOC_Y,$WIDTH,$HEIGHT

# Hide the extra menu android emulator has
wmctrl -r "Emulator" -e 0,0,0,0,0

# This is a hack to make sure the user can't accidently (or purposefully) resize or move the emulator window
#while [[ true ]]; do wmctrl -r "Android Emulator - nexus_5_8.1:5554" -e 0,$LOC_X,$LOC_Y,$WIDTH,$HEIGHT; done
