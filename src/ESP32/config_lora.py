from time import ticks_ms
from machine import unique_id
from ubinascii import hexlify

def mac2eui(mac):
    mac = mac[0:6] + 'fffe' + mac[6:]
    return hex(int(mac[0:2], 16) ^ 2)[2:] + mac[2:]

uuid = hexlify(unique_id()).decode()
millisecond = ticks_ms

NODE_NAME = 'ESP32_' + uuid
NODE_EUI = mac2eui(uuid)
SOFT_SPI = None

from controller_esp import Controller
