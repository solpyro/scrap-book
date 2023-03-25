// various glass finishes, colors and interiors
#include "glass.inc"

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
            
//--pigments---------------------------------

//  Col_Glass_General

//--objects----------------------------------  

// extrude a closed 2-D shape along an axis
prism {                                
  linear_sweep  // or conic_sweep for tapering to a point
  linear_spline // linear_spline | quadratic_spline | cubic_spline | bezier_spline 
  -0.5,         // height 1
   0.5,         // height 2
  3,           // number of points
  // (--- the <u,v> points ---)
  <0, 0>, <1, 1>, <1, 0>
  // , <0.2,   0.2> // match 2nd point, if quadratic_spline add this
  // , <0.2,  -1.0> // match 1st point, if cubic_spline add this as well as the other
  // [open]
  // [sturm]
  pigment {
    colour Col_Glass_Bluish
  }
  rotate x*-90
  rotate y*-30
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
prism {
  linear_sweep
  linear_spline
  0, 2, 4,
  <0,0>, <0,1>, <1,1>, <1,0>
  pigment {
    colour Col_Glass_Bluish
  }
  translate <-3, 0, 0>
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
// An infinite planar surface
// plane {<A, B, C>, D } where: A*x + B*y + C*z = D
plane {
  y, // <X Y Z> unit surface normal, vector points "away from surface"
  0 // distance from the origin in the direction of the surface normal
  hollow on // has an inside pigment?
  pigment {
    colour rgb <.3, .3, .3>
  } 
} 
plane {
  x, // <X Y Z> unit surface normal, vector points "away from surface"
  3 // distance from the origin in the direction of the surface normal
  hollow on // has an inside pigment?
  pigment {
    colour rgb <1, 1, 1>
  }
  finish {
    reflection 0.7
  }
  rotate y*-20
  translate <-1, 0, 0> 
}




//--lights----------------------------------- 

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
  translate <-10, 12, -10> // <x y z> position of light
  point_at <-1, 0, 1>      // direction of spotlight
  radius 7                // hotspot (inner, in degrees)
  tightness 50            // tightness of falloff (1...100) lower is softer, higher is tighter
  falloff 8               // intensity falloff radius (outer, in degrees)
}


//--camera-----------------------------------

// perspective (default) camera
camera {
  location  <0.0, 3.0, -5.0>
  look_at   <-1, 0.0,  3>
  right     x*image_width/image_height
}
