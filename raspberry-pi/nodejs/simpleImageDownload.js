var fs = require('fs');
var http = require('http');
var request = require('request');

request('http://www.solpyro.co.uk/images/banner.jpg').pipe(fs.createWriteStream('banner.jpg'));

/*
var options = {
	host: 'www.solpyro.co.uk',
	port: 80,
	path: '/images/banner.jpg'
};

http.get(options,function(resp) {
	var imageData = "";
	resp.setEncoding("binary");
	resp.on('data',function(chunk) {
		//wsFile.write(chunk);
		imageData += chunk;
		console.log("Chunk recieved...");
	});
	resp.on('end',function() {
		fs.writeFile("test.jpg", imageData, "binary", function(err) {
			if (err) throw err;
			console.log("File saved.");
		});
		console.log("File written");
	});
}).on('error', function(e) {
	console.log("Got error: "+e.message);
});
*/
