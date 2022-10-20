import unicornhat as uh
import colorsys as col
import time,random

uh.rotation(270)
uh.brightness(0.5)

#machine variables
running = True
pointer = {
	'x': 0,
	'y': 0,
	's': 0,	#mite state
	'r': 0	#mite rotation
}
state = 0

#programme variables
framerate = 1/16 # 16fps

#Ruleset class currently constructs a random set of rules
class Ruleset(object):
	#constructor
	def __init__(self):
		#define the maximum number of cell/mite states
		self.cellStates = 2#random.randint(2,2)
		self.miteStates = 2#random.randint(2,2)
		
		#define a new rule for each cell/mite state pair
		self.rules = [];
		for i in range(self.cellStates):
			self.rules.append([])
			for j in range(self.miteStates):
				self.rules[i].append({
					'ts': random.randint(0,self.miteStates-1), #new mite state
					'td': random.randint(0,3), #new mite direction
					'cs': random.randint(0,self.cellStates-1) #new cell state
				})
		
		#define the initial state for the machine
		self.start = {
			'ts': random.randint(0,self.miteStates-1), #new mite state
			'td': random.randint(0,3), #new mite direction
			'cs': random.randint(0,self.cellStates-1) #new cell state
		}
		
		#define if td is set or added when changing mite direction
		self.turnMode = True
	
	#set initial state for turmite & return initial state of the board
	def initilise(self, mite):
		#should we also set the position here?
		mite['x'] = 4
		mite['y'] = 4
		mite['r'] = self.start['td']
		mite['s'] = self.start['ts']
		return self.start['cs']

	#enact a command given the current cell state and turmite
	#return the new cell state
	def do(self, cell, mite):
		#get the rule for the mite/ceel combination
		rule = self.rules[mite['s']][cell]

		#set new mite states
		if(self.turnMode):
			mite['r'] = (mite['r']+rule['td'])%4
		else:
			mite['r'] = rule['td']
		mite['s'] = rule['ts']
		
		#move the mite
		if(mite['r']==0):	#north
			mite['y'] = mite['y']-1
		elif(mite['r']==1):	#east
			mite['x'] = mite['x']+1
		elif(mite['r']==2):	#south
			mite['y'] = mite['y']+1
		else:				#west
			mite['x'] = mite['x']-1
		
		#return the cell state
		return rule['cs']
	
	#returns the number of cell states there can be
	def stateCount(self):
		return self.cellStates

#machine functions
def getCellVal(ptr):
	return colToState(uh.get_pixel(ptr['x'],ptr['y']))
	
def doCmd(state):
	uh.set_pixel(pointer['x'],pointer['y'],*stateToCol(ruleset.do(state,pointer)))

#utilities
def stateToCol(state):
	return [int(255*i) for i in col.hls_to_rgb((360*state)/ruleset.stateCount(),.5,0.5)]
	
def colToState(rgb):
	h,l,s = col.rgb_to_hls(*[(i/255) for i in rgb])
	return (360/h) if h>0 else 0

def normalisePointer():
	while(pointer['x']<0):
		pointer['x'] = pointer['x']+7
	while(pointer['y']<0):
		pointer['y'] = pointer['y']+7
	if(pointer['x']>7):
		pointer['x'] = pointer['x']%8
	if(pointer['y']>7):
		pointer['y'] = pointer['y']%8
	
#create ruleset
ruleset = Ruleset()

#initilise board
rgb = stateToCol(0)
for x in range(8):
	for y in range(8):
		uh.set_pixel(x,y,*rgb)

#initilise turmite
state = ruleset.initilise(pointer)
normalisePointer()
uh.set_pixel(pointer['x'],pointer['y'],*stateToCol(state))

#main loop - execute pointer instruction
while running:
	doCmd(getCellVal(pointer))
	normalisePointer()
	uh.show()
	time.sleep(framerate)