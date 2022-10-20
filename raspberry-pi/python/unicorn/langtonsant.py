import unicornhat as uh
import random as rand
import colorsys as col
import time, copy,  pprint

#data
grid = []
ant_x = 3
ant_y = 3
ant_r = 0
delay = 0.06

#functions
def move_ant():
	turn_ant()
	flip_cell()
	move_forward()

def turn_ant():
	global ant_r
	if grid[ant_y][ant_x] == 1:
		ant_r -= 1
	else :
		ant_r += 1
	normalise_rotation()

def normalise_rotation():
	global ant_r
	if ant_r < 0:
		ant_r = 3
	if ant_r > 3:
		ant_r = 0
	
def flip_cell():
	if grid[ant_y][ant_x] == 1:
		grid[ant_y][ant_x] = 0
	else:
		grid[ant_y][ant_x] = 1
	
def move_forward():
	global ant_x, ant_y
	#step forwards 0:n - 3:w
	if ant_r == 0:
		ant_y -= 1
	if ant_r == 1:
		ant_x += 1
	if ant_r == 2:
		ant_y += 1
	if ant_r == 3:
		ant_x -= 1
	normalise_position()

def normalise_position():
	global ant_x, ant_y
	if ant_x < 0:
		ant_x = 7
	if ant_x > 7:
		ant_x = 0
	if ant_y < 0:
		ant_y = 7
	if ant_y > 7:
		ant_y = 0

def draw_grid():
	for y in range(8):
		for x in range(8):
			r,g,b = [(3*c)/4 for c in uh.get_pixel(x,y)]
			if(grid[x][y]==1):
				r,g,b = [255,255,255]
			uh.set_pixel(x,y,r,g,b);
	uh.show()

uh.brightness(0.4)
uh.rotation(270)

for y in range(8):
	grid.append([])
	for x in range(8):
		grid[y].append(0)

while True:
	move_ant()
	draw_grid()
#	print ant_x, ant_y, ant_r
#	pprint.pprint(grid)
	time.sleep(delay)
