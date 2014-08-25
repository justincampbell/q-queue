# q-queue
[![Build Status](https://travis-ci.org/justincampbell/q-queue.svg?branch=master)](https://travis-ci.org/justincampbell/q-queue)

# Options

    [COMMAND]  Queue command to run at a later time in this directory"
    -h         Show this help"
    -l         List queued commands"
    -r         Run queued commands"
    -s         Show number of queued commands, if any (put this in your profile)

# Examples

    $ q git push foo # Queue a git push for later
    $ q !! $ Queue last command
    $ q -l # Show queued commands
    $ q -r # Run queued commands

# Installation

## [Homebrew](http://brew.sh)

    brew tap justincampbell/formulae
    brew install q-queue

## Package

    wget -O q-queue-latest.tar.gz https://github.com/justincampbell/q-queue/archive/latest.tar.gz q-queue
    tar -zxvf q-queue-latest.tar.gz
    cd q-queue-latest/
    make install
