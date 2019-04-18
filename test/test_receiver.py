from test_util import createLoRa
import LoRaReceiver

def main():
    LoRa = createLoRa()
    print('LoRa', LoRa)
    LoRaReceiver.receive(LoRa)

if __name__ == '__main__':
    main()