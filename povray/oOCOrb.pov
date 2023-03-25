//--global--------------------------
//--includes------------------------
//--declares------------------------

#declare Green = texture {
                   pigment {
                     colour rgbf <0,1,0,.8>
                   }
                   finish {
                     reflection .8
                     phong .6
                   }
                 };
#declare Black = texture {
                   pigment {
                     colour rgbf <0.1,0.1,0.1,.7>
                   }
                   finish {
                     reflection .7
                     phong .6
                   }
                 };
                 

//--objects-------------------------

union {
  difference {
    union {
      difference {
        cylinder {
          <0,0,-1>,
          <0,0,1>,
          1
        }
        cylinder {
          <0,0,-1.01>,
          <0,0,1.01>,
          .8
        }
      }
      difference {
        cylinder {
          <0,0,-1>,
          <0,0,1>,
          1
        }
        cylinder {
          <0,0,-1.01>,
          <0,0,1.01>,
          .8
        }
        box {
          <-1.01,1.01,-1.01>,
          <1.01,0,1.01>
        }
        translate <0,1,0>
      }
      difference {
        cylinder {
          <0,0,-1>,
          <0,0,1>,
          1
        }
        cylinder {
          <0,0,-1.01>,
          <0,0,1.01>,
          .8
        }
        box {
          <-1.01,-1.01,-1.01>,
          <1.01,0,1.01>
        }
        box {
          <0,-1.01,-1.01>,
          <1.01,1.01,1.01>
        }
        translate <0,-1,0>
      }
      difference {
        cylinder {
          <0,0,-1>,
          <0,0,1>,
          1
        }
        cylinder {
          <0,0,-1.01>,
          <0,0,1.01>,
          .8
        }
        box {
          <-1.01,1.01,-1.01>,
          <1.01,0,1.01>
        }
        box {
          <0,-1.01,-1.01>,
          <1.01,1.01,1.01>
        }
        translate <1,0,0>
      }
      scale <1,1,2>
    }
    difference {
      box {
        -2.1,2.1
      }
      sphere {
        <0,0,0>,1.5
      }
    }
    texture {
      Green
    }
  }
  difference {
    sphere {
      <0,0,0>,1.5
    }
    union {
      difference {
        cylinder {
          <0,0,-1>,
          <0,0,1>,
          1
        }
        cylinder {
          <0,0,-1.01>,
          <0,0,1.01>,
          .8
        }
      }
      difference {
        cylinder {
          <0,0,-1>,
          <0,0,1>,
          1
        }
        cylinder {
          <0,0,-1.01>,
          <0,0,1.01>,
          .8
        }
        box {
          <-1.01,1.01,-1.01>,
          <1.01,0,1.01>
        }
        translate <0,1,0>
      }
      difference {
        cylinder {
          <0,0,-1>,
          <0,0,1>,
          1
        }
        cylinder {
          <0,0,-1.01>,
          <0,0,1.01>,
          .8
        }
        box {
          <-1.01,-1.01,-1.01>,
          <1.01,0,1.01>
        }
        box {
          <0,-1.01,-1.01>,
          <1.01,1.01,1.01>
        }
        translate <0,-1,0>
      }
      difference {
        cylinder {
          <0,0,-1>,
          <0,0,1>,
          1
        }
        cylinder {
          <0,0,-1.01>,
          <0,0,1.01>,
          .8
        }
        box {
          <-1.01,1.01,-1.01>,
          <1.01,0,1.01>
        }
        box {
          <0,-1.01,-1.01>,
          <1.01,1.01,1.01>
        }
        translate <1,0,0>
      }
      scale <1,1,2>
    }
    texture {
      Black
    }
  }
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 40, -20>
}
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <1, 1, 0>
}
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <1, -1, 0>
}
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-1, -1, 0>
}
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-1, 1, 0>
}
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <0, 0, 0>
}


//--camera--------------------------

// perspective (default) camera
camera {
  location  <0.0, 0.0, -10.0>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
