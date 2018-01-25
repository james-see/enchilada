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

# check if first run
declare -i firstrun=1
if [ -f .firstrun ]; then
    echo "not your first time running this, veteran..."
    firstrun=0
else
    echo '**** first run! welcome to town... ****'
    touch .firstrun
    echo date -u >> .firstrun
    firstrun=1
fi
# check for homebrew installation and exit if not installed
/bin/bash check_homebrew.sh

echo "[-*-] checking if blueutil installed via homebrew and installing if not...";
if brew ls --versions blueutil > /dev/null; then
    echo 'blueutil installed, moving on...'
else
    echo "Installing blueutil now...";
    brew install blueutil
fi

# check if bluetooth turned on
echo "[-*-] getting bluetooth status on/off and discoverable on/off on OSX...";
date -u > bluetooth.log;
echo "----------------" >> bluetooth.log;
blueutil >> bluetooth.log;
# get bluetooth device info OSX
echo "[-*-] getting bluetooth device mac address for OSX...";
sleep 1;
echo 
system_profiler SPBluetoothDataType | sed -n "/Apple Bluetooth Software Version\:/,/Manufacturer\:/p" | egrep -o '([[:xdigit:]]{1,2}-){5}[[:xdigit:]]{1,2}' >> bluetooth.log;
echo 

# airport wifi info
# only need to create symlink once dude / dudette
if [[ "$firstrun" -eq "1" ]]; then
    sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
fi
echo "[-*-] getting WIFI networks nearby...";
#airport -s
airportinfo=$(airport -s | tee /dev/tty);
date -u > ssid.log
echo "----------------" >> ssid.log
echo $airportinfo >> ssid.log;


# echo them all out at the end budd
cat bluetooth.log
cat ssid.log
echo
echo "finis merci poisson"

