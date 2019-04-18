from test_util import createLoRa
import LoRaSender

def main():
    LoRa = createLoRa(syncWord=0xF3)
    print('LoRa', LoRa)
    LoRaSender.send(LoRa)

if __name__ == '__main__':
    main()