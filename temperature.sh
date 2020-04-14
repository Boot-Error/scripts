#!/bin/bash

# `temperature.sh` reads temperature values from themal_zones[1-10]
# changed THRESHOLD to use highlight temperature greater than Threshold
# todo: map zones to places on the Motherboard

DIRECTORY=/sys/class/thermal
THRESHOLD=60

for i in $(ls $DIRECTORY | grep thermal_zone); do
	TEMP=$(cat $DIRECTORY/$i/temp | sed "s/[0-9]\{3\}\$//")
	printf "%s " $i
	[ $TEMP -ge $THRESHOLD ] \
		&& echo -e '\033[30m\033[41m'$TEMP C'\033[39m\033[40m' \
		|| echo -e '\033[30m\033[44m'$TEMP C'\033[39m\033[40m'
done
