//require simple io for reporting
var fs = require('fs');
var wsError = fs.createWriteStream("log.txt");

//Original words from:
//Nouns - http://englishgenie.com/vocabulary/the-top-100-most-common-nouns/
//Adjectives - http://englishgenie.com/vocabulary/the-top-100-most-common-adjectives/
//Vervs - http://englishgenie.com/vocabulary/the-top-100-most-common-verbs/
//Adverbs - http://englishgenie.com/vocabulary/the-top-100-most-common-adverbs/
//Determiners - http://www.phon.ucl.ac.uk/home/dick/enc2010/articles/determiner.htm
//Prepositions - http://www.englishclub.com/vocabulary/common-prepositions-25.htm
//				 http://grammar.ccc.commnet.edu/grammar/preposition_list.htm
//Conjunctions - http://www.englishclub.com/vocabulary/common-conjunctions-25.htm
//				 http://www.esldesk.com/vocabulary/conjunctions


//define database
process.stdout.write("NLParser: Bulding Noun array... ");
var aNoun = ["time","year","people","way","day","man","thing","woman","life","child","world","school","state","family",
			"student","group","country","problem","hand","part","place","case","week","company","system","program",
			"question","work","government","number","night","point","home","water","room","mother","area","money",
			"story","fact","month","lot","right","study","book","eye","job","word","business","issue","side","kind",
			"head","house","service","friend","father","power","hour","game","line","end","member","law","car","city",
			"community","name","president","team","minute","idea","kid","body","information","back","parent","face",
			"others","level","office","door","health","person","art","war","history","party","result","change",
			"morning","reason","research","girl","guy","moment","air","teacher","force","education"];
process.stdout.write("done!\n");
process.stdout.write("NLParser: Bulding Adjective array... ");
var aAdj  = ["other","new","good","high","old","great","big","American","small","large","national","young","different",
			"black","long","little","important","political","bad","white","real","best","right","social","only",
			"public","sure","low","early","able","human","local","late","hard","major","better","economic","strong",
			"possible","whole","free","military","true","federal","international","full","special","easy","clear",
			"recent","certain","personal","open","red","difficult","available","likely","short","single","medical",
			"current","wrong","private","past","foreign","fine","common","poor","natural","significant","similar","hot",
			"dead","central","happy","serious","ready","simple","left","physical","general","environmental","financial",
			"blue","democratic","dark","various","entire","close","legal","religious","cold","final","main","green",
			"nice","huge","popular","traditional","cultural"];
process.stdout.write("done!\n");
process.stdout.write("NLParser: Bulding Verb array... ");
var aVerb = ["be","have","do","say","go","can","get","would","make","know","will","think","take","see","come","could",
			"want","look","use","find","give","tell","work","may","should","call","try","ask","need","feel","become",
			"leave","put","mean","keep","let","begin","seem","help","talk","turn","start","might","show","hear","play",
			"run","move","like","live","believe","hold","bring","happen","must","write","provide","sit","stand","lose",
			"pay","meet","include","continue","set","learn","change","lead","understand","watch","follow","stop",
			"create","speak","read","allow","add","spend","grow","open","walk","win","offer","remember","love",
			"consider","appear","buy","wait","serve","die","send","expect","build","stay","fall","cut","reach","kill",
			"remain"];
process.stdout.write("done!\n");
process.stdout.write("NLParser: Bulding Adverb array... ");
var aAdv  = ["up","so","out","just","now","how","then","more","also","here","well","only","very","even","back","there",
			"down","still","in","as","to","when","never","really","most","on","why","about","over","again","where",
			"right","off","always","today","all","far","long","away","yet","often","ever","however","almost","later",
			"much","once","least","ago","together","around","already","enough","both","maybe","actually","probably",
			"home","of course","perhaps","little","else","sometimes","finally","less","better","early","especially",
			"either","quite","simply","nearly","soon","certainly","quickly","no","recently","before","usually","thus",
			"exactly","hard","particularly","pretty","forward","ok","clearly","indeed","rather","that","tonight",
			"close","suddenly","best","instead","ahead","fast","alone","eventually","directly"];
process.stdout.write("done!\n");
process.stdout.write("NLParser: Bulding Determiner array... ");
var aDet  = ["the","this","that","these","those","you","us","whose","his","its","my","your","our","her","their","mine",
			"yours","ours","hers","theirs","a","an","some","any","no","none","either","neither","every","which",
			"what"];//How do I handle "'s"?
process.stdout.write("done!\n");
process.stdout.write("NLParser: Bulding Preposition array... ");
var aPrep = ["about","above","across","after","against","among","around","as","at","before","behind","below","beneath",
			"beside","besides","between","beyond","by","down","during","except","for","from","in","inside","into",
			"like","near","of","off","on","out","outside","over","since","through","throughout","till","to","toward",
			"under","until","up","upon","with","without"];
process.stdout.write("done!\n");
process.stdout.write("NLParser: Bulding Conjunction array... ");
var aConj = ["and","that","but","or","as","if","when","than","because","while","where","after","so","though","since",
			"until","whether","before","although","nor","like","once","unless","now","except","both","either","for",
			"how","however","if","neither","only","provided","rather","till","whenever","whereas","wherever","yet"];
process.stdout.write("done!\n");

//define sentance parser
exports.parseSentance = function(sSentance) {
	//split sentance into word tokens
	var aWords = sSentance.split(" ");
	//create infomation object
	var oInfo = new Object();
	//begin parsing
	startParse(aWords,oInfo);
	//return sentance interpretation
	return oInfo;
}
function startParse(aWords,oInfo) {
	for(var i=0;i<aWords.length;i++) {
		parseWord(aWords[i]);
	}
}