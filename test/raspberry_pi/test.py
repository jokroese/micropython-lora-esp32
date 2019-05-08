from test_util import createLoRa
import LoRaReceiver

def main():
    LoRa = createLoRa(syncWord=0xF3)
    print('LoRa', LoRa)
    LoRaReceiver.receive(LoRa)

if __name__ == '__main__':
    main()