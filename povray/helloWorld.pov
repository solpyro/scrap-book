// internal functions usable in user defined functions
#include "functions.inc"     
// just for colours
#include "colors.inc" 
box { <-1, -1, -1>, <-2, -2, -2> 
      pigment { colour HuntersGreen }
} 
// An infinite planar surface
// plane {<A, B, C>, D } where: A*x + B*y + C*z = D
plane {
  z, // <X Y Z> unit surface normal, vector points "away from surface"
  -4 // distance from the origin in the direction of the surface normal
  pigment { colour MidnightBlue }
}

// perspective (default) camera
camera {
  location  <0.0, 2.0, 5.0>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <5,5,5>    // light's color
  translate <-20, 40, 20>
}
