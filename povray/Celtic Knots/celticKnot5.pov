//--includes------------------------
//--declares------------------------ 

#declare counter = 0;

//--objects-------------------------

//knot
union {
//--brown
  sphere {
  }
//--blue
  sphere {
  }
//--light blue
  sphere {
  }
//--red
  #while (counter < 2)
    sphere {
    }
    #declare counter = counter + 1;
  #end
//--lights-------------------------- 
//--camera--------------------------  
