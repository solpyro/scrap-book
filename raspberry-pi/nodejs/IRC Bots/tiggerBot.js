var sys = require('util');
var stdin = process.openStdin();

var net = require('net');
var irc = {};

//Bot information
var sNick = "tiggerBot";
var aIgnoreList = ["StatServ","NickServ","ChanServ"];
var aAdminList = ["Solpyro","Tigger"];
var aRoomList = [];

var chr1 = String.fromCharCode(1);

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
			irc.raw("QUIT I have to bounce home now.");
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
	irc.raw('JOIN #test');
	aRoomList.push("#test");
});
irc.on(/JOIN\s:(.+)/i, function(info,data) {
	var sJoiner = /:(.+)\!/i.exec(data)[1];
	if(sJoiner.toLowerCase()==sNick.toLowerCase())
		irc.raw("PRIVMSG "+info[1]+" Boing boing!");
	else 
		irc.raw("PRIVMSG "+info[1]+" :"+chr1+"ACTION bounds up to "+sJoiner+" and bounces on them playfully!"+chr1);
});
irc.on(/PRIVMSG(.+)$/i, function(info,data) {
	//early return
	if(data==null)return;
	
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
		if(aBody.length>1) {
			switch(aBody[1].toLowerCase()) {
				case "list"://list available commands
				case "help":
					irc.raw("NOTICE "+sSpeaker+" LIST - lists available commands");
					irc.raw("NOTICE "+sSpeaker+" BOUNCE [ON <nick>|ME] - make me boing! Add a nick and I'll bounce on them!");
					if(isAuthorized(sSpeaker)) {
						irc.raw("NOTICE "+sSpeaker+" GOTO <#room> - make me join a chatroom");
						irc.raw("NOTICE "+sSpeaker+" LEAVE [<#room>] - make me leave a chatroom (If no room supplied, I'll leave here)");
						irc.raw("NOTICE "+sSpeaker+" QUIT - make me leave the server");
					} else {
						sMessage = "If I'm being too bouncy, contact "+aAdminList.join(" or ")+"!";
					}
					break;
				case "bounce":
					bSendMessage = false;
					if(aBody.length>2) {
						if ((aBody[2].toLowerCase()=="me")||
							((aBody[2].toLowerCase()=="on")&&
							(aBody[2].toLowerCase()=="me"))) {					
							//boing on you
							irc.raw("PRIVMSG "+sChannel+" :"+chr1+"ACTION bounces on "+sSpeaker+"!"+chr1);
						} else if ((aBody[2].toLowerCase()==sNick.toLowerCase())||
							((aBody[2].toLowerCase()=="on")&&
							(aBody[2].toLowerCase()==sNick.toLowerCase()))) {
							//i can't bounce on myself!
							irc.raw("PRIVMSG "+sChannel+" I can't bounce on myself, silly!");
							irc.raw("PRIVMSG "+sChannel+" :"+chr1+"ACTION bounces on "+sSpeaker+" for being silly!"+chr1);
						} else {
							//bounce on person
							var sBouncee = aBody[2];
							if(aBody[2].toLowerCase()=="on")
								sBouncee = aBody[3];
							irc.raw("PRIVMSG "+sChannel+" :"+chr1+"ACTION bounds up to "+sBouncee+" and bounces on them playfully!"+chr1);
						}						
					} else {
						//just bounce
						irc.raw("PRIVMSG "+sChannel+" :"+chr1+"ACTION bounces!"+chr1);
						irc.raw("PRIVMSG "+sChannel+" Boing boing boing!");
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
								sMessage = "I have bounced into "+aBody[2]+".";
								aRoomList.push(aBody[2]);
							} else {
								sMessage = "I am already bouncing in "+aBody[2]+".";
							}
						} else
							sMessage = "Where should I bounce?";
					} else {
						sMessage = "I don't want to bounce over there.";
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
								irc.raw("PART "+aBody[2]+" Boing boing boing...");
								sMessage = "I have left "+aRoomList.pop(aBody[2])+".";
							} else {
								sMessage = "I'm not in "+aBody[2]+" anyway.";
							}
						} else if(sChannel!=sNick) {
							//leave this room if not a private chat
							bSendMessage = false;
							irc.raw("NOTICE "+sSpeaker+" I am bouncing out of "+aRoomList.pop(sChannel)+".");
							irc.raw("PART "+sChannel+" I'm off! Boing boing boing.");
						} else {
							//unable to leave a private chat
							sMessage = "I can't bounce away from a private chat. Tell me where I should bounce from.";
						}
					} else {
						sMessage = "You can't catch me, I can just bounce higher.";
					}
					break;
				case "quit":
				case "q":
					if(isAuthorized(sSpeaker)) {
						bSendMessage = false;
						irc.raw("QUIT I have to bounce home now.");
						process.exit(1);
					}
					break;
				default://unknown command
					sMessage = "I don't know what to do but bounce.";
			}
		} else {
			//someone said my name
			sMessage = "Hello "+sSpeaker+". How can I bounce for you?";
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
		if(aAdminList[i].toLowerCase()==nick.toLowerCase())
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