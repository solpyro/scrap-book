// Standard pre-defined colors
#include "colors.inc"
// several different gold colors, finishes and textures
#include "golds.inc"
// various metal colors, finishes and textures
// brass, copper, chrome, silver
#include "metals.inc"
// create a sphere shape
sphere {
  <0, 1, 0> // center of sphere <X Y Z>
  5      // radius of sphere
  scale <1,1,1> // <= Note: Spheres can become ellipses by uneven scaling
  texture { T_Chrome_2A }
}    
// create a box that extends between the 2 specified points
box {
  <8, -4, -5>  // one corner position <X1 Y1 Z1>
  < -8,  -10,  10>  // other corner position <X2 Y2 Z2>
  finish { reflection .35 }
}  
// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <2,2,2>    // light's color
  translate <20, 0, -20>
}   
// perspective (default) camera
camera {
  location  <0, 3, -20>
  look_at   <0, 3, 0>
  right     x*image_width/image_height
}
background {colour SkyBlue}



