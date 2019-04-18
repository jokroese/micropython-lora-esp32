
## Put files to board (PowerShell)
Command:
```
install.ps1 -PORT <AMPY_PORT> -MACHINE <MACHINE> -DEMO <MACHINE>
```
- AMPY_PORT : USB serial port name
- MACHINE : Choose a support machine name `[ESP8266, ES32, RPi]`
- DEMO : LoRa demo file (no extension)

example:
```
> powershell
PS > ./install.ps1 -PORT COM8 -MACHINE ESP8266 -DEMO LoRaReceiver
PS > ./install.ps1 -PORT COM10 -MACHINE ESP8266 -DEMO LoRaSender
```
