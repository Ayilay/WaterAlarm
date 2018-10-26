################################################################################
#		Useful Constants
################################################################################

BUILDDIR = build

MCU = attiny85
#MCU = atmega328p

PROG = stk500
PORT = /dev/ttyUSB0

SOURCES = WaterAlarm.c
CCFLAGS = -mmcu=$(MCU) -O2

################################################################################
#		Compilation Recipies
################################################################################

# Creates the compiled hex file to flash to the AVR
all: build-hex

# Compile all the sources into an elf executable (avr-gcc can't output .hex files)
build-elf: init $(SOURCES)
	avr-gcc $(CCFLAGS) -o $(BUILDDIR)/$(SOURCES).elf $(SOURCES)

# Convert elf file into hex file to make flashing easier on avrdude
build-hex: build-elf
	avr-objcopy -O ihex $(BUILDDIR)/$(SOURCES).elf $(BUILDDIR)/$(SOURCES).hex

################################################################################
#		Flash Recipies
################################################################################

# Flashes the compiled code
flash: build-hex
	avrdude -p $(MCU) -c $(PROG) -P $(PORT) -U flash:w:$(BUILDDIR)/$(SOURCES).hex:i

################################################################################
#		Utility Recipies
################################################################################

# Ensures a build directory is present, and puts all compiled files there
init:
	mkdir -p $(BUILDDIR)

clean:
	rm -rf $(BUILDDIR)
