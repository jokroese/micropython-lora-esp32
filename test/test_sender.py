from test_util import createLoRa
import LoRaSender

def main():
    LoRa = createLoRa()
    print('LoRa', LoRa)
    LoRaSender.send(LoRa)

if __name__ == '__main__':
    main()