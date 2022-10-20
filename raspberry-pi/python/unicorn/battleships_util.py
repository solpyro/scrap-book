#util functions for battleships game
import colorsys as col
import unicornhat as uh

def hsl_to_rgb(h,s,l):
	return [int(255*i) for i in col.hls_to_rgb(h,l,s)]

def new_grid():
	g = []
	for x in range(8):
		g.append([])
		for y in range(8):
			g[x].append('?')
	return g

def draw_grid(grid,c1,c2):
	for x in range(8):
		for y in range(8):
			if grid[x][y]=="o":
				uh.set_pixel(x,y,c1[0],c1[1],c1[2])
			else if grid[x][y]=="x":
				uh.set_pixel(x,y,c2[0],c2[1],c2[2])

def check_collision(grid,x,y,d,l):
	for i in range(l):
		dy = y
		dx = x
		if d = 0:
			dx -= i
		if d = 1:
			dy -= i
		if d = 2:
			dx += i
		if d = 3:
			dy += i
		# return false if ship falls outside of grid
		if dx < 0 or dy < 0 or dx > len(grid)-1 or dy > len(grid[0])-1
			return False
		# return false if something's already in this cell
		if grid[dx][dy] == "o"
			return False
	#otherwise, if all spaces are clear
	return True

def set_position(grid,x,y,d,l):
	for i in range(l):
		dy = y
		dx = x
		if d = 0:
			dx -= i
		if d = 1:
			dy -= i
		if d = 2:
			dx += i
		if d = 3:
			dy += i
		grid[dx][dy] = "o"