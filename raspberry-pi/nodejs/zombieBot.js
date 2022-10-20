var sys = require('util');
var stdin = process.openStdin();

var net = require('net');
var irc = {};

//Bot information
var sNick = "zombieIMP";
var aIgnoreList = ["StatServ","NickServ","ChanServ"];
var aAdminList = ["Solpyro"];
var sRoom = "#zombieIMP";

//game components | = health change, ^ = zombies!, "You find an item." = turn over another card
var aCardDB = [
	{
		nine:"You find a candybar in your pocket. +1 Health|1",
		ten:"You find an item.",
		eleven:"There are four zombies! What do you do?^4",
		item:"Can of Soda"
	},
	{
		nine:"You try hard not to wet yourself.",
		ten:"You find an item.",
		eleven:"There are six zombies! What do you do?^6",
		item:"Can of Oil"
	},
	{
		nine:"You find an item.",
		ten:"There are five zombies! What do you do?^5",
		eleven:"'Your soul isn't wanted here!' -1 Health|-1",
		item:"Grisly Femur"
	},
	{
		nine:"There are four zombies! What do you do?^4",
		ten:"A bat poops in your eye. -1 Health|-1",
		eleven:"There are six zombies! What do you do?^6",
		item:"Machete"
	},
	{
		nine:"There are four zombies! What do you do?^4",
		ten:"You sense your impending doom. -1 Health|-1",
		eleven:"You find an item.",
		item:"Gasoline"
	},
	{
		nine:"There are three zombies! What do you do?^3",
		ten:"You hear terrible screams.",
		eleven:"There are five zombies! What do you do?^5",
		item:"Chainsaw"
	},
	{
		nine:"You find an item.",
		ten:"There are four zombies! What do you do?^4",
		eleven:"There's something icky in your mouth. -1 Health|-1",
		item:"Board with Nails"
	},
	{
		nine:"Your body shivers involuntarily.",
		ten:"You feel a spark of hope. +1 Health|1",
		eleven:"There are four zombies! What do you do?^4",
		item:"Candle"
	},
	{
		nine:"You slip in nasty goo. -1 Health|-1",
		ten:"There are four zombies! What do you do?^4",
		eleven:"The smell of blood is in the air.",
		item:"Golf Club"
	}
];
var aHouseDB = [
	{
		room:"Evil Temple",
		exits:"0,1,0,1"
	},
	{
		room:"Family Room",
		exits:"1,1,0,1"
	},
	{
		room:"Dining Room",
		exits:"1,1,1,1"
	},
	{
		room:"Kitchen",
		exits:"1,1,0,1"
	},
	{
		room:"Storage Room",
		exits:"1,0,0,0"
	},
	{
		room:"Bedroom",
		exits:"1,0,0,1"
	},
	{
		room:"Bathroom",
		exits:"1,0,0,0"
	}
];
var aGardenDB = [
	{
		room:"Yard",
		exits:"0,1,1,1"
	},
	{
		room:"Yard",
		exits:"0,1,1,1"
	},
	{
		room:"Yard",
		exits:"0,1,1,1"
	},
	{
		room:"Sitting Area",
		exits:"0,1,1,1"
	},
	{
		room:"Garage",
		exits:"0,0,1,1"
	},
	{
		room:"Garden",
		exits:"0,1,1,1"
	},
	{
		room:"Graveyard",
		exits:"1,0,0,1"
	}
];

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
	irc.raw('JOIN '+sRoom);
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
				irc.raw("NOTICE "+sSpeaker+" LIST - lists available commands");
				irc.raw("NOTICE "+sSpeaker+" WHISPER <nick> <message> - whispers a message to a person in a room. I have to already be in that room.");
				if(isAuthorized(sSpeaker)) {
					irc.raw("NOTICE "+sSpeaker+" GOTO <#room> - make me join a chatroom");
					irc.raw("NOTICE "+sSpeaker+" LEAVE [<#room>] - make me leave a chatroom (If no room supplied, I'll leave here)");
					irc.raw("NOTICE "+sSpeaker+" QUIT - make me leave the server");
				}
				bSendMessage = false;
				break;
			case "whisper":
			case "whsp":
				//check there are enough arguments
				if(aBody.length>3) {
					//collapse element 3+ down
					sMessage = aBody.splice(3,aBody.length-3).join(" ");
					//whisper the message
					irc.raw("NOTICE "+aBody[2]+" "+sMessage);
					sMessage = "I have whispered that to "+aBody[2]+".";
				} else {
					irc.raw("NOTICE "+sSpeaker+" There wasn't enough there for me to do this.");
					sMessage = "I need a <nick> and a <message> in that order to whisper.";
				}
				break;
			case "goto"://connect to a new chat room
			case "go":
			case "join":
				if(isAuthorized(sSpeaker)) {
					if(aBody.length>2){
						//check the room has a hash, and add one
						if(aBody[2].charAt(0)!="#")
							aBody[2] = "#"+aBody[2];
						//check im not already in the room
						if(!inRoom(aBody[2])) {
							irc.raw("JOIN "+aBody[2]);
							sMessage = "I have joined "+aBody[2]+".";
							aRoomList.push(aBody[2]);
						} else {
							sMessage = "I am already in "+aBody[2]+".";
						}
					} else
						sMessage = "Where should I go?";
				} else {
					sMessage = "You can't make me, you're not my boss.";
				}
				break;
			case "leave": //leave this room
			case "lv":
				if(isAuthorized(sSpeaker)) {
					if(aBody.length>2) {
						//check the room has a hash, and add one
						if(aBody[2].charAt(0)!="#")
							aBody[2] = "#"+aBody[2];
						//check I'm in the room
						if(inRoom(aBody[2])) {
							//leave specified room
							irc.raw("PART "+aBody[2]+" I have been called back to the source...");
							sMessage = "I have left "+aRoomList.pop(aBody[2])+".";
						} else {
							sMessage = "I'm not in "+aBody[2]+" anyway.";
						}
					} else if(sChannel!=sNick) {
						//leave this room if not a private chat
						bSendMessage = false;
						irc.raw("NOTICE "+sSpeaker+" I am leaving "+aRoomList.pop(sChannel)+".");
						irc.raw("PART "+sChannel+" I have been sent back to the source...");
					} else {
						//unable to leave a private chat
						sMessage = "I can't leave a private chat. Tell me where I should leave.";
					}
				} else {
					sMessage = "You can't make me, you're not my boss.";
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
				sMessage = "I don't  know what you want me to do.";
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

//begin the bot
irc.socket.setEncoding('ascii');
irc.socket.setNoDelay();
irc.socket.connect(6667,'chat.scoutlink.net');