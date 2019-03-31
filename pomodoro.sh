#!/usr/bin/env bash

# A "cheap" pomodoro timer. It resets itself after the sequence has played.

set -e
[[ -z "${DEBUG}" ]] || set -x

SFX_PATH=/System/Library/Sounds/ # Sound effect path for OSX.
declare -a SEQUENCE
SEQUENCE=(Hero.aiff Blow.aiff Blow.aiff Blow.aiff Submarine.aiff)
declare -i SLEEP_TIME
SLEEP_TIME="$*" #1200 seconds == 20 minutes
DURATION=0.7 # Length of time a sound should play.

function usage () {
    echo "usage: $(basename "$0") integer  positive number, in seconds"
    exit 1
}

function osx_check () {
    if [[ "$(uname -s)" != 'Darwin' ]]
    then
        printf "\n==> For use with Mac OS X\n"
        exit 1
    fi
}

function check_input () {
    if [[ "$SLEEP_TIME" -le 0 ]]
    then
        usage
    fi
}

function play_sequence () {
for i in "${SEQUENCE[@]}"; do
    afplay -t $DURATION "$SFX_PATH"/"$i"
done
}

function main () {
    osx_check
    check_input
    while true; do
        sleep "$SLEEP_TIME";
        play_sequence
    done
}

main
