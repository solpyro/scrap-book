var fs = require("fs");
var nm = require("nodemailer");
var path = require("path");

//global variables
var sFilename = "schedule.rem";
var aItems;
var nDate = 0, nTitle = 1, nText = 2;
var stdin = process.openStdin();
var smtp = nm.createTransport("SMTP",{
	service:"Gmail",
	auth: {
		user: "solpyro@gmail.com",
		pass: "Deusex86"
	}
});
var sSeperator = "||";


/////////////////////////
//  General Functions  //
/////////////////////////
function getAllItems() {
	path.exists(sFilename,function(bExists) {
		if(bExists) {
			fs.readFile(sFilename,"utf8",function(err,data) {
				//early return on error
				if(err) {
					console.log("Could not read file: "+err);
					process.exit(1);
				}
				
				//inflate items into array
				aItems = data.split(/\r?\n/);
				for(var i=0;i<aItems.length;i++)
					aItems[i] = aItems[i].split(sSeperator);
				
				//check application mode	
				if(process.argv.length>2) {
					//organise todo list and email priorities
					sortForEmail();
				} else {
					//setup input listener
					stdin.addListener("data",userInput);
					//show initial menu
					showMainMenu();
				}
			});
		} else {
			aItems = []; 
			//check application mode	
			if(process.argv.length>2) {
				//organise todo list and email priorities
				sortForEmail();
			} else {
				//setup input listener
				stdin.addListener("data",userInput);
				//show initial menu
				showMainMenu();
			}
		}
	});
}

///////////////////////
//  Email Functions  //
///////////////////////
function sortForEmail() {
	//create lists
	var aOverdue = [];
	var aDue = [];
	var aRemaining = [];
	
	//populate lists
	var oDate = new Date();
	var nToday = (oDate.getFullYear()*10000)+((oDate.getMonth()+1)*100)+oDate.getDate();
	
	console.log("Dates are being misassigned");
	console.log("aItems[i][nDate] appears to be undefined");
	console.log("nToday: "+nToday);
	
	for(var i=0;i<aItems.length;i++) {
		var nDate = parseInt(aItems[i][nDate],10);
		
		console.log(nDate+"<"+nToday+": "+(nDate<nToday));
		
		if(nDate<nToday)
			aOverdue.push(aItems[i]);
		else if(nDate<nToday)
			aRemaining.push(aItems[i]);
		else
			aDue.push(aItems[i]);
	}
	
	//sort items
	aOverdue.sort();
	aDue.sort();
	aRemaining.sort();
	
	var sBody = "";
	//add overdue items
	if(aOverdue.length>0) {
		sBody += "Overdue Items\r\n\r\n";
		for(var i=0;i<aOverdue.length;i++) {
			sBody += aOverdue[i][nDate]+" - "+aOverdue[i][nTitle]+"\r\n";
			sBody += aOverdue[i][nText]+"\r\n\r\n";
		}
	}
	//add due items
	if(aDue.length>0) {
		sBody += "Items Due Today\r\n\r\n";
		for(var i=0;i<aDue.length;i++) {
			sBody += aDue[i][nDate]+" - "+aDue[i][nTitle]+"\r\n";
			sBody += aDue[i][nText]+"\r\n\r\n";
		}
	}
	//add remaining items
	if(aRemaining.length>0) {
		sBody += "Pending Items\r\n\r\n";
		for(var i=0;i<aRemaining.length;i++) {
			sBody += aRemaining[i][nDate]+" - "+aRemaining[i][nTitle]+"\r\n";
			sBody += aRemaining[i][nText]+"\r\n\r\n";
		}
	}
	//check if body is empty
	if(sBody == "") {
		//remind the user to disable the crontask or add some todo items
		sBody += "We just tried to build your task list, but you don't appear to have anything in there.\r\n";
		sBody += "Consider removing the crontask or adding some todo items.";
	} else {
		//temind the user where this email is from
		sBody += "To stop recieving these emails, remove the crontab item relating to the reminders app.";
	}
	
	//send email
	smtp.sendMail({
		from: "reminders@pi.co.uk",
		to: "solpyro@gmail.com",
		subject: "To Do List",
		text: sBody
	}, function(err,resp) {
		if(err) {
			console.log("Problem sending mail: "+err);
		}
		//else mail is sent
		process.exit(0);
	});
}

////////////////////////////
//  Management Functions  //
////////////////////////////
var pItem = 0;
var fMenu = false;
var fNewTitle = false;
var fNewText = false;
var fNewDate = false;
var fItemMenu = false;
var fEditTitle = false;
var fEditDate = false;
var fEditText = false;

function setInputFlag(flag) {
	//set all flags to false
	fMenu = false;
	fNewTitle = false;
	fNewText = false;
	fNewDate = false;
	fItemMenu = false;
	fEditTitle = false;
	fEditDate = false;
	fEditText = false;
	
	//set specified flag to true
	switch(flag) {
		case "menu":
			fMenu = true;
			break;
		case "newTitle":
			fNewTitle = true;
			break;
		case "newText":
			fNewText = true;
			break;
		case "newDate":
			fNewDate = true;
			break;
		case "itemMenu":
			fItemMenu = true;
			break;
		case "editTitle":
			fEditTitle = true;
			break;
		case "editDate":
			fEditDate = true;
			break;
		case "editText":
			fEditText = true;
			break;
		default:
			console.log("Flag <"+flag+"> does not exist.");
	}
}

function userInput(data) {
	//prepare data string
	sData = data.toString().substring(0,data.length-1);
	//quit on q & quit
	if(sData.toLowerCase()=="q"||sData.toLowerCase()=="quit") {
		//serialise the array
		var sFileText = "";
		for(var i=0;i<aItems.length;i++) {
			sFileText += aItems[i].join(sSeperator);
		}
		fs.writeFileSync(sFilename,sFileText);
		//quit the program
		process.exit(0);
	}
	//send line to flagged function
	if(fMenu) menuResponse(sData);
	else if(fNewTitle) newTitleResponse(sData);
	else if(fNewText) newTextResponse(sData);
	else if(fNewDate) newDateResponse(sData);
	else if(fItemMenu) itemMenuResponse(sData);
	else if(fEditTitle) editTitle(sData);
	else if(fEditDate) editDate(sData);
	else if(fEditText) editText(sData);
}

function showMainMenu() {
	//show all menu items
	console.log("Item List");
	console.log("---------");
	console.log(" 0 New Item");
	for(var i=0;i<aItems.length;i++) {
		var nCount = i+1;
		console.log(((nCount<10)?" ":"")+nCount+" "+aItems[i][nTitle]);
	}
	console.log("");
	console.log("Please enter a number");
	setInputFlag("menu");
}
function menuResponse(sData) {
	if(sData=="0") {
		//create a new item
		pItem = aItems.length;
		aItems.push([]);
		//request item title
		console.log("Please enter a title for the item");
		setInputFlag("newTitle");
	} else {
		//edit selected item
		pItem = parseInt(sData,10)-1;
		//check item is in range
		if(pItem<aItems.length)
			editItem();
		else
			console.log("Command not recognised. Please try again");
	}
}
function newTitleResponse(sData) {
	if(sData!="") {
		//set title
		aItems[pItem][nTitle] = sData;
		//request item text
		console.log("Please enter text, or leave blank");
		setInputFlag("newText");
	} else {
		console.log("A title is required, please enter one");
	}
}
function newTextResponse(sData) {
	//set text
	aItems[pItem][nText] = sData;
	//request date
	console.log("Please enter a date, in YYYYMMDD format");
	setInputFlag("newDate");
}
function newDateResponse(sData) {
	if(isNumeric(sData)&&sData.length==8) {
		//set date
		aItems[pItem][nDate] = sData;
		showMainMenu();
	} else {
		console.log("This is not a date of YYYYMMDD format, please enter one");
	}
}
function editItem() {
	console.log(aItems[pItem][nDate]+" - "+aItems[pItem][nTitle]);
	if(aItems[pItem][nText]!="") console.log(aItems[pItem][nText]);
	console.log("");
	console.log("Item Options");
	console.log("------------");
	console.log("0 Delete Item");
	console.log("1 Edit Title");
	console.log("2 Edit Date");
	console.log("3 Edit Text");
	console.log("4 Return to Main Menu");
	setInputFlag("itemMenu");
}
function itemMenuResponse(sData) {
	switch(sData) {
		//1 - title
		case "1":
			console.log("Current title: "+aItems[pItem][nTitle]);
			console.log("Please enter a new title");
			setInputFlag("editTitle");
			break;
		//2 - date
		case "2":
			console.log("Current date: "+aItems[pItem][nDate]);
			console.log("Please enter a new date");
			setInputFlag("editDate");
			break;
		//3 - text
		case "3":
			console.log("Current text: "+aItems[pItem][nText]);
			console.log("Please enter some text");
			setInputFlag("editText");
			break;
		//0 - delete
		case "0":
			aItems.splice(pItem,1);
		//4 - return
		case "4":
			showMainMenu();
			break;
		//unknown command
		default:
			console.log("Unknown command. Please enter again");			
	}
}
function editTitle(sData) {
	if(sData!=0) {
		//set title
		aItems[pItem][nTitle] = sData;
		//display current item
		editItem();
	} else {
		console.log("A title is required, please enter one");
	}
}
function editDate(sData) {
	if(isNumeric(sData)&&sData.length==8) {
		//set date
		aItems[pItem][nDate] = sData;
		//display current item
		editItem();
	} else {
		console.log("This is not a date of YYYYMMDD format, please enter one");
	}
}
function editText(sData) {
	//set text
	aItems[pItem][nText] = sData;
	//display current item
	editItem();
}

/////////////////
//  Utilities  //
/////////////////
function isNumeric(sNumber) {
	return !isNaN(parseInt(sNumber,10)) && isFinite(sNumber);
}

/////////////////////
//  Start Process  //
/////////////////////
getAllItems();