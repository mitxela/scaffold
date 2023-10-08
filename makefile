
all:
	avrasm2 -fI -o scaffold.hex scaffold.asm

flash: all
	avrdude -c usbasp -p t44 -U flash:w:"scaffold.hex":i
