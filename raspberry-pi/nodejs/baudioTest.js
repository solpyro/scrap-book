var baudio = require('baudio');
var b = baudio();
/*
b.push((function(){
	var freqs = [
		0, 0, 1600, 1600,
		0, 0, 2000, 2000,
		0, 1400, 0, 1400,
		0, 1600, 0, 1800
	];
	function mutate() {
		var xs = freqs.slice();
		var ix = Math.floor(Math.random() * xs.length);

		xs[ix] = Math.max(0, xs[ix]+((Math.floor(Math.random()*2)-1)*2+1)*400);
		return xs;
	}
	
	var loop = 0;
	
	return function(t) {
		var n = Math.floor((t*4)/freqs.length);
		if(loop!==n) {
			loop = n;
			if(loop===Number(process.argv[2])) return b.end();
			freqs = mutate(freqs);

			console.error('iteration '+loop);
			console.error('  '+JSON.stringify(freqs));
		}

		var f = freqs[Math.floor((t*4)%freqs.length)];
		return Math.sin(t*Math.PI*f);
	}
})());

b.push(function(t, i){
	var f = 800*Math.pow(2,Math.floor(t*4%4)/6);
	return Math.sin(t*f*Math.PI)
		* Math.pow(Math.sin(t*8*Math.PI),2);
}); 

b.push((function(){
	var n=0;
	return function(t,i) {
		if(i%10===0)n=Math.random();

		return t*2%1/16 < 1/256
			|| (t*2/32)%1/16 < 1/256
			|| (t*2/32)%1/16 < 1/256
			? n : 0;
	};
})());

b.record("test.txt");
if(!process.stdout.isTTY)b.pipe(process.stdout);
*/

//SINE TEST
var n=0;
var j=1;
b.push(function(t,i){
	n += t;
	if(n>=j) {
		console.log(n+" seconds");
		j++;
		if(j==11) {
			console.log("end sound");
			process.exit(1);
		}
	}
	return Math.sin(440*n*360*(180/Math.PI));//440Hz A above middle C
});
b.record({"t":"alsa"});
