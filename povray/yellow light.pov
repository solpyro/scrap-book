//--global--------------------------

global_settings {
  photons {
    count 200000               // alternatively use a total number of photons
    jitter 1.0                 // jitter phor photon rays
  }
}

//--includes------------------------
//--declares------------------------

#declare steel = texture {
                   pigment {
                     colour rgb .6
                   }
                   finish {
                     reflection .5
                     diffuse .7
                     specular .7
                     roughness .02
                     metallic
                   }
                 };
#declare glass = texture {
                   pigment {
                     colour rgbf <1,1,0,.9>
                   }
                 };

//--objects-------------------------

union {
  union {
    torus {
      2,.5
    }
    difference {
      sphere {
        0,2.5
      }
      sphere {
        0,2
      }
      box {
        <-2.6,0,-2.6>,
        <2.6,2.6,2.6>
      }
    }
    texture {
      steel
    }
  }
  sphere {
    <0,0,0>,2
    texture {
      glass
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
  #if (true)
    light_source {
      0*x                  // light's position (translated below)
      color rgb <1,1,1>    // light's color
      translate <0,0,0>
    }
  #end
  rotate <0,0,90>
  
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 40, 20>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <-10,0,0>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
