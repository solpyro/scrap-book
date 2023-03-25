//--includes------------------------

#include "colors.inc"
#include "stones.inc"
#include "woods.inc"
#include "metals.inc"

//--declares------------------------


#declare xCoord = 0;
#declare yCoord = 0;

#if (true)

#declare smallTiles = T_Stone31;
#declare largeTiles = T_Stone8;
#declare floorTilesT = T_Stone6;
#declare doorTexture = T_Wood24;
#declare chrome = T_Chrome_1D;
#declare glass = pigment {
                   colour rgbf <0.8, 0.9, 0.85, 0.85>
                 };
#declare floorTilesR = .05;
#declare wallTiles = .2;
#declare glassR = .2;

#else

#declare smallTiles = pigment{colour rgb .2};
#declare largeTiles = pigment{colour rgb .85};
#declare floorTilesT = pigment{colour rgb .3};
#declare doorTexture = pigment{colour rgb<.6,0,0>};
#declare chrome = pigment{colour rgb .5};
#declare glass = pigment {
                   colour rgbf <1,1,1,1>
                 };
#declare floorTilesR = 0;
#declare wallTiles = 0;
#declare glassR = 0;

#end

#declare photon = true;

#declare darkSquare = union {  
                        #while (yCoord < 35)
                          #while (xCoord < 30)
                            superellipsoid {
                              <.1, .1>
                              scale <.5, .5, .05>
                              translate <xCoord*1.1, yCoord*1.1, 0>
                              texture {
                                smallTiles
                              }
                              finish {
                                reflection wallTiles
                              }
                            }
                            #declare xCoord = xCoord + 1;
                          #end
                          #declare yCoord = yCoord + 1;
                          #declare xCoord = 0;
                        #end
                        #declare yCoord = 0;
                      }
#declare lightLine = union {
                       #while (xCoord < 5)
                         superellipsoid {
                           <.05, .05>
                           scale <3.25, 3.8, .05>
                           translate <2.75+(6.6*xCoord), -4.35, 0>
                           texture {
                             largeTiles
                           }
                           finish {
                             reflection wallTiles
                           }
                         }
                         #declare xCoord = xCoord + 1;
                       #end
                       #declare xCoord = 0;
                     }
#declare darkLine = union {
                      #while (yCoord < 7)
                        #while (xCoord < 30)
                        superellipsoid {
                          <.1, .1>
                          scale <.5, .5, .05>
                          translate <xCoord*1.1, yCoord*1.1, 0>
                          texture {
                            smallTiles
                          }
                          finish {
                            reflection wallTiles
                          }
                        }
                        #declare xCoord = xCoord + 1;
                      #end
                      #declare xCoord = 0;
                      #declare yCoord = yCoord + 1;
                    #end
                  }
                  
#declare floorTiles = union {
                        #declare xCoord = 0;
                        #declare yCoord = 0;
                        #while (xCoord < 10)
                          #while (yCoord < 20)
                            superellipsoid {
                              <.05, .05>
                              scale <3.25, 0.05, 3.25>
                              translate <2.7, -39.1, -3.4>
                              translate <6.6*xCoord, 0, -6.6*yCoord>
                              texture {
                                floorTilesT
                              }
                              finish {
                                reflection floorTilesR
                              }
                            }
                            #declare yCoord = yCoord + 1;
                          #end
                          #declare yCoord = 0;  
                          #declare xCoord = xCoord + 1;
                        #end
                      }

#declare sinkPanel = union {
                       object {
                         darkSquare
                       }
                       #declare yCoord = 0;
                       #while (yCoord < 5)
                         object {
                           lightLine
                           translate <0, -.05-(7.7*yCoord), 0>
                         }
                         #declare yCoord = yCoord + 1;
                         #declare xCoord = 0;
                       #end
                       #declare yCoord = 0;
                     }
#declare doorPanel = union {
                       difference { 
                         union {
                           #declare xCoord = 0;
                           #declare yCoord = 0;
                           #while (yCoord < 2)
                             object {
                               lightLine
                               translate <0, 38.45-(7.7*yCoord), 0>
                             }
                             #declare yCoord = yCoord + 1;
                           #end
                           #declare yCoord = 0;
                           object {
                             darkLine
                             translate <0, 15.39, 0>
                           }
                           #declare yCoord = 0;
                           #while (yCoord < 7)
                             object {
                               lightLine
                               translate <0, 15.35-(7.7*yCoord), 0>
                             }
                             #declare yCoord = yCoord + 1;
                             #declare xCoord = 0;
                           #end
                           #declare yCoord = 0;
                         }
                         box {
                           <-.55, -40, -5>,
                           <32.4, 30.2, 2>
                         }
                       }
                       box {
                         <-.55, -40, -5>,
                         <32.4, 30.2, 0>
                         texture {
                           doorTexture
                         }
                         finish {
                           reflection 0.05
                         }
                       }
                       union {
                         lathe {
                           cubic_spline
                           4,
                           <3, 0>, <1.5, 0>,
                           <.5, .5>, <.5, 1>
                         }
                         lathe {
                           cubic_spline
                           6,
                           <.5, 0>, <.5, .5>,
                           <.9, 1>, <1.5, 1.5>,
                           <0, 1.75>, <-1.5, 1.5>
                         }
                         texture {
                           chrome
                         }
                         rotate <90, 0, 0>
                         translate <30, -5, .00>
                       }
                     }
#declare normalPanel = union {
                         #declare xCoord = 0;
                         #declare yCoord = 0;
                         #while (yCoord < 2)
                           object {
                             lightLine
                             translate <0, 38.45-(7.7*yCoord), 0>
                           }
                           #declare yCoord = yCoord + 1;
                         #end
                         #declare yCoord = 0;
                         object {
                           darkLine
                           translate <0, 15.39, 0>
                         }
                         #declare yCoord = 0;
                         #while (yCoord < 7)
                           object {
                             lightLine
                             translate <0, 15.35-(7.7*yCoord), 0>
                           }
                           #declare yCoord = yCoord + 1;
                           #declare xCoord = 0;
                         #end
                         #declare yCoord = 0;
                       }

//--global--------------------------

global_settings {
  assumed_gamma 1.0
  max_trace_level 5
  #if (photon)          // global photon block
    photons {
      count 200000               // alternatively use a total number of photons
     jitter 1.0                 // jitter phor photon rays
    }
  #end
}

//--objects-------------------------

//walls
union {
//--back wall
  object {
    sinkPanel
  }
  object {
    normalPanel
    translate <-33, 0, 0>
  }
  object {
    normalPanel
    translate <-66.1, 0, 0>
  }
  object {
    normalPanel
    translate <33.1, 0, 0>
  }
//--left wall
  object {
    normalPanel
    translate <0, 0, -50>
    rotate <0, 90, 0>
    translate <-16.7, 0, -0.6>
  }
  object {
    normalPanel
    translate <0, 0, -50>
    rotate <0, 90, 0>
    translate <-16.7, 0, -33.7>
  }
  object {
    normalPanel
    translate <0, 0, -50>
    rotate <0, 90, 0>
    translate <-16.7, 0, -66.8>
  }
  object {
    normalPanel
    translate <0, 0, -50>
    rotate <0, 90, 0>
    translate <-16.7, 0, -99.9>
  }
//--right wall
  object {
    normalPanel
    translate <0, 0, -50>
    rotate <0, 90, 0>
    translate <115.7, 0, -0.6>
  }
  object {
    normalPanel
    translate <0, 0, -50>
    rotate <0, 90, 0>
    translate <115.7, 0, -33.7>
  }
  object {
    normalPanel
    translate <0, 0, -50>
    rotate <0, 90, 0>
    translate <115.7, 0, -66.8>
  }
  object {
    normalPanel
    translate <0, 0, -50>
    rotate <0, 90, 0>
    translate <115.7, 0, -99.9>
  }
//--front wall
  object {
    normalPanel
    translate <33.1, 0, -132.4>
  }
  object {
    normalPanel
    translate <0, 0, -132.4>
  }
  object {
    doorPanel
    translate <-33.1, 0, -132.4>
  }   
  object {
    normalPanel
    translate <-66.2, 0, -132.4>
  }
//--floor
  object {
    floorTiles
  }
  object {
    floorTiles
    translate <-66.1, 0, 0>
  }
//--grout
  difference {
    union {
      difference {
        box {
          <-70, -45, 2>,
          <70, 45, -150>
        }
        box {
          <-66.7, -39.2, -.04>,
          <65.7, 38, -132.5>
        }
        pigment {
          colour rgb <1,1,.8>
        } 
      }
//--celing
      difference {      
        box {
          <-70, 37.9, 2>,
          <70, 45, -132.6>
        }
//----light recesses
        cylinder {
          <0,2,0>,
          <0,0,0>,
          2
          translate <-60,37.89,-10>          
        }
        pigment {
          colour rgb <2, 2, 2>
        }
      }
    } 
//--lighting holes
  }
//furniture
//--mirror
  box {
    <2.8, 2.8, 0>,
    <29.1, 26.9, -.5>
    pigment {
      colour rgb <1, 1, 1>
    }
    finish {
      reflection 1
    }
  }
//--sink
  union {
//----support
    difference {
      box {
        <0, 0, 5>,
        <32.7, 1.5, -20>
      }
      cylinder {
        <12, 10, -10>,
        <12, -10, -10>,
        9
      }
      texture {
        doorTexture
      }
      translate <-.4, -2.1, 0>
    }
//----bowl
    difference {
      union {
        sphere {
          <0, 0, -10>,
          9
          scale <1, .75, 1>
        }
        cylinder {
          <0, 0, -10>,
          <0, .5, -10>,
          9.5
        }
      }
      sphere {
        <0, 0, -10>,
        8.5
        scale <1, .75, 1>
      }
      box {
        <-10, .5, 0>
        <10, 10, -20>
      }
      texture {
        glass
      }
      #if (photon)
        photons{              // creates photon use
          target 1.0          // spacing multiplier for photons hitting the object
          refraction on
          reflection on
        }
        interior {
          ior 1.35
          fade_power 1001
          fade_distance 0.9
          fade_color .98
        }
      #end
      translate <11.6, -.5, 0>
    }
//----pipe work
    union {
      cylinder {
        <0, 0, 1>,
        <0, 0, -.05>,
        1
      }
      sphere_sweep {
        b_spline
        8,
        <0, 0, 3>, .5
        <0, 0, 1>, .5
        <0, 0, -4>, .5
        <0, -1, -5>, .5
        <0, -2.5, -7.5>, .5
        <0, 0, -10>, .5
        <0, 2.7, -10>, .5
        <0, 3, -10>, .5
      }
      cylinder {
        <0, 2.8, -10>,
        <0, 2, -10>,
        1
      }
      texture {
        chrome
      }
      translate <11.6, -10, 0>
    }
    union {
      cylinder {
        <0, .3, 1>,
        <0, .3, -.05>,
        .5
      }
      cylinder {
        <2, .3, 1>,
        <2, .3, -.05>,
        .5
      }
      sphere_sweep {
        b_spline
        4,
        <0, 1, 1>, .3
        <0, 0, 0>, .3
        <0, 1, -1>, .3
        <0, 2, 0>, .3
      }  
      sphere_sweep {
        linear_spline
        2,
        <0, 1, -.66>, .3
        <0, 2.45, -.66>, .3
      }
      sphere_sweep {
        b_spline
        4,
        <2, 2, -.66>, .3
        <1, 3, -.66>, .3
        <2, 4, -.66>, .3
        <3, 3, -.66>, .3
        translate <-1.34, -.5, 0>
      }
      sphere_sweep {
        b_spline
        4,
        <2, 1, 1>, .3
        <2, 0, 0>, .3
        <2, 1, -1>, .3
        <2, 2, 0>, .3
      }  
      sphere_sweep {
        linear_spline
        2,
        <2, 1, -.66>, .3
        <2, 2.45, -.66>, .3
      }
      sphere_sweep {
        b_spline
        4,
        <2, 2, -.66>, .3
        <3, 3, -.66>, .3
        <2, 4, -.66>, .3
        <1, 3, -.66>, .3
        translate <-.66, -.5, 0>
      }
      sphere_sweep {
        linear_spline
        2,
        <.5, 3.15, -.66>, .3
        <1.5, 3.15, -.66>, .3
      }
      sphere_sweep {
        linear_spline
        2,
        <1, 3.15, -.66>, .3
        <1, 4.25, -.66>, .3
      }
      sphere_sweep {
        b_spline
        4,
        <1, 2, 1>, .3
        <1, 3, 2>, .3
        <1, 2. 3>, .3
        <1, 1, 2>, .3
        translate <0, 2.22, -3.33>
      }
      sphere_sweep {
        linear_spline
        2,
        <1, 4.88, -1.42>, .3
        <1, 4.88, -5>, .3
      }
      sphere_sweep {
        linear_spline
        2,
        <1, 4, -2>, .3
        <1, 6, -2>, .3
      }
//----tap
      blob {
        threshold 0.01
        cylinder {
          <2, 6.9, -3>,
          <2, 8, -3>,
          1,
          1
        }
        cylinder {
          <0.75, 6.9, -1.75>,
          <5, 10.1, -6>,
          .5,
          1
        }
      }
      cylinder {
        <2, 8, -3>,
        <2, 9.3, -3>,
        .6
      }
      cylinder {
        <2, 9.1, -3>,
        <1, 9.1, -4>,
        .1
      }
      cylinder {
        <4.9, 10, -5.9>,
        <5.2, 9, -6.2>,
        .45
      }
      texture {
        chrome
      }
      translate<.5, -7.5, 0>
    }
    translate <0, -7.7, 0>
  }
//--shower
  difference {
    union {
      superellipsoid {
        <.05, .05>
        scale 20
        translate <35, 0, -35>
      }
      superellipsoid {
        <.05, .05>
        scale 20
        translate <0, 0, -70>
      }
      box {
        <-25, -2, -25>,
        <15, 17, 15>
        translate <0, 0, -35>
      }
    }
    superellipsoid {
      <.05, .05>
      scale 25
      translate <-5, -5, -29.5>
      inverse
    }
    texture {
      pigment {
        colour rgb <2, 2, 2.1>
      }
      finish {
        reflection .05
      }
    }
    scale <1.5, 0, 1.5> 
    translate <-52, -55, 30>
  }
  cylinder {
    <-25, -2, -25>,
    <-25, 17, -25>,
    1.5
    texture {
      chrome
    }
    translate <-37,-54.9, 20.5>
  }
//----glass panels
  difference {
    box {
      <0, -40, 0>,
      <-50, 40, 50>
    }
    box {
      <-1, -41, 1>,
      <-51, 41, 51>
    }
    texture {
      glass
    }
    #if (photon)
      photons{              // creates photon use
        target 1.0          // spacing multiplier for photons hitting the object
        refraction on
        reflection on
      }
      interior {
        ior 1.35
        fade_power 1001
        fade_distance 0.9
        fade_color .98
      }
    #end
    translate <-24, 0, -49>
  }
//-----hinges
  cylinder {
    <0, -40, 0>,
    <0, 40, 0>,
    1
    texture {
      chrome
    }
    translate <-24, 0, -49>
  }
  cylinder {
    <0, -40, 0>,
    <0, 40, 0>,
    1
    texture {
      chrome
    }
    translate <-24, 0, 0>
  }
  cylinder {
    <0, -40, 0>,
    <0, 40, 0>,
    1
    texture {
      chrome
    }
    translate <-65, 0, -49>
  }
//----shower unit
  union {
//------taps
    difference {
      blob {
        threshold 0.01
        cylinder {
          <-5, 0, 0>, 
          <5, 0, 0>,
          .8
          1
        }
        cylinder {
          <-3, 0, 0>,
          <-3, 0, 2>,
          .7
          1
        }
        cylinder {
          <3, 0, 0>,
          <3, 0, 2>,
          .7
          1
        }
      }
      cylinder {
        <-3.7,0,0>,
        <-3.8,0,0>
        1
      }
      cylinder {
        <3.7,0,0>,
        <3.8,0,0>
        1
      }
      texture {
        chrome
      }
    }
    cylinder {
      <3.6,0,0>,
      <3.9,0,0>
      .75
      pigment {
        colour rgb <1,0,0>
      }
      finish {
        reflection .2
      }
    }
    cylinder {
      <-3.6,0,0>,
      <-3.9,0,0>
      .75
      pigment {
        colour rgb <0,0,1>
      }
      finish {
        reflection .2
      }
    }
//------hose
    sphere_sweep {
      b_spline,
      12,
      <0,2,0>,.3
      <0,0,0>,.3
      <0,-3,1.7>,.3
      <0,-6,-.8>,.3
      <0,-3,-3>,.3
      <0,0,-2>,.3
      <0,2,-1>,.3
      <0,4,0>,.3
      <0,6,1>,.3
      <0,11,1>,.3
      <0,14.8,.5>,.3
      <0,16,0>,.3
      pigment {
        color rgb <.1,.1,.1>
      }
    }
//------support bar
    union {
      cylinder {
        <0,0,-.25>,
        <0,15,-.25>,
        .5
      }
      cylinder {
        <0,0,1.5>,
        <0,0,-1>,
        1
        scale <1,.7,1>
      }
      cylinder {
        <0,0,1.5>,
        <0,0,-1>,
        1
        scale <1,.7,1>
        translate <0,15,0>
      }
      texture {
        chrome
      }
      translate <-3,5,0>
    }
//------shower head & bracket
    union {
      union {
        sphere {
          <0,0,0>,2
          scale <1,.3,1>
        }
        cone {
          <0,-.1,0>,1.98
          <0,-.7,0>,1.4
        } 
        cylinder {
          <0,-.1,0>,
          <0,-.8,0>,
          .95
        } 
        cylinder {
          <0,-.1,0>,
          <0,-.75,0>,
          .4
        } 
        sphere_sweep {
          b_spline
          4,
          <0,-1,-1>,.5
          <0,.5,0>,.5
          <0,0,7>,.5
          <0,-2,8>,.5
        }
        texture {
          chrome
        }
      }
//--------nozzels
      union {
        #while (xCoord < 36)
          sphere {
            <0,-.7,0>,.15
            scale <.5,1,.5>
            translate <1.25,0,0>
            rotate <0,10*xCoord,0>
          }
          sphere {
            <0,-.7,0>,.15
            scale <.5,1,.5>
            translate <1.1,0,0>
            rotate <0,(10*xCoord)+5,0>
          }
          sphere {
            <0,-.7,0>,.15
            scale <.5,1,.5>
            translate <0.85,-.1,0>
            rotate <0,20*xCoord,0>
          }
          sphere {
            <0,-.7,0>,.15
            scale <.5,1,.5>
            translate <0.7,-.1,0>
            rotate <0,(20*xCoord)+10,0>
          }
          sphere {
            <0,-.7,0>,.15
            scale <.5,1,.5>
            translate <0.55,-.1,0>
            rotate <0,20*xCoord,0>
          }
          sphere {
            <0,-.7,0>,.15
            scale <.5,1,.5>
            translate <0.25,-.15,0>
            rotate <0,40*xCoord,0>
          }
          sphere {
            <0,-.7,0>,.15
            scale <.5,1,.5>
            translate <0,-.15,0>
            rotate <0,0,0>
          }
          #declare xCoord = xCoord + 1;
        #end
        #declare xCoord = 0;
        pigment {
          colour rgb <.8,.8,.8>
        }
      }
      rotate <25,0,0>
      translate <0,17,-5>
      
    }
    cylinder {
      <-4,0,0>,
      <1,0,0>,
      .7
      texture {
        chrome
      }
      translate <0,14.5,-.2>
    }
    translate <-45, -3, -1.5>
  }  
//--radiator
  union {
    #while (xCoord < 2)
      union {
        cylinder {
          <-2,0,0>,
          <2,0,0>,
          2
          scale<1,.6,1>
        }
        cylinder {
          <-2,0,0>,
          <2,0,0>,
          2
          scale<1,.6,1>
          translate <0,-52,0>
        }
        cylinder {
          <1,0,0>,
          <1,-52,0>
          .8
        }
        translate <0,0,-25*xCoord>
      }
      #declare xCoord = xCoord + 1;
    #end
    #declare xCoord = 0;
    #while (xCoord < 6)
      cylinder {
        <1,0,0>,
        <1,0,-25>,
        .7
        translate <0,-6-(8*xCoord),0>
      }
      #declare xCoord = xCoord + 1;
    #end
    #declare xCoord = 0;
    texture {
      chrome
    }
    translate <-65,25,-65>
  }
//lighting
  
}
 
//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <0, 35, -35>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <-5, 0, -132> //20 -20
  look_at   <0, 0, 0>
  right     x*image_width/image_height
}