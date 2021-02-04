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
wmctrl -r "Android Emulator - nexus_5_8.1:5554" -e 0,0,0,$SCREEN_WIDTH,$SCREEN_HEIGHT

# Hide the extra menu android emulator has
wmctrl -r "Emulator" -e 0,0,0,0,0

# This is a hack to make sure the user can't accidently (or purposefully) resize or move the emulator window
while [[ true ]]; do wmctrl -r "Android Emulator - nexus_5_8.1:5554" -e 0,0,0,$SCREEN_WIDTH,$SCREEN_HEIGHT; done
