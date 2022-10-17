#!/bin/bash

set -e
. /home/esp/export-esp.sh
pip3 install esptool

cd espressif-trainings/intro/hardware-check
/home/esp/.cargo/bin/cargo +esp fetch
/home/esp/.cargo/bin/cargo +esp build --release
