#!/usr/bin/env bash

# Dependancies
# An OpenGApps package
# unzip
# tar
# lzip
# adb

# Check if device is new. If it's not new, we can safely assume opengapps has already been installed and exit
if [[ -f /root/android_emulator/config.ini ]]; then
	exit
if

OPENGAPPS=$1

mkdir tmp || exit 1
cd tmp

#Prepare Open GAPPS
unzip $OPENGAPPS
tar xf Core/vending-*.tar.lz


#Wait for device to connect
adb wait-for-device

A=$(adb shell getprop sys.boot_completed | tr -d '\r')

while [ "$A" != "1" ]; do
        sleep 2
        A=$(adb shell getprop sys.boot_completed | tr -d '\r')
done

#Device is now connected

adb root
sleep 5
adb remount

adb push vending-*/nodpi/priv-app/Phonesky/Phonesky.apk /system/priv-app

#Restart emulator
adb shell stop && adb shell start

#Cleanup
cd .. && rm -rf tmp
