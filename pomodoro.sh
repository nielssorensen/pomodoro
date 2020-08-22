#!/usr/bin/env bash

# A "cheap" pomodoro timer. It resets itself after the sequence has played.

set -e
[[ -z "${DEBUG}" ]] || set -x

SFX_PATH=/System/Library/Sounds/ # Sound effect path for OSX.
declare -a SEQUENCE
INTRO_SEQUENCE=(Ping.aiff Ping.aiff Ping.aiff Glass.aiff)
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

function play_intro() {
    for i in "${INTRO_SEQUENCE[@]}";
    do
        afplay -t "${DURATION}" "${SFX_PATH}/${i}"
    done
}

function check_input () {
    if [[ "$SLEEP_TIME" -le 0 ]]
    then
        usage
    fi
}

function play_sequence () {
    for i in "${SEQUENCE[@]}"; do
        afplay -t "${DURATION}" "${SFX_PATH}/${i}"
    done
}

# TODO: create a counter. this should increment a variable every time the loop runs
# upon exit, display the number of times the loop ran
# TODO: IF CTRL-Z was hit, it should record the number of seconds that the script was paused
# TODO: create a break period end tone
# TODO: at end of the pomodoro period, ask what was achieved in the period
# TODO: at the end of the break period, ask what was done to recharge
# TODO: generate a report of the answers the user provided for historical purposes; output to text file

loop_counter() {
    :
}

function main () {
    osx_check
    check_input
    play_intro
    while true; do
        sleep "$SLEEP_TIME";
        play_sequence
    done
}

main
