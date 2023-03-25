//--declares-----------------------------

#declare sharedColour = colour rgb <.2, .3, 1>;

//--objects------------------------------

//reflection
sphere {
  <5, 5, 5>, 5
  // show reflections, but not the object directly
  no_image
  no_shadow
  pigment {
    sharedColour
  }
}
//object
box {
  <0, 0, 0>  // one corner position <X1 Y1 Z1>
  <10, 10, 10>  // other corner position <X2 Y2 Z2>
  pigment {
    sharedColour
  }
  no_shadow
  no_reflection
} 
// clipped conical shape
// cone { <END1>, RADIUS1, <END2>, RADIUS2 [open] }
// Where <END1> and <END2> are vectors defining the x,y,z
// coordinates of the center of each end of the cone
// and RADIUS1 and RADIUS2 are float values for the radii
// of those ends.  open, if present, cone is hollow, else capped
cone {
  <5, 0, 5>,  5,
  <5, 10, 5>, 0
  no_image
  no_reflection
}

plane {
  y, 
  0
  pigment {
    colour rgb <.5, .5, .5>
  }
  finish {
    reflection .8
  }
} 

//--lights------------------------------ 

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-10, 20, -10>
}

//--camera------------------------------

// perspective (default) camera
camera {
  location  <5, 15, -25>
  look_at   <5, 5, 5>
  right     x*image_width/image_height
}

