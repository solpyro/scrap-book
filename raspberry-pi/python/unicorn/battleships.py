import unicornhat as uh
import battleships_util as util
import battleshipsai_random as bsai
import time, pprint, sys

uh.rotation(270)
uh.brightness(0.5)

flash_speed = 0.5 # 1Hz cycle
flash_count = 5

ships = {
	"aircraft carrier": 5,
	"cruiser": 4,
	"submarine": 3,
	"destroyer": 2
}
	
#game functions
def player_place(grid):
	#cycle through ships until all are placed and not colliding
	for key in ships:
		while True:
			#get ship x
			while True:
				x = input("Enter x value (column) between 1 and 8 for your "+key)
				if x>0 and x<=8:
					break
				else:
					print("Value out of range")
			#get ship y
			while True:
				y = input("Enter y value (row) between 1 and 8 for your "+key)
				if y>0 and y<=8:
					break
				else:
					print("Value out of range")
			#get ship dir
			while True:
				d = str(raw_input("Enter direction for your "+key+" (u, d, l or r)"))
				if d=='u' or d=='d' or d=='l' or d=='r':
					d = 1 if d == 'u' else 2 if d == 'r' else 3 if d == 'd' else 4 #python 2.5+
					#d = d == 'u' and 1 or d == 'r' and 2 or d == 'd' and 3 or 4 #pre 2.5 
					break
				else:
					print("Value out of range")
			#check for colisions
			if not util.check_collision(grid,x,y,d,ships[key]):
				#set position
				util.set_position(grid,x,y,d,ships[key])
				break
			else:
				print("This position collides with other ships or the edge of the map. Please select again.")
				print("Remember, your "+key+" is "+str(ships[key])+" cells long")

def player_choose(grid):
	#cycle through player cell selection
	while True:
		#request player x
		while True:
			x = input("Enter x value (column) between 1 and 8")
			if x>0 and x<=8:
				break
			else:
				print("Value out of range")
		
		#request player y
		while True:
			y = input("Enter y value (row) between 1 and 8")
			if y>0 and y<=8:
				break
			else:
				print("Value out of range")
		
		#realign for 0 based array
		x -= 1
		y -= 1
		
		#check cell is unselected
		if grid[x][y]=="?":
			return [x,y]
		else:
			#notify already guessed
			print("You've already chosen this cell. Please choose again")

def won():
	if pl_score==14 or ai_score==14:
		return True
	return False

def check_hit(coord,test,result):
	if test[coord[0]][coord[1]]=="o":
		result[coord[0]][coord[1]] = "o"
		print("Hit!")
		return 1
	else:
		result[coord[0]][coord[1]] = "x"
		print("Miss!")
		return 0
	
def draw_selection(grid,coord):
	util.draw_grid(grid,col_bang,col_splash)
	for i in range(flash_count):
		time.sleep(flash_speed)
		uh.set_pixel(coord[0],coord[1],col_select[0],col_select[1],col_select[2])
		uh.show()
		time.sleep(flash_speed)
		util.draw_grid(grid,col_bang,col_splash)
		uh.show()
	
def display_player_choice(coord):
	uh.clear()
	draw_selection(pl_guess,coord)
	
def display_ai_choice(coord):
	uh.clear()
	util.draw_grid(pl_ships,col_ship,col_select)
	draw_selection(ai_guess,coord)
		
#define display colours
col_splash = util.hsl_to_rgb(1,1,1)
col_bang = util.hsl_to_rgb(0.1,.5,1)
col_ship = util.hsl_to_rgb(0.8,.5,.4)
col_select = util.hsl_to_rgb(0.8,.5,1)

#generate grids
pl_ships = util.new_grid()
pl_guess = util.new_grid()
ai_ships = util.new_grid()
ai_guess = util.new_grid()

#place ships
bsai.place_ships(ai_ships,ships)
player_place(pl_ships)

#set starting scores - if either player reaches 14, they win
pl_score = 0
ai_score = 0
player_turn = True #can randomise to simulate a coin toss

#start game loop
while not won():
	if player_turn:
		#player turn
		coord = player_choose(pl_guess)
		#check hit/miss
		pl_score += check_hit(coord,ai_ships,pl_guess)
		#update and display
		display_player_choice(coord)
	else:
		#ai turn
		coord = bsai.choose_cell(ai_guess)
		#check hit/miss
		print(coord[0]+", "+coord[1])
		ai_score += check_hit(coord,pl_ships,ai_guess)		
		#update and display
		display_ai_choice(coord)	
		
	#switch turns
	player_turn = not player_turn

#game over
if pl_score > ai_score:
	#victory
	#maybe fireworks?
else:
	#defeat
	#a burning ship at sea?
	
#play again y/n...
rematch = input("Would you like a rematch? y/n")
if rematch == "y":
	
else:
	sys.exit("gg no re")
