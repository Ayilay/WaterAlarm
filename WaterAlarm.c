#include <avr/io.h>

// #define F_CPU 16000000UL
// #include <util/delay.h>

#define STEP_PORT PORTB
#define STEP_PIN  PIN1

#define DIR_PORT  PORTB
#define DIR_PIN   PIN0

int main() {

  #if defined (__AVR_ATmega328P__)

    // Set Timer 1 to CTC mode (clear timer on compare match),
    // no prescaler, enable OC1A output
    TCCR1A = 0;
    TCCR1B = 0;
    TCCR1A = _BV(COM1A0);
    TCCR1B = _BV(WGM12) | _BV(CS10);

    // Sets the timer period (16 bit value on ATMega328)
    // Vary this between 2000 and 5000, otherwise motor doesn't work
    OCR1A = 5000;

  #elif defined (__AVR_ATtiny85__)

    // Set Timer 1 to CTC mode, OC1A toggles on match,
    // prescaler = 1024
    TCCR1  = 0;
    TCCR1  = _BV(CTC1) | _BV(COM1A0);
    TCCR1 |= _BV(CS12);// | _BV(CS11);

    // Sets the timer period (8 bit value on ATTiny85)
    // Vary this between 70 and 180, otherwise motor doesn't work
    OCR1C = 70;

  #endif

  // Set the digital pins to outputs
  // ATTiny85 only uses PortB
  DDRB = ~0;

  while (1) {
  }

  return 0;
}
