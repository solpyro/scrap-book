//--global--------------------------
//--includes------------------------
//--declares------------------------

//mode
#declare bEdit = false;

//textures
#if (bEdit)
  #declare tGround = texture {
              pigment {
                colour rgb <1,1,1>
              }
            }
  #declare tBall1 = texture {
             pigment {
               colour rgb <0,0,1>
             }
           }
  #declare tBall2 = texture {
             pigment {
               colour rgb <1,1,0>
             }
           }
  #declare tBall3 = texture {
             pigment {
               colour rgb <0,0,0>
             }
           }
  #declare tBall4 = texture {
             pigment {
               colour rgb <0,1,0>
             }
           }
  #declare tBall5 = texture {
             pigment {
               colour rgb <1,0,0>
             }
           }
#else    
  global_settings {
    assumed_gamma 1.0
    max_trace_level 5
      photons {
        count 200000               // alternatively use a total number of photons
        jitter 1.0                 // jitter phor photon rays
      }
  }
  #declare tGround = texture {
              pigment {
                colour rgb <1,1,1>
              }
            }
  #declare tBall1 = texture {
             pigment { color rgbf <0, 0, 0.98, 0.9> }
               finish {
                 ambient 0.1
                 diffuse 0.1
                 reflection 0.1
                 specular 0.8
                 roughness 0.003
                 phong 1
                 phong_size 400
             }
           }
  #declare tBall2 = texture {
             pigment { color rgbf <0.98, 0.98, 0, 0.9> }
               finish {
                 ambient 0.1
                 diffuse 0.1
                 reflection 0.1
                 specular 0.8
                 roughness 0.003
                 phong 1
                 phong_size 400
             }
           }
  #declare tBall3 = texture {
             pigment { color rgbf <0.1, 0.1, 0.1, 0.9> }
               finish {
                 ambient 0.1
                 diffuse 0.1
                 reflection 0.1
                 specular 0.8
                 roughness 0.003
                 phong 1
                 phong_size 400
             }
           }
  #declare tBall4 = texture {
             pigment { color rgbf <0, 0.98, 0, 0.9> }
               finish {
                 ambient 0.1
                 diffuse 0.1
                 reflection 0.1
                 specular 0.8
                 roughness 0.003
                 phong 1
                 phong_size 400
             }
           }
  #declare tBall5 = texture {
             pigment { color rgbf <0.98, 0, 0, 0.9> }
               finish {
                 ambient 0.1
                 diffuse 0.1
                 reflection 0.1
                 specular 0.8
                 roughness 0.003
                 phong 1
                 phong_size 400
             }
           }
#end
                   
//--objects-------------------------

//--spheres
sphere {
  <-2,0,0>, 1
  texture {
    tBall1
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
sphere {
  <-1,0,-1.5>, 1
  texture {
    tBall2
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
sphere {
  <0,0,0>, 1
  texture {
    tBall3
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
sphere {
  <1,0,-1.5>, 1
  texture {
    tBall4
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
sphere {
  <2,0,0>, 1
  texture {
    tBall5
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
//--plane
plane {
  y, -1
  texture {
    tGround
  }
  no_reflection
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
  location  <0,10,-5>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
