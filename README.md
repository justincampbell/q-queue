# q-queue

# Options

    [COMMAND]  Queue command to run at a later time in this directory"
    -h         Show this help"
    -l         List queued commands"
    -r         Run queued commands"

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
