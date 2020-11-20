#!/usr/bin/env bash

# Dependancies
# An OpenGApps package
# unzip
# tar
# lzip
# adb

OPENGAPPS=$1

mkdir tmp || exit 1
cd tmp

adb root
adb remount

unzip $OPENGAPPS

#Extract required APK and install it
tar xf Core/vending-*.tar.lz
adb push vending-*/nodpi/priv-app/Phonesky/Phonesky.apk /system/priv-app

#Restart emulator
adb shell stop && adb shell start

cd .. && rm -rf tmp
