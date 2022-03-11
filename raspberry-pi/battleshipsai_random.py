#AI functions for battleships.py
#initial attempt will place everything randomly

import battleships_util as util
import random

def place_ships(grid,list):
	for key in list:
		while True:
			x = random.randint(0,7)	
			y = random.randint(0,7)
			d = random.randint(0,3)
			if not util.check_collision(grid,x,y,d,list[key]):
				#store position in grid
				util.set_position(grid,x,y,d,list[key])
				break

def choose_cell(grid):
	#keep picking random cells until we find one that is empty
	while True:
		x = random.randint(0,7)	
		y = random.randint(0,7)
		if grid[x][y]=="?":
			return [x,y]
