var gpio = require("pi-gpio");

/******************
The HD44780 should be wired up to the GPIO as follows:

Screen		GPIO
01 <------> 06
02 <------> 02 *
03 <------> 12
04 <------> 16
05 <------> 18
06 <------> 22
07 <---
08 <---
09 <---
10 <---
11 <------> 24
12 <------> 06
13 <------> 26
14 <------> 06 **
15 <------> 02
16 <------> 06

*	Via (Green-Blue-Brown) resistor 
**	Pin 14 is the screens read/write controller.
	Wiring it to power ensures the screen is always in write mode, and doesn't send a 5v signal to the Pi
******************/

//initilise
var pin_rs = 26;
var pin_e = 24;
var pins_db = [22,18,16,12]; 

gpio.open(pin_e,onErr);
gpio.open(pin_e,onErr);
for(pin in pins_db)
	gpio.open(pin,onErr);
	


//clear screen	
exports.clear = function() {
	exports.cmd(0x33);
	exports.cmd(0x32);
	exports.cmd(0x28);
	exports.cmd(0x0C);
	exports.cmd(0x06);
	exports.cmd(0x01);
}
//send screen command
exports.cmd = function(bits, charMode) {
	if(charMode==null||charMode==undefined)
		charMode = false;
	
	/**
	
	sleep(0.001)
	bits=bin(bits)[2:].zfill(8)
	
	GPIO.output(self.pin_rs, char_mode)
	
	for pin in self.pins_db:
		GPIO.output(pin, False)
	
	for i in range(4):
		if bits[i] == "1":
			GPIO.output(self.pins_db[::-1][i], True)
	
	GPIO.output(self.pin_e, True)
	GPIO.output(self.pin_e, False)
	
	for pin in self.pins_db:
		GPIO.output(pin, False)
		
	for i in range(4,8):
		if bits[i] == "1":
			GPIO.output(self.pins_db[::-1][i-4], True)
	
	GPIO.output(self.pin_e, True)
	GPIO.output(self.pin_e, False)
	
	**/
}
//send text to screen
exports.message = function(text) {
	for(chr in text) {
		if(chr == "\n")
			exports.cmd(0xC0);
		else
			exports.cmd(chr.charCodeAt(0), true);
}

//open the GPIO connections
exports.open = function() {
	gpio.open(pin_e,onErr);
	gpio.open(pin_e,onErr);
	for(pin in pins_db)
		gpio.open(pin,onErr);
}
//close the GPIO connections
exports.close = function() {
	gpio.close(pin_e);
	gpio.close(pin_e);
	for(pin in pins_db)
		gpio.close(pin);
}

//error report
function onErr(err) {
	console.log(err);
}

exports.open();
exports.clear();