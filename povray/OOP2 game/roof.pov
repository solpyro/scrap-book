//--global--------------------------
//--includes------------------------

#include "metals.inc"

//--declares------------------------

//mode
#declare bEdit = false;

//textures
#if (bEdit)
  #declare Wall = pigment {
                    colour rgb <1,0,0>
                  };
  #declare Floor = pigment {
                     colour rgb <0,1,0>
                   };
  #declare Ladder = pigment {
                      colour rgb <0,0,1>
                    };
  #declare Hatch = pigment {
                     colour rgb <1,1,0>
                   };
  #declare Fixings = pigment {
                       colour rgb <1,0,1>
                     };
  #declare Duct = pigment {
                    colour rgb <0,1,1>
                  };
#else
  #declare Wall = texture {
                    pigment {
                        brick      
                        color rgb <.9,.7,.5>,
                        color rgb <1,0,0>
                        brick_size <2,1,1>
                        mortar     0.2 
                    }
                  };
  #declare Floor = pigment {
                     colour rgb <.8,.7,.5>
                   };
  #declare Ladder = T_Copper_1A;
  #declare Hatch = pigment {
                     colour rgb <1,1,.9>
                   };
  #declare Fixings = texture {
                       pigment {
                         colour rgb <.8,.8,.8>
                       }
                       finish {
                         reflection .6
                       }
                     };
  #declare Duct = texture {
                    pigment {
                      colour rgb <.4,.4,.4>
                    }
                    finish {
                      reflection .3
                    }
                  };
#end
                   
//--objects-------------------------

//roof
box {
  <-12,0,10>,
  <20,3,12>
  texture {
    Wall
  }
  translate<11,0,-11>
  rotate<0,90,0>
  translate<-11,0,11>
}
box {
  <-12,0,10>,
  <20,3,12>
  texture {
    Wall
  }
}
box {
  <-12,0,-20>,
  <20,0,12>
  texture {
    Floor
  }
}

//ladder
#declare counter = 0;
#while (counter<2)
  union {
    sphere_sweep {
      b_spline 5
      <-5,1,11>,.3
      <-5,3,9>,.3
      <-5,5,11>,.3
      <-5,3,13>,.3
      <-5,1,11>,.3
    }
    sphere_sweep {
      linear_spline 2
      <-5,3,9.65>,.3
      <-5,-1,9.65>,.3
    }
    texture {
      Ladder
    }
    translate <3*counter,0,0>
  } 
  #declare counter = counter + 1;
#end

//hatch
union {
  difference {
    box {
      <-1,0,1>,
      <7,.3,9>
    }
    box {
      <-.5,-.1,1.5>,
      <6.5,.4,8.5>
    }
  }
  box {
    <-.48,-.1,1.52>,
    <6.58,.3,8.48>
  }
  texture {
    Hatch
  }
}
union {
  sphere_sweep {
    linear_spline 2
    <6.5,.3,7>,.1
    <6.5,.3,6>,.1
  }
  sphere_sweep {
    linear_spline 2
    <6.5,.3,4>,.1
    <6.5,.3,3>,.1
  }
  texture {
    Fixings
  }
}

//duct
union {
  difference {  
    box {
      <0,0,0>,
      <6,2,6>
    }
    box {
      <0.1,0,0.1>,
      <5.9,2.1,5.9>
    }
  }
  difference {
    cylinder {
      <6,2,0>,
      <6,2,6>,
      6
    }
    cylinder {
      <6,2,0.1>,
      <6,2,5.9>,
      5.9
    }
    box {
      <6,-1,-1>,
      <13,13,7>
    }
  }
  texture {
    Duct
  }
  translate<-3,0,-3>
  rotate<0,-20,0>
  translate <-4,0,-5>
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <20, 30, -20>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <25,13,-25>
  look_at   <0,7,0>
  right     x*image_width/image_height
}
