//--global--------------------------

background {
  colour rgb .5
}

//--includes------------------------
//--declares------------------------

#declare coding = true;

#if (coding) 
  #declare tyre = texture {
                    pigment {
                      colour rgb <1,1,0>
                    }
                  };
  #declare chrome = texture {
                      pigment {
                        colour rgb <1,0,0>
                      }
                    };
  #declare body = texture {
                    pigment {
                      colour rgb <0,0,1>
                    }
                  };
#else
  #declare tyre = texture {
                    pigment {
                      colour rgb <.1,.1,.1>
                    }
                    finish {
                      phong .2
                      reflection 0
                    }
                  };
  #declare chrome = texture {
                      pigment {
                        colour rgb <.7,.7,.7>
                      }
                      finish {
                        reflection .9
                      }
                    };
  #declare body = texture {
                    pigment {
                      colour rgb <0,0,1>
                    }
                  };
#end

#declare wheelFront = union {
                        difference {
                          torus {
                            2.5, .5
                          }
                          #declare counter = 0;
                          #while (counter<36)
                            union { 
                              sphere_sweep {
                                cubic_spline
                                4
                                <3,1,1>,.05
                                <3,0,0>,.05
                                <2,-2,-2>,.05
                                <0,-3,-2.5>,.05
                              }
                              sphere_sweep {
                                cubic_spline
                                4
                                <3,-1,1>,.05
                                <3,0,0>,.05
                                <2,2,-2>,.05
                                <0,3,-2.5>,.05
                                rotate <0,5,0>
                              }
                              rotate <0,10*counter,0>
                            }
                            #declare counter = counter + 1;
                          #end
                          texture {
                            tyre
                          }
                          rotate <90,0,0>
                        }
                        union {
                          difference {
                            cylinder {
                              <0,0,-.5>,
                              <0,0,.5>,
                              2.2
                            }
                            cone {
                              <0,0,-.501>,2.2,
                              <0,0,0>,0
                            }
                            cone {
                              <0,0,.501>,2.2,
                              <0,0,0>,0
                            }
                            cylinder {
                              <0,0,-.5>,
                              <0,0,.5>,
                              1.8
                            }
                          }  
                          cone {
                            <0,0,0>,2.2,
                            <0,0,.5>,0.1
                          }
                          cone {
                            <0,0,0>,2.2,
                            <0,0,-.5>,0.1
                          }
                        }
                        texture {
                          chrome
                        }
                        rotate <0,0,0>
                      };
#declare wheelBack = union {
                       difference {
                         torus {
                           2.2, .8
                           rotate <90,0,0>
                           scale <1,1,3>
                         }
                         cylinder {
                           <0,0,2.2>,
                           <0,0,-2.2>,
                           2.2
                         }
                         #declare counter = 0;
                         #while (counter<18)
                           union {
                             cone {
                               <0,0,0>,.2
                               <0,-1,0>,0
                               scale <.5,1,1>
                               translate <3,0,0>
                             }
                             cone {
                               <0,0,0>,.2
                               <0,-1,0>,0
                               scale <.5,1,1>
                               translate <3,0,-.7>
                             }
                             cone {
                               <0,0,0>,.2
                               <0,-1,0>,0
                               scale <.5,1,1>
                               translate <2.9,0,-1.4>
                             }
                             cone {
                               <0,0,0>,.2
                               <0,-1,0>,0
                               scale <.5,1,1>
                               translate <3,0,.7>
                             }
                             cone {
                               <0,0,0>,.2
                               <0,-1,0>,0
                               scale <.5,1,1>
                               translate <2.9,0,1.4>
                             }
                             cone {
                               <0,0,0>,.2
                               <0,-1,0>,0
                               scale <.5,1,1>
                               translate <3,0,-.7>
                             }
                             cone {
                               <0,0,0>,.2
                               <0,-1,0>,0
                               scale <.5,1,1>
                               translate <3,0,-.35>
                               rotate <0,0,10>
                             }
                             cone {
                               <0,0,0>,.2
                               <0,-1,0>,0
                               scale <.5,1,1>
                               translate <2.95,0,-1.05>
                               rotate <0,0,10>
                             }
                             cone {
                               <0,0,0>,.2
                               <0,-1,0>,0
                               scale <.5,1,1>
                               translate <3,0,.35>
                               rotate <0,0,10>
                             }
                             cone {
                               <0,0,0>,.2
                               <0,-1,0>,0
                               scale <.5,1,1>
                               translate <2.95,0,1.05>
                               rotate <0,0,10>
                             }
                             rotate <0,0,counter*20>
                           }
                           #declare counter = counter + 1;
                         #end
                         texture {
                           tyre
                         }
                       }
                       difference {
                         cylinder {
                           <0,0,2.2>,
                           <0,0,-2.2>,
                           2.2
                         }
                         cone {
                           <0,0,-2.201>,2.2,
                           <0,0,-.5>,0
                         }
                         cone {
                           <0,0,2.201>,2.2,
                           <0,0,.5>,0
                         }
                         texture {
                           chrome
                         }
                       }
                     };
#declare body = union {
                  difference {
                    union {
                      box {
                        <-12,-1,-8>,
                        <8,8,8>
                      }
                      prism {
                        -4,4,
                        5,
                        <0,0>,<0,-4>,
                        <4,-5>,<4,0>,
                        <0,0>
                        rotate <90,0,90>
                        translate <-6.5,-.5,0>
                      }
                    }
                    box {
                      <0,-1,-8.1>
                      <-12,10,8.1>
                      rotate <0,0,-25>
                      translate <-13,0,0>
                    }
                    box {
                      <5.1,-1,-8>
                      <-12.1,10,0>
                      rotate <30,0,0>
                      translate <0,3.2,-8>
                    }
                    box {
                      <5.1,-1,8>
                      <-12.1,10,0>
                      rotate <-30,0,0>
                      translate <0,3.2,8>
                    }
                    box {
                      <0,-1,-8.1>
                      <12,20,8.1>
                      rotate <0,0,60>
                      translate <10,0,0>
                    }
                    cylinder {
                      <-10,0,-10>,
                      <-10,0,10>,
                      3.5
                    }
                    texture {
                      body
                    }  
                  }
                };

//--objects-------------------------

union {
  /*object {
    wheelFront
    translate <18,0,-5>
  }
  object {
    wheelFront
    translate <18,0,5>
  }
  object {
    wheelBack
    translate <-10,0,-7>
  }
  object {
    wheelBack
    translate <-10,0,7>
  }*/
  object {
    body
  }
  #if (false)
    rotate <0,0,0>
    rotate <0,0,0>
  #else
    rotate <0,-210,0>
    rotate <-25,0,0>
  #end
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 40, -40>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <-5,0,-35>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
