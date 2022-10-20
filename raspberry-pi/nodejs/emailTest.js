var nm = require("nodemailer");

//global variables
var smtp = nm.createTransport("SMTP",{
	service:"Gmail",
	auth: {
		user: "solpyro@gmail.com",
		pass: "Deusex86"
	}
});

smtp.sendMail({
	from: "",
	to: "",
	subject: "",
	text: ""
}, function(err,resp){
	if(err){
		console.log("Problem sending mail: "+err);
	}
	//else mail is sent
});