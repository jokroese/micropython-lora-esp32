# MicroPython-LoRa-SX127x
> Thank [Wei1234c](https://github.com/Wei1234c) sharing his work.
> - Original Project : https://github.com/Wei1234c/SX127x_driver_for_MicroPython_on_ESP8266
> - Description in Chinese: https://wei1234c.blogspot.tw/2017/08/sx127x-lora-transceiver-driver-for.html

The target of this project is refactoring codes for more friendly.

Folders of Original Project:
- **codes**
- **examples**
- **jpgs**
- **notebooks**
- **references**

## Support Boards
- ESP8266
- ES32
- Raspberry Pi

## Refactoring
In order to reduce the coupling, the LoRa core module and the independent configuration of each supported board are separated from the original codes.
- **src/LoRa**: LoRa core module, include `sx127x` and `controller` abstract class.
- **src/ES32**: configuration and implement `controller` class for ES32.
- **src/ESP8266**: configuration and implement `controller` class for ESP8266.
- **src/RPi**: configuration and implement `controller` class for Raspberry Pi.

## Testing
All testing codes are placed in **test** Folder, see [README.md](test/README.md).
