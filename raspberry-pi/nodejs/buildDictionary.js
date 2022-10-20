var fs  = require("fs");

var oData = {};
var sOut = "";

fs.readFile("dictionary.txt","utf8",function(err,data){
	if(err) throw err;
	
	//splid data into an array
	var aData = data.split("\n").join("").split("\r");
	
	//create buckets
	while(aData.length>0) {
		var sWord = aData.pop();
		var nLength = sWord.length;
		
		if(oData["len_"+nLength]==undefined) {
			oData["len_"+nLength] = new Array();
		}
		
		oData["len_"+nLength].push(sWord);
	}
	
	//order word lists
	//for(var a in oData) {
		
	//}
	
	//build file string
	sOut = "<dictionary>";
	for(a in oData) {
		var sLength = a.substr(a.lastIndexOf("_"));
		sOut += "<words length='"+sLength+"'>";
		for(var i=0;i<oData[a].length;i++) {
			sOut += "<word value='"+oData[a][i]+"' />";
		}
		sOut += "</words>";
	}
	sOut += "</dictionary>";
	
	//write word list
	fs.writeFile("dictionary.xml", sOut, function(err) {
		if (err) throw err;
	});
});
