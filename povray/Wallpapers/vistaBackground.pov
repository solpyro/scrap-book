//--global--------------------------

#declare Photons=on;
global_settings {
  assumed_gamma 1.0
  max_trace_level 5
  #if (Photons)          // global photon block
    photons {
      //spacing 0.02                 // specify the density of photons
      count 200000               // alternatively use a total number of photons

      //gather min, max            // amount of photons gathered during render [20, 100]
      //media max_steps [,factor]  // media photons
      jitter 1.0                 // jitter phor photon rays
      //max_trace_level 5          // optional separate max_trace_level
      //adc_bailout 1/255          // see global adc_bailout
      //save_file "filename"       // save photons to file
      //load_file "filename"       // load photons from file
      //autostop 0                 // photon autostop option
      //radius 10                  // manually specified search radius
      // (---Adaptive Search Radius---)
      //steps 1
      //expand_thresholds 0.2, 40
    }

  #end
}

//--includes------------------------

#include "glass.inc"

//--declares------------------------

#declare counter = 0;

//--objects-------------------------

//glass torus with orbital rings
union {
  torus {
    8,
    2
    texture {
      pigment {
        color rgbf <.3,.3,.6,.85>
      }
      finish {
        F_Glass8
      }
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
  #while (counter < 5)
    torus {
      3.5,
      .3
      texture {
        pigment {
          colour rgbt <.2,.2,.7,.5>
        }
        finish {
          F_Glass2
        }
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
      rotate <90,0,0>
      translate <-8,0,0>
      rotate <0,(-20*counter)+50,0>
    }
    #declare counter = counter + 1;
  #end  
  #declare counter = 0;
  rotate <-60,60,0>
  translate <5,0,0>
}
//white sphere in a box
union {
  box {
    -2,2
    texture {
      T_Glass3
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
    0,1.5
    pigment {
      colour rgb 1
    }
  }
  rotate <0,35,0>
  translate <-8,-2,0>
}
//string of rotating boxes
union {
  #while (counter < 20)
    box {
      .5,-.5
      texture {
        pigment {
          colour rgb .1
        }
        finish {
          reflection .4
        }
      }
      rotate <9*counter,0,0>
      translate <0,0,-counter>
    }
    #declare counter = counter + 1;
  #end
  #declare counter = 0;
  rotate <0,110,0>
  translate <5,-4.3,-11>
}
//strange glass tubes
union {  
  sphere_sweep {
    linear_spline,
    2,
    <0,-5,0>,.2,
    <0,20,0>,.3
  }
  sphere_sweep {
    linear_spline,
    2,
    <-.8,-5,.2>,.2,
    <-.8,20,.2>,.3
  }
  sphere_sweep {
    b_spline,
    6,
    <0,-8,0>,.2,
    <0,-6,0>,.2,
    <0,6,0>,.2,
    <0,10,5>,.2
    <0,8,8>,.0
    <0,4,12>,.0
    translate <-.4,0,.8>
  }
  texture {
    pigment {
      colour Col_Glass_Bluish
    }
    finish {
      F_Glass9
    }
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
  rotate <0,90,0>
  translate <-11,0,2>
}
//floor
plane {
  y, -4
  texture {
    pigment {
      colour rgb .1
    }
    finish {
      reflection .4
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

//--camera--------------------------

// perspective (default) camera
camera {
  location  <1.0, 2.0, -20.0>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
