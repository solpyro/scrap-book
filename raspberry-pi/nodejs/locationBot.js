var fs = require('fs');
var sys = require('util');
var stdin = process.openStdin();

var net = require('net');
var irc = {};

//Bot information
var sNick = "6thBeestonBot";
var aIgnoreList = ["StatServ","NickServ","ChanServ"];
var aAdminList = ["Solpyro"];
var sRoom = "#6thBeeston";

//bot components
var aMemory = [];
var wsUnknowns = fs.createWriteStream("newLocations.txt");

//listen for commands from the server console
stdin.addListener('data', function(d) {
	//convert d to a string and remove the trailing \n
	var sData = d.toString().substring(0,d.length-1);
	
	switch(sData.toLowerCase()) {
		case "help":
			console.log("This is an IRC bot, what help do you need?");
			console.log("Type 'quit' to stop the bot.");
			break;
		case "quit":
		case "exit":
			irc.raw("QUIT I have been called back to the source, to be decompiled...");
			process.exit(1);
		default:
			console.log("Command ["+sData+"] not known.");
			console.log("Type 'help' for help.");
	}
});

//basic IRC communication
irc.socket = new net.Socket();
irc.socket.on('connect', function() {
	console.log('*** Connected & registering');
	setTimeout(function() {
		irc.raw('NICK '+sNick);
		irc.raw('USER '+sNick+' * Node.js IRCBot');
	//	irc.raw('LIST');
	}, 1000); 
});
irc.socket.on('data', function(data) {
	data = data.split('\r\n');
	for(var i=0;i<data.length;i++) {
		console.log('RECV -',data[i]);
		if(data[i]!='')
			irc.handle(data[i]);
	}
});

//IRC utilities
irc.raw = function(data) {
	irc.socket.write(data+'\r\n', 'ascii', function() {
		console.log('SENT -', data);
	});
}
irc.handle = function(data){
	var i, info;
	for(i=0;i<irc.listeners.length;i++) {
		info = irc.listeners[i][0].exec(data);
		if(info) {
			irc.listeners[i][1](info,data);
			if(irc.listeners[i][2]){
				irc.listeners.splice(i,1);
				i--;
			}
		}
	}
};
irc.listeners = [];
irc.on = function(data, callback) {
	irc.listeners.push([data, callback, false]);
};
irc.onOnce = function(data, callback) {
	irc.listeners.push([data, callback, true]);
};

//////////////////////////////////////////////////
// Specific controlls for this BOT
//////////////////////////////////////////////////
//Stops timeout by responding to PING
irc.on(/^PING :(.+)$/i, function(info) {
	irc.raw('PONG :'+info[1]);
});
//logs user onto #test after MOTD
irc.onOnce(/376(.+)$/i, function(info,data) {
	//console.log('***'+info);
	//irc.raw('LIST');
	irc.raw('JOIN ');
});
irc.on(/PRIVMSG(.+)$/i, function(info,data) {
	//find message target
	var sChannel = /\s+(.+?)\s/i.exec(info[1])[1];
	var sSpeaker = /:(.+?)!/i.exec(data)[1];
	if(ignore(sSpeaker))
		return;
	//if target is the bot (private message) reply to person
	if(sChannel==sNick)
		sChannel = sSpeaker
	//else reply to room target...
	
	//check for orders
	var sBody = /:(.+?)$/i.exec(info[1])[1];
	var aBody = sBody.split(" ");
	if(aBody[0].toLowerCase()==sNick.toLowerCase()) {
		//create variables
		var sMessage = "";
		var bSendMessage = true;
		//interpret command
		switch(aBody[1].toLowerCase()) {
			case "list"://list available commands
			case "help":
				irc.raw("NOTICE "+sSpeaker+" HELP - lists available commands");
				irc.raw("NOTICE "+sSpeaker+" LOG <location> - logs a new friend at a location. You may be asked for more information if you are vague.");
				if(isAuthorized(sSpeaker)) {
					irc.raw("NOTICE "+sSpeaker+" QUIT - make me leave the server");
				}
				bSendMessage = false;
				break;
			case "log":
				if(aBody.length>2) {
					//check location
					if(isLargeGrain(aBody[2])){
						//ask for smaller grain
						sMessage = "Do you know anything closer than that?"
						//remember the current location in case there's nothing closer
						aMemory[sSpeaker] = aBody[2];
					} else {
						if(isFineGrain(aBody[2])) {
							//clear the old memory if there was anything there
							aMemory[sSpeaker] = null;
							//store fine grain location
//TODO - communicate with display program
							//location stored
							sMessage = "I've added a nother counter to "+aBody[2];
						} else {
							//unknown location
							sMessage = "I'm afraid I don't know that place. Do you have an alternative?";
							//log new location for future reference
							wsUnknowns.write(sSpeaker+' requested location '+aBody[2]+"\n");
							irc.raw('NOTICE '+aAdminList[0]+' '+sSpeaker+' requested location '+aBody[2]+"\n");
						}
					}
				} else {
					//log where...?
					sMessage = "You seem to have forgotten to tell me a location. Please try again...";
				}
				break;
			case "no":
				if((aMemory[sSpeaker]==null)||(aMemory[sSpeaker]==undefined)) {
					//no stored memory for this speaker
					sMessage = "Oops, I seem to have forgotten where you said your friend was from. Can you tell me again?";
				} else {
					//store large grain location
//TODO - communicate with display program
					//location stored
					sMessage = "I've added a nother counter to "+aMemory[sSpeaker];
					//clear the old memory
					aMemory[sSpeaker] = null;
				}
				break;
			case "quit":
			case "q":
				if(isAuthorized(sSpeaker)) {
					bSendMessage = false;
					irc.raw("QUIT I have been called back to the source, to be decompiled...");
					process.exit(1);
				}
				break;
			default://unknown command
				sMessage = "Are you trying to log a new friend? If you're having problems, try typing '"+sNick+"  help'.";
		}
		//send final message
		if(bSendMessage) irc.raw("NOTICE "+sSpeaker+" "+sMessage);
	}
});

//add pop-by-value to array type
Array.prototype.pop = function(valIn) {
	var valOut = null;
	for(var i=0;i<this.length;i++) {
		if(this[i]==valIn) {
			valOut = valIn;
			this.splice(i,1);
		}
	}
	return valOut;
}

//prepare permission functions
function ignore(nick) {
	for(var i=0;i<aIgnoreList.length;i++) {
		if(aIgnoreList[i]==nick)
			return true;
	}
	return false;
}
function isAuthorized(nick){
	for(var i=0;i<aAdminList.length;i++) {
		if(aAdminList[i]==nick)
			return true;
	}
	return false;
}
function inRoom(channel) {
	for(var i=0;i<aRoomList.length;i++) {
		if(aRoomList[i]==channel)
			return true;
	}
	return false;
}

//prepare location check functions
function isLargeGrain(loc) {
	
}
function isFineGrain(loc) {
	
}

//begin the bot
irc.socket.setEncoding('ascii');
irc.socket.setNoDelay();
irc.socket.connect(6667,'chat.scoutlink.net');