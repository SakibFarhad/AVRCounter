#define F_CPU 1000000UL

#include <avr/io.h>
#include <avr/iom32.h>
#include <util/delay.h>
// #include "lcd/lcd.h"

int main()
{
    DDRD |= (1 << PIND0);
    // lcd_init();
    // lcd_enable_blinking();

    while (1)
    {
        PORTD |= (1 << PIND0);
        _delay_ms(500);

        PORTD &= ~(1 << PIND0);
        _delay_ms(500);
    }

    return 0;
}