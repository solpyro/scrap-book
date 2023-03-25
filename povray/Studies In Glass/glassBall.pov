// various glass finishes, colors and interiors
#include "glass.inc"
// create a sphere shape
// Persistence of Vision Ray Tracer Scene Description File
// File: ?.pov
// Vers: 3.6
// Desc: Photon Scene Template
// Date: mm/dd/yy
// Auth: ?
//

#version 3.6;

#declare Photons=on;

global_settings {
  assumed_gamma 1.0
  max_trace_level 5
  #if (Photons)          // global photon block
    photons {
      //spacing 0.02                 // specify the density of photons
      count 100000               // alternatively use a total number of photons

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

//--pigments-------------------------

#declare Col_Glass_Ruby=colour rgbf <1, .7, .65, .85>;

//--objects--------------------------

sphere {
  <0, 10, 0> // center of sphere <X Y Z>
  5       // radius of sphere
  material {
    texture {
      pigment { Col_Glass_Ruby }
      finish {
        diffuse 0.15
        specular 0.4
        roughness 0.03
        conserve_energy
      }
    }
  }
  photons {
  target 1
    reflection on
    refraction on
  }
  interior {
    ior 1.35
    fade_power 1001
    fade_distance 0.9
    fade_color Col_Glass_Ruby
  }
} 
// An infinite planar surface
// plane {<A, B, C>, D } where: A*x + B*y + C*z = D
plane {
  y, // <X Y Z> unit surface normal, vector points "away from surface"
  0 // distance from the origin in the direction of the surface normal
  pigment { colour rgb <.1, 1, .1> }
}
// set a color of the background (sky)
background { color rgb <0.1, 0.3, 0.8> } 

//--lights--------------------------------------------------

// create a point "spotlight" (conical directed) light source
light_source {
  0*x                     // light's position (translated below)
  color rgb <3,3,3>       // light's color
  spotlight               // this kind of light source
  translate <10, 21, -20> // <x y z> position of light
  point_at <0, 10, 0>      // direction of spotlight
  radius 10                // hotspot (inner, in degrees)
  tightness 50            // tightness of falloff (1...100) lower is softer, higher is tighter
  falloff 8               // intensity falloff radius (outer, in degrees)
} 

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1.2,1.2,1.2>    // light's color
  translate <0,40,0>
}


//--camera-----------------------------------------
   
// perspective (default) camera
camera {
  location  <0, 13, -20>
  look_at   <0, 11,  0>
  right     x*image_width/image_height
}      