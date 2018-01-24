#!/bin/bash

echo """
╔════════════════════════════════════════════════╗
║                                                ║
║           ┌───────────────┐                    ║
║           │   ENCHILADA   │                    ║
║           └───────────────┘         ▴▴▴▴▴      ║
║                              ▴▴▴▴▴▴▴▴   ▴▴▴▴   ║
║                ◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉             ▴▴  ║
║             ◉◉◉ ◉◉◉  ▴▴▴▴▴   ◉◉◉◉◉◉◉◉◉◉    ▴▴  ║
║            ◉◉  ◉◉◉◉▴▴▴◉◉◉◉    ◉◉     ◉◉  ▴▴▴   ║
║          ◉◉◉◉◉◉▴◉◉ ◉◉◉◉  ◉ ◉◉◉◉◉     ◉◉▴▴▴     ║
║         ◉◉  ◉▴▴◉◉◉◉◉   ◉◉◉◉◉  ◉◉◉◉◉◉▴▴◉◉       ║
║         ◉◉◉◉◉◉ ◉◉◉     ◉◉◉   ◉◉◉◉▴◉◉◉◉ ◉       ║
║      ▴▴▴▴▴   ◉◉◉◉◉◉◉◉◉◉◉◉   ◉◉▴      ◉◉◉       ║
║    ▴▴▴▴▴▴▴▴▴▴▴        ◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉◉        ║
║ ▴▴▴▴▴◉◉◉◉◉◉◉◉▴▴▴       ▴▴▴▴                    ║
║ ▴▴▴◉◉◉◉◉◉◉◉◉◉◉ ▴  ▴▴▴▴▴▴                       ║
║  ▴▴◉◉◉◉◉◉◉◉◉◉◉▴▴▴▴▴                            ║
║    ▴▴▴▴▴▴▴▴▴▴▴▴▴                               ║
║                                                ║
╚════════════════════════════════════════════════╝
""";

# check for homebrew installation and exit if not installed
echo "[-*-] checking if Homebrew is installed on OSX...";
if which brew > /dev/null 2>&1; then
    echo "Homebrew installed! Moving on"
else
    echo "Homebrew not installed, shame on you. Go to https://brew.sh and follow the instructions and run this again."
    exit 1
fi

echo "[-*-] checking if blueutil installed via homebrew and installing if not...";
if brew ls --versions blueutil > /dev/null; then
    echo 'blueutil installed, moving on...'
else
    echo "Installing blueutil now...";
    brew install blueutil
fi

# check if bluetooth turned on
echo "[-*-] getting bluetooth status on/off and discoverable on/off on OSX...";
blueutil 
# get bluetooth device info OSX
echo "[-*-] getting bluetooth device mac address for OSX...";
sleep 1;
echo 
system_profiler SPBluetoothDataType | sed -n "/Apple Bluetooth Software Version\:/,/Manufacturer\:/p" | egrep -o '([[:xdigit:]]{1,2}-){5}[[:xdigit:]]{1,2}'
echo 
