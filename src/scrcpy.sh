#!/usr/bin/env bash

#Wait for device to connect
adb wait-for-device

A=$(/root/platform-tools/adb shell getprop sys.boot_completed | tr -d '\r')

while [ "$A" != "1" ]; do
        sleep 2
        A=$(/root/platform-tools/adb shell getprop sys.boot_completed | tr -d '\r')
done

#Device is now connected

# start scrcpy
ADB=/root/platform-tools/adb scrcpy -Swf --render-driver=software
