#define F_CPU 8000000UL

#include "lcd/lcd.h"
#include <avr/io.h>
#include <util/delay.h>

uint8_t ones, tens, speed;
uint8_t num[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

int main() {

    lcd_init();
    lcd_on();
    // lcd_enable_blinking();
    lcd_printf("AVR");
    _delay_ms(10000);
    lcd_clear();
    lcd_return_home();
    int cnt = 0;
    while (1) {
        for (cnt = 0; cnt <= 100; cnt++) {
            lcd_printf("Count: %02d", cnt);
            _delay_ms(1000);
            lcd_clear();
            // lcd_return_home();
        }
    }
    return 0;
}