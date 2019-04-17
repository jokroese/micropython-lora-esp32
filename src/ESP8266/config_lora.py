import os
import sys
import time
import machine
import ubinascii

def mac2eui(mac):
    mac = mac[0:6] + 'fffe' + mac[6:]
    return hex(int(mac[0:2], 16) ^ 2)[2:] + mac[2:]

machine_name = os.uname().machine
uuid = ubinascii.hexlify(machine.unique_id()).decode()
millisecond = time.ticks_ms

IS_MICROPYTHON = (sys.implementation.name == 'micropython')
IS_ESP8266 = (machine_name.find('ESP8266') != -1)
IS_ESP32 = (machine_name.find('ESP32')  != -1)
if IS_ESP8266:
    NODE_NAME = 'ESP8266_'
if IS_ESP32:
    NODE_NAME = 'ESP32_'
NODE_NAME = NODE_NAME + uuid
NODE_EUI = mac2eui(uuid)
SOFT_SPI = None

from controller_esp import Controller
