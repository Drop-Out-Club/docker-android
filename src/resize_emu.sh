#!/usr/bin/env bash

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

# Note all 9:16 resolutions have the following offset: width+360xheight+640
if [[ "$SCREEN_WIDTH" == "1440" && "$SCREEN_HEIGHT" == "2560" ]]; then #9:16 1080x1920
	# These values were discovered by trial and error, and were only tested on a Smasung S5
	# Also tested on Note 4 but with the emulator res set to 1080x1920 and there were visable borders
	LOC_X=-150
	LOC_Y=-200
	WIDTH=$(( $SCREEN_WIDTH - 51 ))
	HEIGHT=$(( $SCREEN_HEIGHT - 150 ))
elif [[ "$SCREEN_WIDTH" == "1800" && "$SCREEN_HEIGHT" == "3200" ]]; then #9:16 1440x2560
	# These values were discovered by trial and error, and were only tested on a Note 4
	LOC_X=-190
	LOC_Y=-260
	WIDTH=$(( $SCREEN_WIDTH + 30 ))
	HEIGHT=$(( $SCREEN_HEIGHT + 5 ))
elif [[ "$SCREEN_WIDTH" == "1080" && "$SCREEN_HEIGHT" == "1920" ]]; then # 9:16 720x1280
	# These values were discovered by trial and error, and were only tested on a Pantech Vega R3 IM-A850S (which is the same size as the IM-A850L)
	LOC_X=-150
	LOC_Y=-200
	WIDTH=$(( $SCREEN_WIDTH + 910 ))
	HEIGHT=$(( $SCREEN_HEIGHT + 1350 ))
elif [[ "$SCREEN_WIDTH" == "1080" && "$SCREEN_HEIGHT" == "2236" ]]; then # 9:19 1080x2280 (usable space only on Pixel 4)
	# These were discorverd by trial and error, and were only tested on a Pixel 4
	# This isn't exact, but it's as close as I could get
	# Stops right before the curve on the Pixel 4, so nothing get cut off
	# Also, the touch is slightly offset, but it's not very noticable except when using the navigation buttons
	LOC_X=-145
	LOC_Y=-180
	WIDTH=$(( $SCREEN_WIDTH + 300 ))
	HEIGHT=$(( $SCREEN_HEIGHT + 1400 ))
elif [[ "$SCREEN_WIDTH" == "1080" && "$SCREEN_HEIGHT" == "2020" ]]; then # ?:?? 1080x2020 (9:19 1080x2280) (this is the size of a Samsung S10e, up to the camera hole)
	# These were discorverd by trial and error, and were only tested on a Samsung S10e
	LOC_X=-150
	LOC_Y=-200
	WIDTH=$(( $SCREEN_WIDTH + 295 ))
	HEIGHT=$(( $SCREEN_HEIGHT + 490 ))
elif [[ "$SCREEN_WIDTH" == "1080" && "$SCREEN_HEIGHT" == "1620" ]]; then # 2:3 1080x1620
	# These were discorverd by trial and error, and were only tested on a BlackBerry Keyone
	LOC_X=-150
	LOC_Y=-200
	WIDTH=$(( $SCREEN_WIDTH + 500 ))
	HEIGHT=$(( $SCREEN_HEIGHT + 800 ))
fi


wmctrl -r "Android Emulator - nexus_5_8.1:5554" -e 0,$LOC_X,$LOC_Y,$WIDTH,$HEIGHT

# Hide the extra menu android emulator has
wmctrl -r "Emulator" -e 0,0,0,0,0

# This is a hack to make sure the user can't accidently (or purposefully) resize or move the emulator window
#while [[ true ]]; do wmctrl -r "Android Emulator - nexus_5_8.1:5554" -e 0,$LOC_X,$LOC_Y,$WIDTH,$HEIGHT; done
