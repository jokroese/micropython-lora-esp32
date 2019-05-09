#!/bin/sh
DEMO=$1

# [function] : ampy put
fn_put () {
    local source=$1 dist=$2

    if [ -f "$source" ]; then
        cp -a $source $dist
        echo "$source --> $dist"
    else
        echo "** file no exist: $source **"
    fi
}

# DEMO
echo "[test : $DEMO]"
fn_put "../codes/demo/$DEMO.py" "raspberry_pi/$DEMO.py"
# Lib
echo "[ put libs ...]"
fn_put ../src/RPi/config_lora.py raspberry_pi/config_lora.py
fn_put ../src/RPi/controller_rpi.py raspberry_pi/controller_rpi.py
# create LoRa folder
if [ ! -d "raspberry_pi/LoRa" ]; then
    mkdir "raspberry_pi/LoRa"
fi
fn_put ../src/LoRa/__init__.py raspberry_pi/LoRa/__init__.py
fn_put ../src/LoRa/controller.py raspberry_pi/LoRa/controller.py
fn_put ../src/LoRa/sx127x.py raspberry_pi/LoRa/sx127x.py
# test
case $DEMO in
    "LoRaSender") TEST="test_sender";;
    "LoRaReceiver") TEST="test_receiver";;
    *) TEST = "";;
esac
if [ -f "$TEST.py" ]; then
    # fn_put ./main.py raspberry_pi/main.py
    # fn_put ./test_util.py raspberry_pi/test_util.py
    fn_put "./$TEST.py" raspberry_pi/test.py
else
    echo "** incorrect DEMO file **"
fi
# list files on board
echo "[list files]"
ls raspberry_pi/