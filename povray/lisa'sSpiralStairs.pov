//--includes------------------------
//--declares------------------------ 

#declare counter = 0;

//--objects-------------------------
 
//floor
plane {
  y, 0
  pigment {
    colour rgb <.6, .6, .6>
  }
}
//back wall
plane {
  z, 14
  pigment {
    colour rgb <.6, 0, 0>
  }
}                 
//celing
plane {
  y, 10
  pigment {
    colour rgb <0, 0, 0>
  }
}
//staircase 
union {
//--spine
  cylinder {
    <0, 0, 0>, <0, 10, 0>, .5
    pigment {
      colour rgb <.6, .6, .6>
    }
  }
//--steps   
  #while (counter < 20)
    prism {                                
      linear_sweep  
      linear_spline
      0+(counter/2),        
      .4+(counter/2),         
      3,           
      < 0, 0>, <-2, 0>, <-1.414, 1.414> 
      pigment {
        colour rgb <.6, .6, .6>
      }
      rotate <0, counter*45, 0>
    }
    #declare counter = counter + 1;
  #end
}
//picture
union {
//--frame 
  box {
    <-2, -1.3, 0>, <2, 1.3, 0>
    pigment {
      colour rgb <.8, .2, 0>
    }
  }
//--picture
  box {       
    <-1.7, -1, 0>, <1.7, 1, 0>
    pigment {
      image_map {
        gif "picture.gif"
      }
    }
  }
  translate <-10, 5, 13.99>
}
        

//--lights-------------------------- 

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 9, -20>
}

//--camera--------------------------  
  
// perspective (default) camera
camera {
  location  <0, 7, -15>
  look_at   <0, 5,  0.0>
  right     x*image_width/image_height
}
