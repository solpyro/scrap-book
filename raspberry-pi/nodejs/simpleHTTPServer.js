var http = require('http');

console.log('Press ^z to suspend and ^c to close the server');	
console.log('After suspending, type fg to resume or bg to resume in the background');

var server = http.createServer(function(req,res){
	var currentTime = new Date();
	console.log('***Client called at '+currentTime);
	//for(a in req.headers)
	//	console.log(a+" => "+req.headers[a]);

	res.writeHead(200,{'Content-Type':'text/plain'});
	res.write('You have found my Pi!');
	res.end();
}).listen('8124');
