import unicornhat as uh
import colorsys as col
import time, datetime

rgbYear = [int(255*i) for i in col.hls_to_rgb(1.0/6,.5,.7)]
rgbMonth = [int(255*i) for i in col.hls_to_rgb(1.0/6,.5,.7)]
rgbDay = [int(255*i) for i in col.hls_to_rgb(1.0/6,.5,.7)]
rgbHour = [int(255*i) for i in col.hls_to_rgb(1.0/3,.5,.7)]
rgbMinute = [int(255*i) for i in col.hls_to_rgb(1.0/3,.5,.7)]
rgbSecond = [int(255*i) for i in col.hls_to_rgb(1.0/3,.5,.7)]
rgbHundreth = [int(255*i) for i in col.hls_to_rgb(1.0,.5,.7)]

uh.brightness(0.5)
uh.rotation(270)

def display_binary(v,r,c):
	str = "{0:8b}".format(v)
	for i in range(8):
		if str[i] == '1':
			uh.set_pixel(i,r,c[0],c[1],c[2])
		else:
			uh.set_pixel(i,r,0,0,0)

while True:
	t = datetime.datetime.now()
	#dim for night
	if t.hour >= 21 or t.hour < 8:
		uh.brightness(0.3)
	else:
		uh.brightness(0.5)
		
	#display clock
	display_binary(t.year%100,0,rgbYear)
	display_binary(t.month%100,1,rgbMonth)
	display_binary(t.day%100,2,rgbDay)
	display_binary(t.hour%100,3,rgbHour)
	display_binary(t.minute%100,4,rgbMinute)
	display_binary(t.second%100,5,rgbSecond)
	display_binary(t.microsecond%100,6,rgbHundreth)
	uh.show()
	time.sleep(0.001)
