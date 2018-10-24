BUILDDIR = build

MCU = attiny85
#MCU = atmega328p

PROG = stk500
PORT = /dev/ttyUSB0

SOURCES = WaterAlarm.c
CCFLAGS = -mmcu=$(MCU) -O2

all: build-hex

init:
	mkdir -p $(BUILDDIR)

build-elf: init $(SOURCES)
	avr-gcc $(CCFLAGS) -o $(BUILDDIR)/$(SOURCES).elf $(SOURCES)

build-hex: build-elf
	avr-objcopy -O ihex $(BUILDDIR)/$(SOURCES).elf $(BUILDDIR)/$(SOURCES).hex

flash: build-hex
	avrdude -p $(MCU) -c $(PROG) -P $(PORT) -U flash:w:$(BUILDDIR)/$(SOURCES).hex:i

clean:
	rm -rf $(BUILDDIR)
