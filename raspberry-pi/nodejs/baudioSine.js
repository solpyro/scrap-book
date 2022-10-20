var baudio = require('baudio');

var b = baudio(function (t) {
    var x = Math.sin(t * Math.PI * 400);
    return x;
});
b.play();