import sys
import time
import socket

millisecond = lambda: time.time() * 1000

NODE_NAME = 'RPi_' + socket.gethostname()

from controller_rpi import Controller
