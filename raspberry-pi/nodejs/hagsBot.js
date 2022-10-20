var sys = require('util');
var stdin = process.openStdin();

var net = require('net');
var irc = {};

//Bot information
var sNick = "wally";
var sDefRoom = "#test";
var aIgnoreList = ["StatServ","NickServ","ChanServ"];
var aAdminList = ["Solpyro","Solpyro2"];

var sPartMessage = "I have been called back to the source...";
var sQuitMessage = "I have been called back to the source, to be decompiled...";
//A list of the rooms the bot is in
var aRoomList = [];
var aPlayers = [];
var aPlayerScores = [];
var aFoundList = [];

//listen for commands from the server console
stdin.addListener('data', function(d) {
	//convert d to a string and remove the trailing \n
	var sData = d.toString().substring(0,d.length-1);
	
	switch(sData) {
		case "help":
			console.log("This is an IRC bot, what help do you need?");
			console.log("Type 'quit' to stop the bot.");
			break;
		case "quit":
		case "exit":
			irc.raw("QUIT "+sQuitMessage);
			process.exit(1);
		default:
			console.log("Command ["+sData+"] not known.");
			console.log("Type 'help' for help.");
	}
});

//basic IRC communication
irc.socket = new net.Socket();
irc.socket.on('connect', function() {
	process.stdout.write('*** Connecting & registering... ');
	setTimeout(function() {
		irc.raw('NICK '+sNick);
		irc.raw('USER '+sNick+' * Node.js Hide&Seek Bot');
		process.stdout.write('done!\n');
	}, 1000); 
});
irc.socket.on('data', function(data) {
	data = data.split('\r\n');
	for(var i=0;i<data.length;i++) {
		if(data[i]!='')
			irc.handle(data[i]);
	}
});

//IRC utilities
irc.raw = function(data) {
	//console.log(data);
	irc.socket.write(data+'\r\n', 'ascii');
}
irc.handle = function(data){
	var i, info;
	var used = false;
	for(i=0;i<irc.listeners.length;i++) {
		info = irc.listeners[i][0].exec(data);
		if(info) {
			irc.listeners[i][1](info,data);
			if(irc.listeners[i][2]){
				irc.listeners.splice(i,1);
				i--;
			}
			used = true;
		}
	}
	//if(!used) console.log("UNHANDLED: "+data);
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
//logs bot onto #test after MOTD
irc.onOnce(/376(.+)$/i, function(info,data) {
	process.stdout.write('*** Joining default room: '+sDefRoom+'\n');
	//irc.raw('LIST');
	irc.raw('JOIN '+sDefRoom);
	//update list to include default room
	aRoomList.push(sDefRoom);
	aFoundList[sDefRoom] = new Array();
});
irc.on(/PRIVMSG(.+)$/i, function(info,data) {
	//find message target
	var sTarget = /\s+(.+?)\s/i.exec(info[1])[1];
	var sSpeaker = /:(.+?)!/i.exec(data)[1];
	if(ignore(sSpeaker))
		return;
	//check for orders
	var sBody = /:(.+?)$/i.exec(info[1])[1];
	var aBody = sBody.split(" ");
	//if target is the bot (private message) reply to person
	if(sTarget==sNick) {
		//change default target, so it's not me
		sTarget = sSpeaker
		//check for found you command
		if ((aBody.length>1) &&
			((aBody[0]+" "+aBody[1]).toLowerCase()=="found you")) {
			if(isPlaying(sSpeaker)) {
				//you cant find me in a private room, only in a channel
				irc.raw("NOTICE "+sSpeaker+" You cant find me in a private chat. Go look for me in a channel!");
			} else {
				//you need to be playing to find me
				//since the speaker isn't playing, the target doesn't matter
				found(sSpeaker);
			}
		}
	//else reply to room target
	} else {
		//check for commands that can only be given in a channel
		if ((aBody.length>1) &&
			((aBody[0]+" "+aBody[1]).toLowerCase()=="found you")) {
			found(sSpeaker,sTarget);
		}
	}
	//interpret direct order (can be given in a channel or pm)
	if (aBody[0].toLowerCase()==sNick.toLowerCase()) {
		//create variables
		var sMessage = "";
		var bSendMessage = true;
		//interpret command
		switch(aBody[1].toLowerCase()) {
			case "help"://reminds users of rules & lists commands
				irc.raw("NOTICE "+sSpeaker+" When playing Hide and Seek with me, you need to find e in different chat rooms.");
				irc.raw("NOTICE "+sSpeaker+" To find me, you need to say 'found you' in a room where I'm hiding.");
				irc.raw("NOTICE "+sSpeaker+" You get one point per room you find me in, so you'll have to look around.");
				irc.raw("NOTICE "+sSpeaker+" While you're in a room, why not try talking to other people as well.");
			case "list"://list available commands
				irc.raw("NOTICE "+sSpeaker+" LIST - lists available commands");
				irc.raw("NOTICE "+sSpeaker+" HELP - reminds you how to play");
				irc.raw("NOTICE "+sSpeaker+" PLAY - begin playing with me");
				irc.raw("NOTICE "+sSpeaker+" SCORE [<nick>] - Tells you the score of the named person, or your score if no nick provided.");
				//irc.raw("NOTICE "+sSpeaker+" STOP - stop playing with me");
				if(isAuthorized(sSpeaker)) {
					irc.raw("NOTICE "+sSpeaker+" GOTO <#room> - make me join a chatroom");
					irc.raw("NOTICE "+sSpeaker+" LEAVE [<#room>] - make me leave a chatroom (If no room supplied, I'll leave here)");
					irc.raw("NOTICE "+sSpeaker+" QUIT - make me leave the server");
				}
				irc.raw("NOTICE "+sSpeaker+" If I'm misbehaving please notify Solpyro");
				bSendMessage = false;
				break;
			case "play": //start playing with a new player
				//check if the user is already playing
				if(!isPlaying(sSpeaker)) {
					//update lists
					aPlayers.push(sSpeaker);
					aPlayerScores[sSpeaker] = 0;
					//notify the user they are now playing
					irc.raw("NOTICE "+sSpeaker+" You are now playing Hide and Seek with me!");
					irc.raw("NOTICE "+sSpeaker+" When you see me in a chat room say 'found you' and I'll log your score.");
					irc.raw("NOTICE "+sSpeaker+" I'm currently in "+aRoomList.length+" chat room"+((aRoomList.length==1)?"":"s")+", but that can change.");
					//check if we're in a channel
					if(sSpeaker!=sTarget) {
						//give them this point
						aFoundList[sTarget].push(sSpeaker);
						aPlayerScores[sSpeaker]++;
						irc.raw("NOTICE "+sSpeaker+" I guess you've found me in this room!");
						irc.raw("NOTICE "+sSpeaker+" You're score is now "+aPlayerScores[sSpeaker]+".");
					}
					bSendMessage = false;
				} else {
					//user is already playing
					message = "You're already playing, silly!";
				}
				break;
			case "score": //return the score of a user
				if(aBody.length>2) { //return score of specific player
					if(isPlaying(aBody[2])) sMessage = aBody[2]+"'s score is "+aPlayerScores[aBody[2]]+".";
					else sMessage = aBody[2]+" isn't playing yet. Why not invite them to join in?";
				} else { //return score of speaker
					if(isPlaying(sSpeaker)) sMessage = "Your score is "+aPlayerScores[sSpeaker]+".";
					else sMessage = "You aren't playing yet. Try typing '"+sNick+" help'.";
				}
				break;
			case "found":
				if(sSpeaker!=sTarget) {
					found(sSpeaker,sTarget);
					bSendMessage = false;
				} else
					sMessage = "You cant find me in a private chat. Go look for me in a channel!";
				break;
			case "stop":
				irc.raw("NOTICE "+sSpeaker+" You can't stop playing yet!");
				break;
			case "goto"://connect to a new chat room UPDATE TO KEEP LISTS UP TO DATE
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
							aFoundList[aBody[2]] = new Array();
						} else {
							sMessage = "I am already in "+aBody[2]+".";
						}
					} else
						sMessage = "Where should I go?";
				} else {
					sMessage = "You can't make me, you're not my boss.";
				}
				break;
			case "leave": //leave this room UPDATE TO KEEP LISTS UP TO DATE
			case "lv":
				if(isAuthorized(sSpeaker)) {
					bSendMessage = false;
					if(aBody.length>2) {
						//check the room has a hash, and add one
						if(aBody[2].charAt(0)!="#")
							aBody[2] = "#"+aBody[2];
						//check I'm in the room
						if(inRoom(aBody[2])) {
							//leave specified room
							irc.raw("PART "+aBody[2]+" "+sPartMessage);
							aRoomList.pop(aBody[2])
						} else {
							sMessage = "I'm not in "+aBody[2]+" anyway.";
						}
					} else if(sTarget!=sNick) {
						//leave this room if not a private chat
						irc.raw("PART "+sTarget+" "+sPartMessage);
					} else {
						//unable to leave a private chat
						sMessage = "I can't leave a private chat. Tell me where I should leave.";
						bSendMessage = true;
					}
				} else {
					sMessage = "You can't make me, you're not my boss.";
				}
				break;
			case "quit": //grasefully exit IRC server
			case "q":
				if(isAuthorized(sSpeaker)) {
					bSendMessage = false;
					irc.raw("QUIT "+sQuitMessage);
					process.exit(1);
				}
				break;
			default://unknown command
				sMessage = "I don't know what you want me to do. Try typing '"+sNick+" help'.";
		}
		//send final message
		if(bSendMessage) irc.raw("NOTICE "+sSpeaker+" "+sMessage);
	}/* else {
		//return default response - we should turn this off later...
		//this needs to send a string PRIVMSG <target> <message>
		//target can be foind from the original message, as the first word after PRIVMSG
		irc.raw("PRIVMSG "+sTarget+" Don't talk to me, I'm thinking");
	}*/
});

//hags functions
function found(sSpeaker,sTarget) {
	//check the user is playing
	if(isPlaying(sSpeaker)) {
		//check they haven't found you here yet
		if (!foundInRoom(sSpeaker,sTarget)) {
			//add a score
			irc.raw("NOTICE "+sSpeaker+" You found me!");
			aFoundList[sTarget].push(sSpeaker);
			aPlayerScores[sSpeaker]++;
			irc.raw("NOTICE "+sSpeaker+" You're score is now "+aPlayerScores[sSpeaker]+".");
			if(aPlayerScores[sSpeaker]==aRoomList.length)
				irc.raw("NOTICE "+sSpeaker+" You've found me everywhere now. Keep an eye out though, I might move somewhere new later.");
			else
				irc.raw("NOTICE "+sSpeaker+" Go look for me somewhere else now.");
		} else {
			//else notice: you've already found me
			irc.raw("NOTICE "+sSpeaker+" You've already found me here. Look for me somewhere else.");
			irc.raw("NOTICE "+sSpeaker+" You're current score is "+aPlayerScores[sSpeaker]+".");
		}
	} else {
		//else pm: are you trying to play with me?, rules
		irc.raw("PRIVMSG "+sSpeaker+" Are you trying to play Hide and Seek with me?");
		irc.raw("PRIVMSG "+sSpeaker+" To find me, you need to say 'found you' in a room where I'm hiding.");
		irc.raw("PRIVMSG "+sSpeaker+" You get one point per room you find me in, so you'll have to look around.");
		irc.raw("PRIVMSG "+sSpeaker+" While you're in a room, why not try talking to other people as well.");
		irc.raw("PRIVMSG "+sSpeaker+" If you want to play, say '"+sNick+" play'.");
	}
}

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
function isPlaying(nick) {
	for(var i=0;i<aPlayers.length;i++) {
		if(aPlayers[i]==nick) {
			return true;
		}
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
function foundInRoom(nick,room) {
	for(var i=0;i<aFoundList[room].length;i++) {
		if(aFoundList[room][i]==nick)
			return true;
	}
	return false;
}

//begin the bot
irc.socket.setEncoding('ascii');
irc.socket.setNoDelay();
irc.socket.connect(6667,'chat.scoutlink.net');
