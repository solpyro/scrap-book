//--global--------------------------

global_settings {
  assumed_gamma 1.0
  max_trace_level 5
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
}

//--includes------------------------

#include "metals.inc"

//--declares------------------------

#declare counter = 0;
#declare sides = 10;
#declare degree = 360/sides;
#declare sColour = T_Chrome_3E;
#declare sNumber = array[10]{"0","1","2","3","4","5","6","7","8","9"};

//--objects-------------------------

difference {
  intersection {
    cylinder {
      <0, 0, 0>,
      <0, .5, 0>,
      2
    }
    #while (counter < sides)
      cylinder {
        <2, -.1, 0>,
        <2, .6, 0>,
        3.8
        rotate <0, degree*counter, 0>
      }
    #declare counter = counter+1;
    #end
    // create a TrueType text shape
    rotate <0, 18, 0>
    texture {
    sColour
  }
  }
  #declare counter = 0;
  #while (counter < sides)
    text {
      ttf             // font type (only TrueType format for now)
      "crystal.ttf",  // Microsoft Windows-format TrueType font file name
      sNumber[counter],      // the string to create
      .05,              // the extrusion depth
      0               // inter-character spacing
      rotate <0, 0, 90>
      translate <.35, .08, -1.8>
      rotate <0, degree*counter, 0>
    }
    #declare counter = counter + 1;
  #end
  texture {
    sColour
    pigment {
      colour rgb <0, 0, 0>
    }
  }
  scale <.5, .5, .5>
  rotate <0, 0, 0>
}

//--lights--------------------------


light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-2, .25, -10>
}
 
//--camera--------------------------

camera {
  location  <0.0, 2.0, -5.0>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}

