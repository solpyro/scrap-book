//--global--------------------------
//--includes------------------------
//--declares------------------------

//mode
#declare bEdit = false;

//textures
#if (bEdit)

  #declare glassT = texture {
                      pigment {
                        colour rgb <1,0,0>
                      }
                    };
  #declare tableT = texture {
                      pigment {
                        colour rgb <0,1,0>
                      }
                    };
  #declare juiceT = texture {
                      pigment {
                        colour rgb <0,0,1>
                      }
                    };
  
#else  
  global_settings {
    assumed_gamma 1.0
    max_trace_level 5
      photons {
        count 200000               // alternatively use a total number of photons
        jitter 1.0                 // jitter phor photon rays
      }
  }
  #declare glassT = texture {
                      pigment { color rgbf <0.98, 0.98, 0.98, 0.9> }
                      finish {
                        ambient 0.1
                        diffuse 0.1
                        reflection 0.1
                        specular 0.8
                        roughness 0.003
                        phong .2                        
                        phong_size 400
                      }
                     };
  #declare tableT = texture {
                      pigment{
                        wood
                        turbulence 0.04
                        octaves 3
                        scale <0.05, .05, 1>
                        color_map {
                          [0.00 color rgb <0.5, 0.25, 0.125>]
                          [0.40 color rgb <1.0, 0.50, 0.250>]
                          [0.60 color rgb <1.0, 0.50, 0.250>]
                          [1.00 color rgb <0.5, 0.25, 0.125>]
                        }
                      }
                    }
                    texture {
                      pigment{
                        wood
                        turbulence <0.1, 0.5, 1>
                        octaves 5
                        lambda 3.25
                        scale <0.15, .5, 1>
                        rotate <5, 10, 5>
                        translate -x*2
                        color_map {  
                          [0.00 0.30 color rgb <0.35, 0.175, 0.0875> 
                                     color rgb <1.00, 0.500, 0.2500>]
                        }
                      }
                    }
  #declare juiceT = texture {
                      pigment {
                        colour rgbt <1,.5,0,.5>
                      }
                    } 
#end
                   
//--objects-------------------------

//--table
box {
  <-10,-10,-10>,
  <10,0,10>
  texture {
    tableT
  }
  no_reflection
}
//--glass
union {
  difference {
    cylinder {
      <0,0.01,0>,
      <0,7,0>,
      2.5
    }
    cylinder {
      <0,1,0>,
      <0,8,0>,
      2.4
    }
  }
  torus {
    2.45,
    0.05
    translate <0,7,0>
  }
  texture {
    glassT
  }
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
}
//--juice
cylinder {
  <0,1,0>,
  <0,5,0>,
  2.39
  texture {
    juiceT
  }
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
  location  <0,8,-15>
  look_at   <0,5,0>
  right     x*image_width/image_height
}
