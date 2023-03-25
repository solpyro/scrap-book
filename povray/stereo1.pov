                                                               //--global--------------------------
//--includes------------------------
//--declares------------------------

//mode
#declare bEdit = true;

//textures
#if (bEdit)
  #declare tStone =  texture {
                       pigment {
                         colour rgb <1,0,0>
                       }
                     }  
  #declare tFabric = texture {
                       pigment {
                         colour rgb <0,1,0>
                       }
                     }
  #declare tGround = texture {
                       pigment {
                         colour rgb <0,0,1>
                       }
                     }                          
#else  
  #declare tStone = texture {
                    } 
  #declare tFabric = texture {
                     }
  #declare tGround = texture {
                     } 
#end
                   
//--objects-------------------------

//ground
plane {
  y,0
  texture {
    tGround
  }
}       
//near wall
difference {
  box {
    <-1, 0, 0>,
    < 1,40,40>
  }
  //ground floor      
  union {
    box {
      <-5,-1,28>,
      < 5, 7,36>
    }
    cylinder {
      <-5, 0,30>,
      < 5, 0,30>,
      2                 
      scale <1,.5,1> 
      translate <0,7,0>
    }           
    cylinder {
      <-5, 0,34>,
      < 5, 0,34>,
      2  
      scale <1,.5,1> 
      translate <0,7,0>
    } 
    box {
      <-5, 6,30>,
      < 5, 8,34>
    }
  }
  union {
    box {
      <-5,-1,28>,
      < 5, 7,36>
    }
    cylinder {
      <-5, 0,30>,
      < 5, 0,30>,
      2                 
      scale <1,.5,1> 
      translate <0,7,0>
    }           
    cylinder {
      <-5, 0,34>,
      < 5, 0,34>,
      2  
      scale <1,.5,1> 
      translate <0,7,0>
    } 
    box {
      <-5, 6,30>,
      < 5, 8,34>
    }
    translate <0,0,-10>
  }       
  //first floor
  union {
    box {
      <-5,0,28>,
      < 5, 7,36>
    }
    cylinder {
      <-5, 0,30>,
      < 5, 0,30>,
      2                 
      scale <1,.5,1> 
      translate <0,7,0>
    }           
    cylinder {
      <-5, 0,34>,
      < 5, 0,34>,
      2  
      scale <1,.5,1> 
      translate <0,7,0>
    } 
    box {
      <-5, 6,30>,
      < 5, 8,34>
    }
    translate <0,10,5>
  }      
  union {
    box {
      <-5,0,28>,
      < 5, 7,36>
    }
    cylinder {
      <-5, 0,30>,
      < 5, 0,30>,
      2                 
      scale <1,.5,1> 
      translate <0,7,0>
    }           
    cylinder {
      <-5, 0,34>,
      < 5, 0,34>,
      2  
      scale <1,.5,1> 
      translate <0,7,0>
    } 
    box {
      <-5, 6,30>,
      < 5, 8,34>
    }
    translate <0,10,-5>
  }        
  union {
    box {
      <-5,0,28>,
      < 5, 7,36>
    }
    cylinder {
      <-5, 0,30>,
      < 5, 0,30>,
      2                 
      scale <1,.5,1> 
      translate <0,7,0>
    }           
    cylinder {
      <-5, 0,34>,
      < 5, 0,34>,
      2  
      scale <1,.5,1> 
      translate <0,7,0>
    } 
    box {
      <-5, 6,30>,
      < 5, 8,34>
    }
    translate <0,10,-15>
  }  
  box {
    <-5,10,1>,
    <0,50,41>
  }            
  //second floor
  union {
    box {
      <-5,0,28>,
      < 5, 7,36>
    }
    cylinder {
      <-5, 0,30>,
      < 5, 0,30>,
      2                 
      scale <1,.5,1> 
      translate <0,7,0>
    }           
    cylinder {
      <-5, 0,34>,
      < 5, 0,34>,
      2  
      scale <1,.5,1> 
      translate <0,7,0>
    } 
    box {
      <-5, 6,30>,
      < 5, 8,34>
    }
    translate <0,20,0>
  }   
  union {
    box {
      <-5,0,28>,
      < 5, 7,36>
    }
    cylinder {
      <-5, 0,30>,
      < 5, 0,30>,
      2                 
      scale <1,.5,1> 
      translate <0,7,0>
    }           
    cylinder {
      <-5, 0,34>,
      < 5, 0,34>,
      2  
      scale <1,.5,1> 
      translate <0,7,0>
    } 
    box {
      <-5, 6,30>,
      < 5, 8,34>
    }
    translate <0,20,-10>
  }
  texture {
    tStone
  }
  translate <15,0,-100>
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <.2,.2,.2>    // light's color
  translate <0, 40, -200>
}                                      
light_source {
  0*x                  // light's position (translated below)
  color rgb <5,5,5>    // light's color
  translate <216, 40, -20>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <0,12,-100>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
