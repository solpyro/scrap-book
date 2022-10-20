import random

#constructs and returns a set of rules with some API functions
def createRuleset():
	return Ruleset()

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
			rules[i] = []
			for j in range(self.miteStates):
				rules[i][j] = {
					'ts': random.randint(self.miteStates), #new mite state
					'td': random.randint(4), #new mite direction
					'cs': random.randint(self.cellStates) #new cell state
				}
		
		#define the initial state for the machine
		self.start = {
			'ts': random.randint(self.miteStates), #new mite state
			'td': random.randint(4), #new mite direction
			'cs': random.randint(self.cellStates) #new cell state
		}
	
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
