var fs = require('fs');
var http = require('http');
var request = require('request');

//check if filename was supplied
if(process.argv.length<3) {
	console.log('This tool requires a list of addresses to follow.');
	console.log('Please execute this tool in this manner:');
	console.log('nodejs '+process.argv[1]+' [url] ([counter])');
	console.log('type -h for more help.');
	process.exit(1);
}
//check if help is invoked
if ((process.argv[2].toLowerCase()=="-h")||
	(process.argv[1].toLowerCase()=="/h")||
	(process.argv[1].toLowerCase()=="-?")||
	(process.argv[1].toLowerCase()=="/?")||
	(process.argv[1].toLowerCase()=="/help")||
	(process.argv[1].toLowerCase()=="-help")){
	console.log('To use this scraper, you need to have a URL for a chapter on kissmanga.');
	console.log('Start the scraper by invoking:');
	console.log('nodejs '+process.argv[1]+' [url]');
	console.log('You can add a second argument of a number to represent the chapter number for the given URL and the '+
		'chapter images will be saved in a folder with the counters name.');
	console.log('If there are more chapters after the URL supplied, these will automatically be downloaded to '+
		'incrementally named folders.');
	console.log('');
	console.log('Errors will be reported to the console, and added to the errors.txt file in this folder.');
	console.log('The error log will be overwritten every time the script is successfully run.');
	process.exit(1);
}

//variables
var sChapterURL = process.argv[2];

var wsError = fs.createWriteStream("errors.txt");

//var options = {
//	host: '', //we'll need to dig this out of the capturedURLs 
//	port: 80,
//	path: '' //we'll add the path for each line
//};
var nSetCounter = 0;
if ((process.argv.length>3)&&
	(!isNaN(parseInt(process.argv[3]))))
	nSetCounter = parseInt(process.argv[3]);
var nImageCounter = 0;
//var sData = "";
var aImages;
var sFormat = "";
var attempts = 0;
var maxAttempts = 2; //defines how many times an image download will be attempted

var sOutFolder = "";
var sOutFile = "";

//start the scraping process
beginScraping();

//routine to scrape an image set
function beginScraping() {
	console.log("Begin scraping set "+nSetCounter);
	//begin gallery retrival
	nImageCounter = 0;
	//clear local store
//	sData = "";
	//set path for gallery item
//	options.host = "kissmanga.com";
//	options.path = sChapterURL;
	console.log('Requesting list from '+sChapterURL);
	wsError.write('Requesting list from '+sChapterURL+"\n");
	//request webpage
	request({url:sChapterURL, encoding:'utf8'}, function(error, response, body) {
		//response.setEncoding("binary");
		if (!error && response.statusCode == 200) {
			console.log("body: "+body);
		} else {
			console.log("Error downloading "+sChapterURL+": "+error);
			wsError.write("Error downloading "+sChapterURL+": "+error+"\n");
			//continue to next image
			if(++attempts!=maxAttempts) {
				beginScraping();
			} else {
				console.log("Failed to download "+sChapterURL);
				wsError.write("Failed to download "+sChapterURL+"\n");
				process.exit(1);
			}
		}
	});
}
/*	http.get(options,function(resp) {
		resp.on('data',function(chunk) {
			//collect chunk
			sData += chunk;
		});
		resp.on('end', function() {
			//find image list 
			sData = sData.split("\n").join("").split("\r").join("");
			//check data exists
			if(sData != null && sData.length > 0) {
				console.log("sData "+sData);
				//attempt to find image list
				var aList = /var\slstImages\s=\snew\sArray\(\);(.*?)(?=var\scurrImage\s=\s0;)/.exec(sData);
//server keeps sending a 400 page :(
				if(aList != null && aList.length > 0) {
					//get image names
					aImages = aList[0].match(/lstImages\.push\("(.*?)(?="\);)/g);
					for(var i=0;i<aImages.length;i++)
						aImages[i] = aImages[i].substring(9);
					//create folder name
					sOutFolder = ''+nSetCounter;
					while(sOutFolder.length<3)
						sOutFolder = "0"+sOutFolder;
					//create set folder
					fs.mkdir(sOutFolder,0777);
					//start image retrival
					console.log('Downloading to '+sOutFolder);
					wsError.write('Downloading to '+sOutFolder+"\n");
					attempts = 0;
					//getImage(nImageCounter);
					console.log("here's where we'd grab the image");
					for(var i=0;i<aImages.length;i++)
						console.log(i+" "+aImages[i]);
				} else {
					if(++attempts==maxAttempts) {
						beginScraping();
					} else {
						console.log('Error recieving page '+sChapterURL+': Could not locate image list');
						wsError.write('Error recieving page '+sChapterURL+': Could not locate image list\n');
						process.exit(1);
					}
				}
			} else {
				if(++attempts!=maxAttempts) {
					beginScraping();
				} else {
					console.log('Error recieving page '+sChapterURL+': Page was empty');
					wsError.write('Error recieving page '+sChapterURL+': Page was empty\n');
					process.exit(1);
				}				
			}
		});
		//I don't know if I need this yet
		
	}).on('error', function(e) {
		//log error
		console.log('Error recieving page '+sChapterURL+': '+e.message);
		wsError.write('Error recieving page '+sChapterURL+': '+e.message+"\n");	
		process.exit(1);
	});
*/

//routine to request an image page and find the image name
function getImage(i) {
	//check if reached the end of the gallery
	if(i>=aImages.length) {
		//start on next line
		attempts = 0;
		beginScraping(++nSetCounter);
	} else {
		//get file details
		sFormat = aImages[i].substring(aImages[i].lastIndexOf("."));
		//get output filename
		sOutFile = ""+(nImageCounter+1);
		while(sOutFile.length<3)
			sOutFile = "0"+sOutFile;
		console.log("Requesting "+aImages[i]);
		//start request
		request({url:aImages[i], encoding:"binary"}, function(error, response, body) {
			//response.setEncoding("binary");
			if (!error && response.statusCode == 200) {
				console.log("File downloaded.");
				fs.writeFile(sOutFolder+"/"+sOutFile+sFormat, body, "binary", function(err) {
					if (err) {
						//throw err;
						console.log('Error writing image '+aImages[i]+': '+err.message);
						wsError.write('Error writing image '+aImages[i]+': '+err.message+"\n");
						if(++attempts!=maxAttempts) {
							getImage(nImageCounter);
						} else {
							//continue to next image
							attempts = 0;
							getImage(++nImageCounter);
						}						
					} else {
						console.log("File saved.");
						if(attempts>0) {
							console.log('File saved after '+(attempts+1)+' attempts.');
							wsError.write('File saved after '+(attempts+1)+' attempts.\n');
						}
						//continue to next image
						attempts = 0;
						getImage(++nImageCounter);
					}
				});
			} else {
				console.log("Error downloading "+sOutFile+" "+aImages[i]+": "+error);
				wsError.write("Error downloading "+sOutFile+" "+aImages[i]+": "+error+"\n");
				//continue to next image
				if(++attempts!=maxAttempts) {
					getImage(nImageCounter);
				} else {
					attempts = 0;
					getImage(++nImageCounter);
				}
			}
		});
	}
}
