var fs = require('fs');
var http = require('http');

var options = {
	host: 'www.solpyro.co.uk',
	port: 80,
	path: ''
};
var localStore = "";

http.get(options,function(resp) {
	resp.on('data',function(chunk) {
		localStore += chunk;
		console.log("BODY: "+chunk);
		console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); 
	});
	resp.on('end',function() {
		console.log("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
		console.log(localStore);
		fs.writeFile("example.html", localStore, "utf8", function(err) {
			if (err) throw err;
			console.log("File saved.");
		});
		console.log("File written");
	});
}).on('error', function(e) {
	console.log("Got error: "+e.message);
});
