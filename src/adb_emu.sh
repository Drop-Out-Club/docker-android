#!/bin/bash

while [[ 1 ]]; do
	read input
	[[ "$input" == "close" ]] && exit
	/root/platform-tools/adb emu $input
done
