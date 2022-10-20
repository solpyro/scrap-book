var fs = require('fs');

fs.readFile("example.html","utf8",function(err,data){
	if(err) throw err;
	data = data.split("\n").join("").split("\r").join("");
	//var sURLs = /(\<div\sid="navigation".*?\>)/.exec(data);
	//var sURLs = /(\<\/ul\>)/.exec(data);
	var aList = /\<div\sid="navigation".*?\>(.*?)(?=\<\/ul\>)/.exec(data);
	//console.log("instances: "+aURLs.length);
	//for(var i=0;i<aURLs.length;i++)
	//	console.log(sURLs[0]);
	//	console.log(sURLs.length);
	var aURLs = aList[0].match(/\<a\shref="(.*?)(?=")/g);
	for(var i=0;i<aURLs.length;i++) {
		aURLs[i] = aURLs[i].substring(16);
		console.log(aURLs[i]);
	}
	console.log(aURLs.length);
});
