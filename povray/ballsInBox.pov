// various glass finishes, colors and interiors
#include "glass.inc"
// several different gold colors, finishes and textures
#include "golds.inc"
// various metal colors, finishes and textures
// brass, copper, chrome, silver
#include "metals.inc"
// internal functions usable in user defined functions
// for example for isosurfaces and function pattern
#include "functions.inc"
#version 3.6;

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

//--declares---------------------------------------------------

#declare greenGlass = colour rgbf <0.2, 1, 0.5, 0.95>;
#declare redGlass = colour rgbf <1, .2, .4, .95>;
#declare greenIntencity = 4;
#declare light = 1.7;  

//--objects----------------------------------------------------
  
//the box room
box { <10, -10, 25>, <-10, 10, -25> 
      pigment {colour rgb <.1, .1, .4>}
      finish {
        reflection .4
        roughness .3
      }
      hollow on
}
// create top green glass sphere
sphere {
  <0, 4, 0> // center of sphere <X Y Z>
  5 // radius of sphere
  pigment {colour greenGlass}
  interior {
  ior 1.35
    fade_power 1001
    fade_distance 0.9
    fade_color 0.9
  }
  photons{              // creates photon use
    target 1.0          // spacing multiplier for photons hitting the object
    refraction on
    reflection on
  }
}
// create bottom red glass sphere
sphere {
  <0, -4, 0> // center of sphere <X Y Z>
  5 // radius of sphere
  pigment {colour redGlass}
  interior {
  ior 1.35
    fade_power 1001
    fade_distance 0.9
    fade_color .9
  }
  photons{              // creates photon use
    target 1.0          // spacing multiplier for photons hitting the object
    refraction on
    reflection on
  }
}  

//--lights--------------------------------------------


// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <light,light,light>    // light's color
  translate <-9, 9, -24>
}
//light in the green orb
light_source {
  0*x
  colour rgb <greenIntencity,greenIntencity,greenIntencity>
  translate <0, 4, 0> 
}
//--camera--------------------------------------------

// perspective camera
camera {
  location  <-9, 2, -24>
  look_at   <0, 0, 0>
  right     x*image_width/image_height
}


