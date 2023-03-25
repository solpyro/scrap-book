//--global--------------------------
//--includes------------------------
//--declares------------------------

//mode
#declare bEdit = false;

//textures
#if (bEdit)
  #declare Wall = pigment {
                    colour rgb <1,0,0>
                  };
  #declare Pavement = pigment {
                        colour rgb <0,1,0>
                      };
  #declare Kerb = pigment {
                    colour rgb <0,0,1>
                  };
#else
  #declare Wall = pigment {
                    brick
                    colour rgb <.8,.8,.6>
                    colour rgb <.6,0,0>
                    brick_size <2,1,2>
                    mortar .2
                  };
  #declare Pavement = pigment {
                        colour rgb .6
                      };
  #declare Kerb = pigment {
                    colour rgb .8
                  };  
#end
                   
//--objects-------------------------

//walls
union {
  box {
    <-90,-10,30>,
    <-10,20,-20>
  }
  box {
    <90,-10,30>,
    <10,20,-20>
  }
  box {
    <-90,-10,120>
    <90,50,120>
  }
  texture {
    Wall
  }
}
difference {
  box {
    <-90,-10,-20>,
    <90,-20,200>
  }
  box {
    <-90,-9,50>,
    <90,-12,90>
  }
  texture {
    Pavement
  }
}
//--kerb
union {
  cylinder {
    <-90,0,0>,
    <90,0,0>,4
    scale <.5,.5,0>
    translate <0,-12,50>
  }
  cylinder {
    <-90,0,0>,
    <90,0,0>,4
    scale <.5,.5,0>
    translate <0,-12,90>
  }  
  texture {
    Kerb
  }
}


//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <0, 20, 50>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <0,0,-10>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
