//--global--------------------------
//--includes------------------------
//--declares------------------------

//user controls - feel free to edit these values
#declare bMuzzle = false;

//BE CAREFUL WHEN EDITING PAST THIS POINT!!!!

//mode - controls the textures used
#declare bEdit = false;

//textures
#if (bEdit)
  #declare tSteel = texture {
                     pigment {
                       colour rgb <1,1,0>
                     }
                   }
  #declare tBlue = texture {
                     pigment {
                       colour rgb <1,0,1>
                     }
                   }
  #declare tWhite = texture {
                     pigment {
                       colour rgb <0,1,1>
                     }
                   }
#else
  #declare tSteel = texture {
                     pigment {
                       colour rgb .6
                     }
                     finish {
                       reflection .6
                       phong .2
                       metallic
                     }
                   }
  #declare tBlue = texture {
                     pigment {
                       colour rgb <0,0,1>
                     }
                     finish {
                       phong .3
                       reflection .2
                       metallic
                     }
                   }
  #declare tWhite = texture {
                     pigment {
                       colour rgb <1,1,1>
                     }
                     finish {
                       phong .3
                     }
                   }
#end

//components
#declare oEye = union {
                  //eye
                  difference {
                    sphere {
                      <0,0,0>,.5
                    }                    
                    //pupils
                    cone {
                      <0,0,0>,0,
                      <.5,0,0>,.03
                    }
                    cone {
                      <0,0,0>,0,
                      <.5,0,0>,.03
                      rotate <0,-6,8>
                    }
                    cone {
                      <0,0,0>,0,
                      <.5,0,0>,.03
                      rotate <0,6,8>
                    }
                    texture {
                      tWhite
                    }
                    translate <0,.65,0>
                  }
                  //collar
                  torus {
                    .5,.08
                    texture {
                      tBlue
                    }
                    rotate <0,0,-40>
                    translate <0,.65,0>
                  }
                  translate <1.5,0,0>
                }
#declare oArmLink = union {
                      //joint
                      sphere {
                        <0,0,0>,.25
                        texture {
                          tSteel
                        }               
                      }
                      //collar
                      torus {
                        .23,.02
                        texture {
                          tBlue
                        }
                        rotate <0,0,50>
                        translate <.063,-.056,0>
                      }
                      difference {
                        blob {
                          sphere {
                            <0,0,0>,.4,.2
                            scale <1,.8,.8>
                          }
                          cylinder {
                            <-.3,0,0>,
                            <.6,0,0>,
                            .25, .2
                          }
                          threshold .1
                        }
                        box {
                          -.15,
                          .15
                          translate <.785,0,0>
                        }
                        texture {
                          tBlue
                        }
                        translate <.6,-.2,0>
                      }
                      translate <1.7,-.5,0>
                    }
//objects
#declare oBody = union {
                  //main body
                  sphere {
                    <0,0,0>,
                    2
                    scale <1,.6,1>
                    texture {
                      tBlue
                    }
                  }
                  //belt
                  torus {
                    2,.1
                    texture {
                      tSteel
                    }
                  }
                  //antenna
                  difference {
                    union {
                      cylinder {
                        <0,0,0>,
                        <0,1.3,0>,
                        .4
                      }
                      cylinder {
                        <0,0,0>,
                        <0,2,0>,
                        .3
                      }
                      cylinder {
                        <0,0,0>,
                        <0,2.8,0>,
                        .2
                      }
                    }
                    cylinder {
                      <0,0,0>,
                      <0,2.9,0>,
                      .14
                    }
                    texture {
                      tBlue
                    }
                  }
                  //eyes
                  object {
                    oEye
                  }
                  object {
                    oEye
                    rotate <0,-90,0>
                  }
                  object {
                    oEye
                    rotate <0,90,0>
                  }
                  //extras
                  union {
                    sphere {
                      <1.35,.7,-.8>,.1
                    }
                    sphere {
                      <1.35,.7,.8>,.1
                    }
                    difference {
                      cylinder {
                        <0,0,0>,
                        <2.01,0,0>,
                        .1
                        scale <1,1/.6,1>
                      }
                      box {
                        <2.0,-.04,-.1>,
                        <2.011,.02,.1>
                      }
                      rotate <0,28,12/.6>
                      scale <1,.6,1>
                    }
                    difference {
                      cylinder {
                        <0,0,0>,
                        <2.01,0,0>,
                        .1
                        scale <1,1/.6,1>
                      }
                      box {
                        <2.0,-.04,-.1>,
                        <2.011,.02,.1>
                      }
                      rotate <0,-28,12/.6>
                      scale <1,.6,1>
                    }
                    texture {
                      tSteel
                    }
                  }
                }
#declare oCannon =  union {
                      union {
                        //joint
                        sphere {
                          <0,0,0>,.4
                        }
                        //collar
                        torus {
                          .35,.05
                          rotate <0,0,45>
                          translate <.1,-.1,0>
                        }
                        texture {
                          tBlue
                        } 
                      }
                      //cannon
                      union {
                        difference {
                          union {
                            cylinder {
                              <0,-.1,0>,
                              <.8,-.1,0>,
                              .18
                            }
                            cone {
                              <.8,-.1,0>,.18
                              <.85,-.1,0>,.15
                            }
                            torus {
                              .18,.02
                              rotate <0,0,90>
                              translate <.4,-.1,0>
                            }
                            torus {
                              .18,.02
                              rotate <0,0,90>
                              translate <.45,-.1,0>
                            }
                          }
                          cylinder {
                            <0,-.1,0>,
                            <.851,-.1,0>,
                            .12
                          }
                          cylinder {
                            <.73,-.1,-.181>,
                            <.73,-.1,.181>,
                            .04
                          }
                          cylinder {
                            <.55,-.1,-.181>,
                            <.55,-.1,.181>,
                            .04
                          }
                          box {
                            <.73,-.06,-.181>,
                            <.55,-.14,.181>
                          }
                        }
                        #if (bMuzzle)
                          //muzzle
                          difference {
                            union {
                              cylinder {
                                <.45,-.1,0>,
                                <.81,-.1,0>,
                                .2
                              }
                              cone {
                                <.81,-.1,0>,.2
                                <.86,-.1,0>,.17
                              }
                            }
                            cylinder {
                              <0,-.1,0>,
                              <.838,-.1,0>,
                              .182
                            }
                            cylinder {
                              <.837,-.1,-.115>,
                              <.9,-.1,-.115>,
                              .03
                            }
                            cylinder {
                              <.837,-.1,.115>,
                              <.9,-.1,.115>,
                              .03
                            }
                            box {
                              <.837,-.13,-.115>,
                              <.9,-.07,.115>
                            }
                          }
                          //T-bar
                          box {
                            <.73,-.065,-.3>,
                            <.55,-.135,.3>
                          }
                          difference {
                            box {
                              <.83,-.065,.3>,
                              <.48,-.135,.54>
                            }
                            box {
                              <.79,-.0649,.36>,
                              <.52,-.1351,.48>
                            }
                          }
                        #end 
                        texture {
                          tSteel
                        }
                      }
                      translate <1.6,-.45,0>                    
                    }
#declare oLeftArm = union {
                      //arm
                      object {
                        oArmLink
                      }
                      //hand
                      union {
                        difference {
                          sphere {
                            <0,0,0>,
                            1
                            scale <1,.2,.2>
                          }
                          box {
                            <.75,-1,-1>,
                            <-1,1,1>
                            scale <1,.2,.2>
                          }
                          cylinder {
                            <.75,0,0>,
                            <1.1,0,0>,
                            .015
                          }
                          box {
                            <.8,0,-.015>,
                            <.98,1,.015>
                          }
                          box {
                            <.8,0,-.015>,
                            <.98,1,.015>
                            rotate <120,0,0>
                          }
                          box {
                            <.8,0,-.015>,
                            <.98,1,.015>
                            rotate <-120,0,0>
                          }
                        }
                        //--fingers
                        
                        texture {
                          tSteel
                        }
                        translate <2.18,-.7,0>
                      }
                      rotate 0//<0,-20,0>
                    }
#declare oRightArm = union {
                       object {
                         oArmLink
                       }
                       rotate <0,20,0>
                     }
#declare oLeftLeg = 0;
#declare oRightLeg = 0;
#declare oPod = 0;
                   
//--objects-------------------------

//axis
#if (bEdit)
//--x
  cylinder {
    <0,0,0>,
    <10,0,0>,
    .1
    pigment {
      colour rgb <1,0,0>
    }
  }
//--y
  cylinder {
    <0,0,0>,
    <0,10,0>,
    .1
    pigment {
      colour rgb <0,1,0>
    }
  }
//--z
  cylinder {
    <0,0,0>,
    <0,0,10>,
    .1
    pigment {
      colour rgb <0,0,1>
    }
  }
#end
//tachikoma
union {
//--body
  object {
    oBody
  }
  object {
    oCannon
  }
//--arms
/*  object {
    oLeftArm
  }*/
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <20, 20, 40>
}

//--camera--------------------------

// perspective (default) camera
camera {
  //<8,8,8>    - main view
  //<4,4,4>    - main view zoom
  //<8,-8,8>   - underside view
  //<5,.65,0>  - front eye
  //<5,-.65,0> - cannon
  //<3,-.65,2> - cannon detail
  location  <4,4,4>
  look_at   <2,0,0>
  right     x*image_width/image_height
}


