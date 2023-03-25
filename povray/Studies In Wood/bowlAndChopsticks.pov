//--global--------------------------
//--includes------------------------

// T_Wood1 - T_Wood35
#include "woods.inc"

//--declares------------------------ 

//-------------------
//background
//-------------------
#declare backWallDistance = 30;
#declare verticalBeam = box {
                          <-.5, -backWallDistance, -.5>,
                          <.5, backWallDistance, .5>
                          texture {
                            T_Wood2
                          }
                        };
#declare verticalBeamCounter = -backWallDistance;
#declare crossBar = cylinder {
                      <-(backWallDistance+10), 0, 0>
                      <backWallDistance+10, 0, 0>,
                      .2
                      texture {
                        T_Wood2
                      }
                    };
#declare barsCounter = 10;

//-------------------
//foreground
//-------------------
#declare bowlWidth = .3;
#declare baseHeight = 1;
#declare chopstick = cone {
                       <0, -4, 0>,  .02,
                       <0, 8, 0>, .2
                       texture {
                         T_Wood8
                       }
                     }

//--objects-------------------------

//-------------------
//background
//-------------------
union {
//wall
  plane {
    z,
    backWallDistance
    pigment {
      colour rgbt <1, .9, .7, .2>
    }
  }
//beams
//--vertical beams
  #while (verticalBeamCounter <= backWallDistance)
    object {
      verticalBeam
      translate <verticalBeamCounter, 0, backWallDistance>
    }
    #declare verticalBeamCounter = verticalBeamCounter + 15;
  #end
//--crossbeam
  box {
    <-(backWallDistance+10), -.6, -.6>,
    <backWallDistance+10, .6, .6>
    texture {
      T_Wood2
    } 
    translate <0, 10, backWallDistance>
  }
//--bars
  #while (barsCounter >= -15)
    object {
      crossBar
      translate <0, barsCounter, backWallDistance>
    }
    #declare barsCounter = barsCounter - 3.5;
  #end
}
//-------------------
//foreground
//-------------------
//bowl
difference {
//--bowl shape
  sphere {
    <0, 0, 0>, 5
  }
//--hollowing section
  difference {
//----hollowing sphere
//------sphere
    sphere {
      <0, 0, 0>, 5-bowlWidth
    }
//------internal base cut-off
    box {
      <5-bowlWidth, -(5-bowlWidth-baseHeight), 5-bowlWidth>,
      <-(5-bowlWidth), -(5-bowlWidth), -(5-bowlWidth)>
    }
  }
//----external base cut-off
  box {
  <5, -(5-baseHeight), 5>,
  <5, -5, -5>
  }
//----top cut-off
  box {
    <-5, 0, -5>,
    <5, 5, 5>
  }
  texture {
    T_Wood9
  }
}

//chopsticks
union {
  object { 
    chopstick
  }
  object {
    chopstick
    rotate <5, 1, 0>
    translate <0, 0, .5>
    
  }
  rotate <0, 0, -70>
  translate <0, -1.5, 0>
  rotate <0, -22, 0>
}

//table
box {
  <15, -(5-baseHeight), 15>
  <-15, -5, -15>
  texture {
    T_Wood6
  }
}

//--lights-------------------------- 

//room light
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 40, -20>
}

//wall luminessence
light_source {
  0*x                  // light's position (translated below)
  color rgb <3, 3, 3>    // light's color
  translate <0, 40, 1.5*backWallDistance>
}


//--camera--------------------------

// perspective (default) camera
camera {
  location  <0.0, 3, -15.0>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
