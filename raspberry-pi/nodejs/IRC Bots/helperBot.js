var sys = require('util');
var stdin = process.openStdin();

var net = require('net');
var irc = {};

//Bot information
var sNick = "helper";
var aIgnoreList = ["StatServ","NickServ","ChanServ"];
var aAdminList = ["Solpyro"];
var aRoomList = [];

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
		//console.log('RECV -',data[i]);
		if(data[i]!='')
			irc.handle(data[i]);
	}
});

//IRC utilities
irc.raw = function(data) {
	irc.socket.write(data+'\r\n', 'ascii', function() {
		//console.log('SENT -', data);
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
//errors from 400 to 553
irc.on(/432(.+)$/i, function(info,data) {
	console.log('ERR -',data);
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
		//fake empty second argument
		if(aBody.length<2)
			aBody.push("");
		//interpret command
		switch(aBody[1].toLowerCase()) {
			case "help":
				if(isAuthorized(sSpeaker)) {
					irc.raw("NOTICE "+sSpeaker+" GOTO <#room> - make me join a chatroom");
					irc.raw("NOTICE "+sSpeaker+" LEAVE [<#room>] - make me leave a chatroom (If no room supplied, I'll leave here)");
					irc.raw("NOTICE "+sSpeaker+" APPOINT <nick> - add a new administrator");
					irc.raw("NOTICE "+sSpeaker+" RESCIND <nick> - remove an existing administrator");
					irc.raw("NOTICE "+sSpeaker+" LIST ADMIN|ROOMS  - lists the current admin or rooms");
					irc.raw("NOTICE "+sSpeaker+" QUIT - make me leave the server");
					bSendMessage = false;
					break;
				}
			case "":
			case "list"://list available commands
				irc.raw("NOTICE "+sSpeaker+" /join <#room> - add you to the room");
				irc.raw("NOTICE "+sSpeaker+" /leave <#room> - leave the room");
				irc.raw("NOTICE "+sSpeaker+" /me <action> - shows you performing the action");
				irc.raw("NOTICE "+sSpeaker+" /msg <nickname> - starts a private chat with someone");
				irc.raw("NOTICE "+sSpeaker+" /nick <nickname> - changes your nickname");
				irc.raw("NOTICE "+sSpeaker+" /notice <nickname> <message> - send a private message to someone in this room (like whispering)");
				irc.raw("NOTICE "+sSpeaker+" /list - lists the available rooms but be warned, there are lots!");
				irc.raw("NOTICE "+sSpeaker+" /whois <nickname> - tells you a little about the user");
				bSendMessage = false;
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
			case "appoint":
			case "add":
				if(isAuthorized(sSpeaker)) {
					if(aBody.length>2) {
						bSendMessage = false;
						aAdminList.push(aBody[2]);
						irc.raw("NOTICE "+sSpeaker+" I have added "+aBody[2]+" to my admin list.");
						irc.raw("PRIVMSG "+aBody[2]+" You are now my admin.");
					} else {
						irc.raw("NOTICE "+sSpeaker+" You didn't tell me who to appoint.");
					}
				} else {
					sMessage = "You can't make me, you're not my boss.";
				}
				break;
			case "rescind":
			case "drop":
				if(isAuthorized(sSpeaker)) {
					bSendMessage = false;
					if(aBody.length>2) {
						aAdminList.pop(aBody[2]);
						irc.raw("NOTICE "+sSpeaker+" I have removed "+aBody[2]+" from my admin list.");
						irc.raw("PRIVMSG "+aBody[2]+" You are no longer my admin.");
					} else {
						irc.raw("NOTICE "+sSpeaker+" You didn't tell me who's privileges to rescind.");
					}
				} else {
					sMessage = "You can't make me, you're not my boss.";
				}
				break;
			case "list":
				if(isAuthorized(sSpeaker)) {
					bSendMessage = false;
					if(aBody.length>2) {
						if ((aBody[2]=="admins")||
							(aBody[2]=="admin")||
							(aBody[2]=="ad")){
							var sLastAdmin = aAdminList.pop();
							var sFirstAdmin = aAdminList.join(", ");
							aAdminList.push(sLastAdmin);
							irc.raw("NOTICE "+sSpeaker+" My admin are "+sFirstAdmin + ((sFirstAdmin.length>0)?" and ":"") + sLastAdmin);
						} else if ((aBody[2]=="rooms")||
									(aBody[2]=="room")||
									(aBody[2]=="rm")){
							var sLastRoom = aRoomsList.pop();
							var sFirstRoom = aRoomsList.join(", ");
							aRoomsList.push(sLastRoom);
							irc.raw("NOTICE "+sSpeaker+" I am in "+sFirstRoom + ((sFirstRoom.length>0)?" and ":"") + sLastRoom);
						} else { 
							irc.raw("NOTICE "+sSpeaker+" You must specify either 'rooms' or 'admin' for me to list");
						}
					} else {
						irc.raw("NOTICE "+sSpeaker+" You must specify either 'rooms' or 'admin' for me to list");
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
				console.log(sSpeaker+" said: "+aBody.slice(2).join(" ");
				sMessage = "I don't know what you want me to do. Try typing '"+sNick+" help' for more commands.";
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
