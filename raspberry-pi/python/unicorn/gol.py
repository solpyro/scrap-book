import unicornhat as uh
import random as rand
import colorsys as col
import time, copy,  pprint

#data
delay = 0.06 #0.03 #30fps
buffer = []
current = []
playing = True
generations = 0

#functions
def update_buffer():
	global current
	current = copy.deepcopy(buffer)
	for y in range(8):
		for x in range(8):
			n = get_neighbours(x,y)
			if n<2 or n>3:
				buffer[y][x] = 0
			if n==3:
				buffer[y][x] = 1
	
def get_neighbours(x,y):
	count = 0
	for dy in range(-1,2):
		fy = normalise(y+dy)
		for dx in range(-1,2):
			fx = normalise(x+dx)
			if (dx!=0 or dy!=0):	
				count += current[fy][fx]
	return count
		
def normalise(n):
	if n < 0:
		n += 8
	if n > 7:
		n -= 8
	return n
				
def show_buffer():
	for y in range(8):
		for x in range(8):
			set_px(x,y,current[y][x])
	uh.show()
	

def set_px(x,y,v):
	r,g,b = [(3*c)/4 for c in uh.get_pixel(x,y)]
	if(v==1):
#		r,g,b = [int(255*c) for c in col.hls_to_rgb(1.0/3,(v*.7),1)]
		r,g,b = [int(255*c) for c in col.hls_to_rgb(rand.random(),(v*.7),1)]
	uh.set_pixel(x,y,r,g,b)

def still_alive():
	live_cells = 0
	for i in range(8):
		for j in range(8):
			live_cells += buffer[i][j]
	return (live_cells>0)	

#prepare unicorn hat
uh.rotation(270) #not required but useful for debugging
uh.brightness(0.5)

#seed array
for y in range(8):
	buffer.append([])
	current.append([])
	for x in range(8):
		buffer[y].append(rand.randint(0,1))
		current[y].append(0)

#glider demo
#buffer = [
#	[0,0,0,0,0,0,0,0],
#	[0,0,0,1,0,0,0,0],
#	[0,1,0,1,0,0,0,0],
#	[0,0,1,1,0,0,0,0],
#	[0,0,0,0,0,0,0,0],
#	[0,0,0,0,0,0,0,0],
#	[0,0,0,0,0,0,0,0],
#	[0,0,0,0,0,0,0,0]
#]

print "Initial Conditions"
pprint.pprint(buffer)

current = copy.deepcopy(buffer)
show_buffer()
time.sleep(5*delay)	

while playing:
	update_buffer()
	show_buffer()
	generations += 1
	time.sleep(delay)
#	cmd = stdscr.getch()
#	if cmd == "q":
#		curses.endwin()
#		sys.exit()
		
#	playing = still_alive()

#print "Colony collapsed after",generations,"generations"
