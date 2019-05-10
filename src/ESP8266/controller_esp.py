from machine import Pin, SPI, reset
import controller



class Controller(controller.Controller):
    # LoRa config
    PIN_ID_FOR_LORA_RESET = 4

    PIN_ID_FOR_LORA_SS = 15
    PIN_ID_SCK = 14
    PIN_ID_MOSI = 13
    PIN_ID_MISO = 12

    PIN_ID_FOR_LORA_DIO0 = 5
    PIN_ID_FOR_LORA_DIO1 = None
    PIN_ID_FOR_LORA_DIO2 = None
    PIN_ID_FOR_LORA_DIO3 = None
    PIN_ID_FOR_LORA_DIO4 = None
    PIN_ID_FOR_LORA_DIO5 = None

    # ESP config
    ON_BOARD_LED_PIN_NO = 2
    ON_BOARD_LED_HIGH_IS_ON = False
    GPIO_PINS = (0, 1, 2, 3, 4, 5, 12, 13, 14, 15, 16)


    def __init__(self,
                 pin_id_led = ON_BOARD_LED_PIN_NO,
                 on_board_led_high_is_on = ON_BOARD_LED_HIGH_IS_ON,
                 pin_id_reset = PIN_ID_FOR_LORA_RESET,
                 blink_on_start = (2, 0.5, 0.5)):

        super().__init__(pin_id_led,
                         on_board_led_high_is_on,
                         pin_id_reset,
                         blink_on_start)


    def prepare_pin(self, pin_id, in_out = Pin.OUT):
        if pin_id is not None:
            pin = Pin(pin_id, in_out)
            new_pin = Controller.Mock()
            new_pin.pin_id = pin_id
            new_pin.value = pin.value

            if in_out == Pin.OUT:
                new_pin.low = lambda: pin.value(0)
                new_pin.high = lambda: pin.value(1)
            else:
                new_pin.irq = pin.irq

            return new_pin


    def prepare_irq_pin(self, pin_id):
        pin = self.prepare_pin(pin_id, Pin.IN)
        if pin:
            pin.set_handler_for_irq_on_rising_edge = lambda handler: pin.irq(handler = handler,
                                                                             trigger = Pin.IRQ_RISING)
            pin.detach_irq = lambda: pin.irq(handler = None, trigger = 0)
            return pin


    def get_spi(self):
        #spi = None
        id = 1
        spi = SPI(id, baudrate = 10000000, polarity = 0, phase = 0)
        spi.init()
        return spi


    def prepare_spi(self, spi):
        if spi:
            new_spi = Controller.Mock()


            def transfer(pin_ss, address, value = 0x00):
                response = bytearray(1)

                pin_ss.low()

                spi.write(bytes([address]))
                spi.write_readinto(bytes([value]), response)

                pin_ss.high()

                return response


            new_spi.transfer = transfer
            new_spi.close = spi.deinit
            return new_spi


    def __exit__(self):
        self.spi.close()
