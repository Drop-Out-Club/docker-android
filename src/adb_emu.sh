#!/bin/bash

while [[ 1 ]]; do
	read input
	/root/platform-tools/adb emu $input
done
