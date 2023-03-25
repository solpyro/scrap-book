//--includes------------------------ 

                                      
                                      
//--declares------------------------   

#declare photon = true;

#if (photon)
                                                              
#declare tGlass = pigment {colour rgbf <0.8, 0.9, 0.85, 0.85>};
#declare tSurface = pigment {colour rgb <.2,.2,.2>};

#else
                                                               
#declare tGlass = pigment{colour rgbt <1,1,1,.5>};
#declare tSurface = pigment {colour rgb <1,0,0>};

#end

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

//glass
union {
  //bowl
  intersection {
    difference {
      sphere {
        <0,0,0>,3
      }
      sphere {
        <0,0,0>,2.9
      }
    }
    box {
    <-4,-2,-4>,<4,2,4>
    }
  }
  //base
  intersection {
    sphere {
      <0,0,0>,3
    }
    box {
      <-4,-2,-4><4,-1.5,4>
    }
  }
  //lip
  torus{
    2.16,.08
    translate <0,1.97,0>
  }
  //rounded base
  cylinder {
    <0,-2,0>,
    <0,-2.05,0>,
    2.16
  }
  torus {
    2.16,.08
    translate <0,-1.97,0>
  }
  texture{tGlass}
  finish{reflection 0.5}
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
}
//table
plane {
  y,-2.05
  texture{tSurface}
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <0, -35, -35>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <0, 5, -10>
  look_at   <0, 0, 0>
  right     x*image_width/image_height
}