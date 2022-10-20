from PIL import Image
import unicornhat as uh
import time, sys

if(len(sys.argv <= 1)) or (sys.argv[1] == ""):
	exit("No image specified")

try:
	frame = Image.open(sys.argv[1])
except Error:
	exit("Failed to load image")
	
nframes = 0
while True:
	try:
		frame.seek( nframes )
	except EOFError:
		try:
			frame.seek(0)
			nframes = 0
		except EOFError:
			exit("Gif has no frames")
	
	rgb_im = frame.convert('RGB')
	for x in range(8):
		for y in range(8):
			r, g, b = rgb_im.getpixel((x,y))
			uh.set_pixel(x,y,r,g,b)
	
	nframes += 1
	time.sleep(0.015)