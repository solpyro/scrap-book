//--global--------------------------
//--includes------------------------

#include "metals.inc"
#include "woods.inc"

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
  #declare Cubicle = pigment {
                       colour rgb <0,0,1>
                     };
  #declare Door = pigment {
                    colour rgb <1,1,0>
                  };
  #declare Doorknob = pigment {
                        colour rgb <1,0,1>
                      };
#else 
  #declare Wall = texture {
                    pigment {
                      brick
                      colour rgb <1,.95,.95>
                      colour rgb 1.2
                      brick_size <2,2,2>
                      mortar 0.2
                    }
                    finish {
                      reflection .1
                      phong .1
                    }
                  };
  #declare Floor = texture {
                     pigment {
                       checker
                       colour rgb 1.2
                       colour rgb 0
                     }
                     finish {
                       reflection .3
                     }
                   };
  #declare Cubicle = texture {
                       pigment {
                         colour rgb <1,1,1>
                       }
                       finish {
                         reflection .1
                       }
                     };
  #declare Door = texture {
                    T_Wood24
                    finish {
                      phong .2
                    }
                  };
  #declare Doorknob = T_Brass_5A; 
#end
                   
//--objects-------------------------

//walls
box {
  <-10,-10,-20>,
  <-12,30,12>
  texture {
    Wall
  }
}
box {
  <52,-10,10>,
  <-12,30,12>
  texture {
    Wall
  }
}
box {
  <-12,-10,-20>,
  <52,-10,12>
  texture {
    Floor
  }
} 

//cubicle walls
union {
  difference { 
    box {
      <10,-7,-30>,
      <10.3,15,12>
    }
    #declare counter = 0;
    #while (counter<2)
      box {
        <9,-8,6>,
        <11,16,-10>
        translate <0,0,-20*counter>
      }
      #declare counter = counter + 1;
    #end
  } 
  box {
    <-10,-7,-11.5>,
    <10,15,-12.5>
  } 
  box {
    <10,-7,-11.7>,
    <10.3,-10,-12.3>
    texture {
      pigment  {
        color rgb <1,1,1>
      }
      finish {
        reflection .4
      }
    }
  }
  texture {
    Cubicle
  }
}

//door
box {
  <16,-10,10>,
  <31,16,9.9>
  texture {
    Door
  }
}
//--doorknob
lathe {
  cubic_spline 7
  <-1,0>,
  <0,0>,
  <1,.2>,
  <1,.4>,
  <.4,.6>,
  <.4,1>,
  <.4,1.2>
  texture {
    Doorknob
  }
  rotate <90,0,0>
  scale .6
  translate <28.5,4,7.5>
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <20, 20, -40>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <25,13,-40>
  look_at   <20,5,0>
  right     x*image_width/image_height
}
