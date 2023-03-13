const _w = 2931/2;
const _h = 2046/2;
const _s = 0.75;

$(window).on("load", function() {
    $(".draggable").draggable();

    onResize();
    scatterPieces();
    
    $(window).resize(onResize);

    console.log("If you're bored, or stuck, the answer is at /puzzle.jpg");
});

function onResize() {
    //clear any existing scaling
    $(".draggable").each((i,e)=> {
        $(e).css({
            "width":"auto",
            "height":"auto"
        });
    });
    
    //apply a scale to the pieces
    var r = Math.min($(window).width()*_s/_w,$(window).height()*_s/_h);
  
    if(r < 1) {
        //set scaling
        $(".draggable").each((i,e)=> {
            $(e).css({
                "width":$(e).width()*r,
                "height":$(e).height()*r
            });
        });
    }

    //check each piece is on screen, or move it onscreen
    var W = $(window).width();
    var H = $(window).height();
    $(".draggable").each((i,e)=> {
        var w = $(e).width();
        var h = $(e).height();
        var o = $(e).offset();
        
        if(W<o.left+w)
            $(e).css("left", W-(w+_p));
        
        if(H<o.top+h)
            $(e).css("top", H-(h+_p));
    });
}

function scatterPieces() {
    //put each piece in a random place onscreen
    var W = $(window).width();
    var H = $(window).height();
    
    $(".draggable").each((i,e)=> {
        var w = $(e).width();
        var h = $(e).height();
        
        $(e).css({
            "top": (H-h)*Math.random(),
            "left": (W-w)*Math.random()
        })
    });
}