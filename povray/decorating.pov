//--global--------------------------
//--includes------------------------
//--declares------------------------

//mode
#declare bEdit = true;     
#declare daylight = false;  
#declare lookAt = 1;//0 - bareWall, 1 - fireplace, 2 - window, 3 - wardrobe

//textures
#if (bEdit)
  #declare tWall1 = texture {
                      pigment {
                        colour rgb <1,0,0>
                      }
                    } 
  #declare tWall2 = texture {
                      pigment {
                        colour rgb <0,1,0>
                      }
                    }
  #declare tWall3 = texture {
                      pigment {
                        colour rgb <0,0,1>
                      }
                    }
  #declare tWall4 = texture {
                      pigment {
                        colour rgb <1,1,0>
                      }
                    }
  #declare tWall5 = texture {
                      pigment {
                        colour rgb <1,0,1>
                      }
                    } 
  #declare tWall6 = texture {
                      pigment {
                        colour rgb <0,1,1>
                      }
                    } 
  #declare tDoor = texture {
                     pigment {
                       colour rgb <.5,.5,.5>
                     }
                   } 
  #declare tWardrobe = texture {
                         pigment {
                           colour rgb <.5,.5,.5>
                         }
                       }    
  #declare tFloor = texture {
                      pigment {
                        colour rgb <1,1,1>
                      }
                    }
  #declare tCeiling = texture {
                        pigment {
                          colour rgb <1,1,1>
                        }
                      }
#else  
  #declare tWall1 = texture {
                    }   
  #declare tWall2 = texture {
                    }
  #declare tWall3 = texture {
                    }
  #declare tWall4 = texture {
                    }
  #declare tWall5 = texture {
                    }
  #declare tWall6 = texture {
                    }   
  #declare tFloor = texture {
                    }
  #declare tCeiling = texture {
                      }
#end
                   
//--objects-------------------------
      
//----floor 
box {
  <-.5,0,0>
  <3,-1,3>
  texture {
    tFloor
  }
}
//----ceiling
box {
  <-.5,2,0>
  <3,3,3>
  texture {
    tCeiling
  }
}
//----wall1 - clear wall
box {
  <0,0,0>,
  <3,2,-1>
  texture {
    tWall1
  }
}
//----wall2 - fireplace
box {
  <0,0,0>,
  <-1,2,0.9999>
  texture {
    tWall2
  }
}
//----wall3 - fireplace recess   
box {
  <-0.0001,0,1>,
  <-1,2,0>
  texture {
    tWall3
  }
}
//----wall4 - adjacent to fireplace  
box {
  <-0.5,0,1>,
  <-1,2,3>
  texture {
    tWall4
  }
}
//----wall5 - windowed wall      
difference {
  box {
    <-0.5,0,3>,
    <3,2,3.2>
  }
  box {
    <0,1.5,2>,
    <2.2,.5,5>
  }
  texture {
    tWall5
  }
}
//----wall6 - door and wardrobe
box {
  <3,0,0>,
  <4,2,3>
  texture {
    tWall6
  }
}  
//------door
box {
  <4,0,0.1>,
  <2.9999,1.7,.8>
  texture {
    tDoor
  }
}
//------wardrobe 
box {
  <3,0,1>,
  <2.85,1.7,2.4>
  texture {
    tWardrobe
  }
}

//--lights--------------------------

#if(daylight)
  light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <1.5,1,3>
    jitter
  }  
#else    
  light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <1.5, 1.8,1.5>
  }            
#end      
      
//--camera--------------------------

// perspective (default) camera
camera {     
#switch(lookAt)
  #case(0)//bareWall
    location  <1.5,1,3>
    look_at   <1.5,1,0>
    #break       
  #case(1)//fireplace
    location  <2.85,1,1.5>
    look_at   <0,1,1.5>
    #break
  #case(2)//window 
    location  <1.2,1,0>
    look_at   <1.2,1,4>
    #break
  #case(3)//wardrobe 
    location  <0,1,1.5>
    look_at   <3,1,1.5>
    #break        
  #else
    location  <0,1,1.5>
    look_at   <3,1,1.5> 
#end
  right     x*image_width/image_height
}
                   
//CAMERA POSITIONS
//bare wall loc <1.5,1,3> look <1.5,1,0>
//fireplace loc <3,1,1.5> look <0,1,1.5>    
//windowed  loc <1.2,1,0> look <1.2,1,4>    
//wardrobed loc <0,1,1.5> look <3,1,1.5>