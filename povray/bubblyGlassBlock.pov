// various glass finishes, colors and interiors
#include "glass.inc"
// general math functions and macros
#include "math.inc" 

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

//--declares-------------------------------------- 
                                                  
#declare bubbleCount = 0;
#declare randomL = seed(237);
#declare randomS = seed(87);
#declare varRough = 1;

//--objects---------------------------------------

difference { 
//cuboid glass block
  prism {
    linear_sweep
    linear_spline
    0, 10, 4,
    <0,0>,<0,5>,<5,5>,<5,0>
    pigment {
      colour Col_Glass_Bluish
    }
    rotate y*-20
    translate <0, 0, 0>
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
//large air bubbles
  #while (bubbleCount < 7)
    sphere {
      <rand(randomL)*8,rand(randomL)*8,rand(randomL)*15>,  
      0.25
      pigment {
        colour Col_Glass_Bluish
      }
      finish {
        roughness varRough
      }
    }
    #declare bubbleCount = bubbleCount+1;   // increment our counter
  #end 
//small air bubbles        
  #while (bubbleCount < 124)
    sphere {
      <rand(randomS)*8,rand(randomS)*8,rand(randomS)*8>,  
      0.125
      pigment {
        colour Col_Glass_Bluish
      }
      finish {
        roughness varRough
      }
    }
    #declare bubbleCount = bubbleCount+1;   // increment our counter
  #end
} 
//floor  
plane {
  y,
  0
  pigment {
    colour rgb <.3, 0, .8>
  }
}    
//wall
plane {
  z,
  20
  pigment {
    colour rgb <.1, 0, .2>
  }
}


//--lights----------------------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 40, -20>
}
// create a point "spotlight" (conical directed) light source
light_source {
  0*x                     // light's position (translated below)
  color rgb <1,1,1>       // light's color
  spotlight               // this kind of light source
  translate <30, 20, -15> // <x y z> position of light
  point_at <2.5, 5, 2.5>      // direction of spotlight
  radius 5                // hotspot (inner, in degrees)
  tightness 50            // tightness of falloff (1...100) lower is softer, higher is tighter
  falloff 8               // intensity falloff radius (outer, in degrees)
}
// create a point "spotlight" (conical directed) light source
light_source {
  0*x                     // light's position (translated below)
  color rgb <1,1,1>       // light's color
  spotlight               // this kind of light source
  translate <0, 20, 0> // <x y z> position of light
  point_at <2.5, 0, 2.5>      // direction of spotlight
  radius 1.5                // hotspot (inner, in degrees)
  tightness 50            // tightness of falloff (1...100) lower is softer, higher is tighter
  falloff 8               // intensity falloff radius (outer, in degrees)
}


//--camera----------------------------------------
 
// perspective (default) camera
camera {
  location  <0.0, 8, -11.0>
  look_at   <-2, 6,  0.0>
  right     x*image_width/image_height
}
                 
