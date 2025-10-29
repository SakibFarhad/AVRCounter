MCU=atmega32
F_CPU=1000000UL

CC=avr-g++
OBJCOPY=avr-objcopy

CFLAGS=-mmcu=$(MCU) -DF_CPU=$(F_CPU) -Os -g -std=c++17 -I./src
OBJDIR=bin
TARGET=$(OBJDIR)/main
AVRDUDE=avrdude
AVRDUDE_FLAGS=-c usbasp -p $(MCU)

SRC=main.cpp src/lcd/lcd.cpp
OBJ=$(addprefix $(OBJDIR)/, $(SRC:.cpp=.o))

all: $(OBJDIR) $(TARGET).elf $(TARGET).hex

$(OBJDIR):
	mkdir -p $(OBJDIR)
	mkdir -p $(OBJDIR)/src/lcd

# Compile each source file explicitly
$(OBJDIR)/main.o: main.cpp
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR)/src/lcd/lcd.o: src/lcd/lcd.cpp
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET).elf: $(OBJ)
	$(CC) $(CFLAGS) $^ -o $@

$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex $< $@

clean:
	rm -rf $(OBJDIR)

erase:
	$(AVRDUDE) $(AVRDUDE_FLAGS) -e

flash: $(TARGET).hex
	$(AVRDUDE) $(AVRDUDE_FLAGS) -U flash:w:$<:i