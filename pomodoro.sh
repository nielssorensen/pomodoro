#/usr/bin/env bash

# A "cheap" pomodoro timer. It resets itself after the sequence has played.

SFX_PATH=/System/Library/Sounds/ # Sound effect path for OSX.
declare -a SEQUENCE
SEQUENCE=(Hero.aiff Blow.aiff Blow.aiff Blow.aiff Submarine.aiff)
SLEEP_TIME="$*" #1200 seconds == 20 minutes
DURATION=0.7 # Length of time a sound should play.

while true; do
    sleep "$SLEEP_TIME";
    for i in "${SEQUENCE[@]}"; do
        afplay -t $DURATION "$SFX_PATH"/"$i"
    done
done
