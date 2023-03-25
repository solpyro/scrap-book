//--global--------------------------
//--includes------------------------
//--declares------------------------

#declare editing = false;

#declare lumpy = texture {
                   #if (editing)
                     pigment {
                       colour rgb <1,0,0>
                     }
                   #else
                     pigment {
                       colour rgb <.15,.15,.3>
                     }
                     normal {
                       marble turbulence .6
                     }
                     finish {
                       phong .1
                     }
                   #end
                 };
                 
#declare centralShaft = union {
                          cylinder {
                            <0,50,0>,
                            <0,30,0>,
                            60
                          }
                          cylinder {
                            <0,31,0>,
                            <0,10,0>,
                            54
                          }
                          cylinder {
                            <0,11,0>,
                            <0,-10,0>,
                            48
                          }
                          cylinder {
                            <0,-9,0>,
                            <0,-30,0>,
                            42
                          } 
                          cylinder {
                            <0,-29,0>,
                            <0,-50,0>,
                            36
                          }             
                        };

#declare tunnel = union {
                      box {
                        <2,4,0>,
                        <-2,0,66.01>
                      }
                      cylinder {
                        <0,4,0>,
                        <0,4,66.01>,
                        2
                      }
                    }

#declare tunnelLight = light_source {
                         0*x
                         color rgb <.125,.125,.25>
                         translate <0,3,64>
                       };
                    
#declare stepsL1 = union {
                     difference {
                       cylinder {
                         <0,-30,0>,
                         <0,-22,0>,
                         42
                       }
                       cylinder {
                         <0,-30.001,0>,
                         <0,-21.999,0>,
                         39
                       }
                       box {
                         <0,-30.01,-60.1>
                         <60.1,-28.99,60.1>
                       }
                       box {
                         <0,-30.01,-60.1>
                         <60.1,-28.99,60.1>
                         rotate <0,142,0>
                       }
                       box {
                         <0,-29.01,-60.1>
                         <60.1,-27.99,60.1>
                         rotate <0,-2,0>
                       }
                       box {
                         <0,-29.01,-60.1>
                         <60.1,-27.99,60.1>
                         rotate <0,144,0>
                       }
                       box {
                         <0,-28.01,-60.1>
                         <60.1,-26.99,60.1>
                         rotate <0,-4,0>
                       }
                       box {
                         <0,-28.01,-60.1>
                         <60.1,-26.99,60.1>
                         rotate <0,146,0>
                       }
                       box {
                         <0,-27.01,-60.1>
                         <60.1,-25.99,60.1>
                         rotate <0,-6,0>
                       }
                       box {
                         <0,-27.01,-60.1>
                         <60.1,-25.99,60.1>
                         rotate <0,148,0>
                       }
                       box {
                         <0,-26.01,-60.1>
                         <60.1,-24.99,60.1>
                         rotate <0,-8,0>
                       }
                       box {
                         <0,-26.01,-60.1>
                         <60.1,-24.99,60.1>
                         rotate <0,150,0>
                       }
                       box {
                         <0,-25.01,-60.1>
                         <60.1,-23.99,60.1>
                         rotate <0,-10,0>
                       }
                       box {
                         <0,-25.01,-60.1>
                         <60.1,-23.99,60.1>
                         rotate <0,152,0>
                       }
                       box {
                         <0,-24.01,-60.1>
                         <60.1,-22.99,60.1>
                         rotate <0,-12,0>
                       }
                       box {
                         <0,-24.01,-60.1>
                         <60.1,-22.99,60.1>
                         rotate <0,154,0>
                       }
                       box {
                         <0,-23.01,-60.1>
                         <60.1,-21.99,60.1>
                         rotate <0,-14,0>
                       }
                       box {
                         <0,-23.01,-60.1>
                         <60.1,-21.999,60.1>
                         rotate <0,156,0>
                       }
                     }
                     rotate <0,19,0>
                   };
                   
#declare stepsL2 = union {
                     difference {
                       cylinder {
                         <0,-30,0>,
                         <0,-22,0>,
                         48
                       }
                       cylinder {
                         <0,-30.001,0>,
                         <0,-21.999,0>,
                         45
                       }
                       box {
                         <0,-30.01,-60.1>
                         <60.1,-28.99,60.1>
                       }
                       box {
                         <0,-30.01,-60.1>
                         <60.1,-28.99,60.1>
                         rotate <0,142,0>
                       }
                       box {
                         <0,-29.01,-60.1>
                         <60.1,-27.99,60.1>
                         rotate <0,-2,0>
                       }
                       box {
                         <0,-29.01,-60.1>
                         <60.1,-27.99,60.1>
                         rotate <0,144,0>
                       }
                       box {
                         <0,-28.01,-60.1>
                         <60.1,-26.99,60.1>
                         rotate <0,-4,0>
                       }
                       box {
                         <0,-28.01,-60.1>
                         <60.1,-26.99,60.1>
                         rotate <0,146,0>
                       }
                       box {
                         <0,-27.01,-60.1>
                         <60.1,-25.99,60.1>
                         rotate <0,-6,0>
                       }
                       box {
                         <0,-27.01,-60.1>
                         <60.1,-25.99,60.1>
                         rotate <0,148,0>
                       }
                       box {
                         <0,-26.01,-60.1>
                         <60.1,-24.99,60.1>
                         rotate <0,-8,0>
                       }
                       box {
                         <0,-26.01,-60.1>
                         <60.1,-24.99,60.1>
                         rotate <0,150,0>
                       }
                       box {
                         <0,-25.01,-60.1>
                         <60.1,-23.99,60.1>
                         rotate <0,-10,0>
                       }
                       box {
                         <0,-25.01,-60.1>
                         <60.1,-23.99,60.1>
                         rotate <0,152,0>
                       }
                       box {
                         <0,-24.01,-60.1>
                         <60.1,-22.99,60.1>
                         rotate <0,-12,0>
                       }
                       box {
                         <0,-24.01,-60.1>
                         <60.1,-22.99,60.1>
                         rotate <0,154,0>
                       }
                       box {
                         <0,-23.01,-60.1>
                         <60.1,-21.99,60.1>
                         rotate <0,-14,0>
                       }
                       box {
                         <0,-23.01,-60.1>
                         <60.1,-21.999,60.1>
                         rotate <0,156,0>
                       }
                     }
                     rotate <0,19,0>
                     translate <0,20,0>
                   };
                   
#declare stepsL3 = union {
                     difference {
                       cylinder {
                         <0,-30,0>,
                         <0,-22,0>,
                         54
                       }
                       cylinder {
                         <0,-30.001,0>,
                         <0,-21.999,0>,
                         51
                       }
                       box {
                         <0,-30.01,-60.1>
                         <60.1,-28.99,60.1>
                       }
                       box {
                         <0,-30.01,-60.1>
                         <60.1,-28.99,60.1>
                         rotate <0,142,0>
                       }
                       box {
                         <0,-29.01,-60.1>
                         <60.1,-27.99,60.1>
                         rotate <0,-2,0>
                       }
                       box {
                         <0,-29.01,-60.1>
                         <60.1,-27.99,60.1>
                         rotate <0,144,0>
                       }
                       box {
                         <0,-28.01,-60.1>
                         <60.1,-26.99,60.1>
                         rotate <0,-4,0>
                       }
                       box {
                         <0,-28.01,-60.1>
                         <60.1,-26.99,60.1>
                         rotate <0,146,0>
                       }
                       box {
                         <0,-27.01,-60.1>
                         <60.1,-25.99,60.1>
                         rotate <0,-6,0>
                       }
                       box {
                         <0,-27.01,-60.1>
                         <60.1,-25.99,60.1>
                         rotate <0,148,0>
                       }
                       box {
                         <0,-26.01,-60.1>
                         <60.1,-24.99,60.1>
                         rotate <0,-8,0>
                       }
                       box {
                         <0,-26.01,-60.1>
                         <60.1,-24.99,60.1>
                         rotate <0,150,0>
                       }
                       box {
                         <0,-25.01,-60.1>
                         <60.1,-23.99,60.1>
                         rotate <0,-10,0>
                       }
                       box {
                         <0,-25.01,-60.1>
                         <60.1,-23.99,60.1>
                         rotate <0,152,0>
                       }
                       box {
                         <0,-24.01,-60.1>
                         <60.1,-22.99,60.1>
                         rotate <0,-12,0>
                       }
                       box {
                         <0,-24.01,-60.1>
                         <60.1,-22.99,60.1>
                         rotate <0,154,0>
                       }
                       box {
                         <0,-23.01,-60.1>
                         <60.1,-21.99,60.1>
                         rotate <0,-14,0>
                       }
                       box {
                         <0,-23.01,-60.1>
                         <60.1,-21.999,60.1>
                         rotate <0,156,0>
                       }
                     }
                     rotate <0,19,0>
                     translate <0,40,0>
                   };
                   
#declare stepsL4 = union {
                     difference {
                       cylinder {
                         <0,-30,0>,
                         <0,-22,0>,
                         60
                       }
                       cylinder {
                         <0,-30.001,0>,
                         <0,-21.999,0>,
                         57
                       }
                       box {
                         <0,-30.01,-60.1>
                         <60.1,-28.99,60.1>
                       }
                       box {
                         <0,-30.01,-60.1>
                         <60.1,-28.99,60.1>
                         rotate <0,142,0>
                       }
                       box {
                         <0,-29.01,-60.1>
                         <60.1,-27.99,60.1>
                         rotate <0,-2,0>
                       }
                       box {
                         <0,-29.01,-60.1>
                         <60.1,-27.99,60.1>
                         rotate <0,144,0>
                       }
                       box {
                         <0,-28.01,-60.1>
                         <60.1,-26.99,60.1>
                         rotate <0,-4,0>
                       }
                       box {
                         <0,-28.01,-60.1>
                         <60.1,-26.99,60.1>
                         rotate <0,146,0>
                       }
                       box {
                         <0,-27.01,-60.1>
                         <60.1,-25.99,60.1>
                         rotate <0,-6,0>
                       }
                       box {
                         <0,-27.01,-60.1>
                         <60.1,-25.99,60.1>
                         rotate <0,148,0>
                       }
                       box {
                         <0,-26.01,-60.1>
                         <60.1,-24.99,60.1>
                         rotate <0,-8,0>
                       }
                       box {
                         <0,-26.01,-60.1>
                         <60.1,-24.99,60.1>
                         rotate <0,150,0>
                       }
                       box {
                         <0,-25.01,-60.1>
                         <60.1,-23.99,60.1>
                         rotate <0,-10,0>
                       }
                       box {
                         <0,-25.01,-60.1>
                         <60.1,-23.99,60.1>
                         rotate <0,152,0>
                       }
                       box {
                         <0,-24.01,-60.1>
                         <60.1,-22.99,60.1>
                         rotate <0,-12,0>
                       }
                       box {
                         <0,-24.01,-60.1>
                         <60.1,-22.99,60.1>
                         rotate <0,154,0>
                       }
                       box {
                         <0,-23.01,-60.1>
                         <60.1,-21.99,60.1>
                         rotate <0,-14,0>
                       }
                       box {
                         <0,-23.01,-60.1>
                         <60.1,-21.999,60.1>
                         rotate <0,156,0>
                       }
                     }
                     rotate <0,19,0>
                     translate <0,60,0>
                   };

//--objects-------------------------

difference {
  cylinder {
    <0,49.999,0>,
    <0,-49.999,0>,
    66
  }
//----central shaft
  difference {
    object {
      centralShaft
    }
    object {
      stepsL1
      rotate <0,-20,0>
    }
    object {
      stepsL2
      rotate <0,-180,0>
    }
    object {
      stepsL3
    }
    object {
      stepsL3
      rotate <0,-100,0>
    }
    object {
      stepsL4
      rotate <0,90,0>
    }
  }
//----ground level tunnels
  object {
    tunnel
    rotate <0,150,0>
    translate <0,-50,0>
  }
  object {
    tunnel
    rotate <0,-120,0>
    translate <0,-50,0>
  }
  object {
    tunnel
    rotate <0,80,0>
    translate <0,-50,0>
  }
  object {
    tunnel
    rotate <0,70,0>
    translate <0,-30,0>
  }
  object {
    tunnel
    rotate <0,-80,0>
    translate <0,-30,0>
  }
  object {
    tunnel
    rotate <0,-160,0>
    translate <0,-30,0>
  }
  object {
    tunnel
    rotate <0,120,0>
    translate <0,-10,0>
  }
  object {
    tunnel
    rotate <0,40,0>
    translate <0,-10,0>
  }
  object {
    tunnel
    rotate <0,-100,0>
    translate <0,-10,0>
  }
  object {
    tunnel
    rotate <0,-140,0>
    translate <0,10,0>
  }
  object {
    tunnel
    rotate <0,0,0>
    translate <0,10,0>
  }
  object {
    tunnel
    rotate <0,100,0>
    translate <0,10,0>
  }
  object {
    tunnel
    rotate <0,170,0>
    translate <0,30,0>
  }
  object {
    tunnel
    rotate <0,-100,0>
    translate <0,30,0>
  }
  object {
    tunnel
    rotate <0,-30,0>
    translate <0,30,0>
  }
//--tunnels up steps
  object {
    tunnel
    rotate <0,-20,0>
    translate <0,-21.999,0>
  }
  object {
    tunnel
    rotate <0,-180,0>
    translate <0,-1.999,0>
  }
  object {
    tunnel
    rotate <0,0,0>
    translate <0,18.001,0>
  }
  object {
    tunnel
    rotate <0,-100,0>
    translate <0,18.001,0>
  }
  object {
    tunnel
    rotate <0,90,0>
    translate <0,38.001,0>
  }
  texture {
    lumpy
  }
}
  

//--lights--------------------------

#if (editing)
  light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <0, 50, 00>
  }
#else
//--top & bottom lights
  light_source {
    0*x
    color rgb <0,1.5,1.5>
    translate <0,50,0>
  }
  
  light_source {
    0*x
    color rgb <1.5,.75,.75>
    translate <0,-50,0>
  }
//--tunnel lights
  object {
    tunnelLight
    rotate <0,150,0>
    translate <0,-50,0>
  }
  object {
    tunnelLight
    rotate <0,-120,0>
    translate <0,-50,0>
  }
  object {
    tunnelLight
    rotate <0,80,0>
    translate <0,-50,0>
  }
  object {
    tunnelLight
    rotate <0,70,0>
    translate <0,-30,0>
  }
  object {
    tunnelLight
    rotate <0,-80,0>
    translate <0,-30,0>
  }
  object {
    tunnelLight
    rotate <0,-160,0>
    translate <0,-30,0>
  }
  object {
    tunnelLight
    rotate <0,120,0>
    translate <0,-10,0>
  }
  object {
    tunnelLight
    rotate <0,40,0>
    translate <0,-10,0>
  }
  object {
    tunnelLight
    rotate <0,-100,0>
    translate <0,-10,0>
  }
  object {
    tunnelLight
    rotate <0,-140,0>
    translate <0,10,0>
  }
  object {
    tunnelLight
    rotate <0,0,0>
    translate <0,10,0>
  }
  object {
    tunnelLight
    rotate <0,100,0>
    translate <0,10,0>
  }
  object {
    tunnelLight
    rotate <0,170,0>
    translate <0,30,0>
  }
  object {
    tunnelLight
    rotate <0,-100,0>
    translate <0,30,0>
  }
  object {
    tunnelLight
    rotate <0,-30,0>
    translate <0,30,0>
  }
//--raised tunnels
  object {
    tunnelLight
    rotate <0,-20,0>
    translate <0,-22,0>
  }
  object {
    tunnelLight
    rotate <0,-180,0>
    translate <0,-2,0>
  }
  object {
    tunnelLight
    rotate <0,0,0>
    translate <0,18,0>
  }
  object {
    tunnelLight
    rotate <0,-100,0>
    translate <0,18,0>
  }
  object {
    tunnelLight
    rotate <0,90,0>
    translate <0,38,0>
  }
#end

//--camera--------------------------

// perspective (default) camera
#if (editing) 
  camera {
    location <0,170,0>
    look_at <0,0,0>
    rotate <0,40,0>
    right     x*image_width/image_height
  }
#else
  camera {
    location <0,-7,52>
    look_at <0,-7,0>
    rotate <0,40,0>
    right     x*image_width/image_height
  }
#end
