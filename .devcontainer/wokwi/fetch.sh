#!/bin/bash

set -e
. /home/esp/export-esp.sh
pip3 install esptool

cd espressif-trainings/intro/hardware-check
cargo +esp fetch
cargo +esp build --release
