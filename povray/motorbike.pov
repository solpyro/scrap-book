//--global--------------------------
//--includes------------------------

#include "objects.inc";

//--declares------------------------

//--objects-------------------------

object {
  light
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <0, 100, 00>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <0,5,0>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
