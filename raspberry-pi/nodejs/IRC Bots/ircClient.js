var net = require('net');

exports.newClient = function(sNick,sServer,nSocket,fonConnected) {
	//basic IRC communication
	var irc = {};
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

	//useful IRC commands
	irc.privmsg = function(sTarget,sMessage) {
		if(sTarget!=undefined && sTarget!=null && sTarget!="")
			if(sMessage!=undefined && sMessage!=null && sMessage!="")
				irc.raw("PRIVMSG "+sTarget+" "+sMessage);
	}
	irc.notice = function(sTarget,sMessage) {
		if(sTarget!=undefined && sTarget!=null && sTarget!="")
			if(sMessage!=undefined && sMessage!=null && sMessage!="")
				irc.raw("NOTICE "+sTarget+" "+sMessage);
	}
	irc.join = function(sChannel) {
		if(sChannel!=undefined && sChannel!=null)
			irc.raw("JOIN "+sChannel);
	}
	irc.part = function(sChannel,sMessage) {
		if(sChannel!=undefined && sChannel!=null) {
			if(sMessage==undefined || sMessage==null)
				sMessage = "";
			else
				sMessage = " "+sMessage;
			
			irc.raw("PART "+sChannel+sMessage);
		}
	}
	irc.quit = function(sMessage) {
		if(sMessage == undefined || sMessage == null)
			sMessage = "";
		else
			sMessage = " "+sMessage;
			
		irc.raw("QUIT"+sMessage);
	}
	irc.connect = function(sServer,nSocket,fCallback) {
		if(nSocket==null || nSocket==undefined)
			nSocket = 6667;
		
		if(fCallback!==null && fCallback!=undefined)
			irc.onConnected = fCallback;
		
		irc.socket.connect(nSocket,sServer);
	}
	
	//Stops timeout by responding to PING
	irc.on(/^PING :(.+)$/i, function(info) {
		irc.raw('PONG :'+info[1]);
	});
	//server has responded with MOTD
	irc.onOnce(/376(.+)$/i, function(info,data) {
		if(irc.onConnected!=null&&irc.onConnected!=undefined)
			irc.onConnected();
	});
	irc.onConnected = fonConnected;
	
	//begin the bot
	irc.socket.setEncoding('ascii');
	irc.socket.setNoDelay();
	if(sServer!=null && sServer!=undefined && sServer!="")
		irc.connect(sServer,nSocket);
	
	//return the bot
	return irc;
}