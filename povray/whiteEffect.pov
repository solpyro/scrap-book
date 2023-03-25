//--global--------------------------
//--includes------------------------
//--declares------------------------

background {
  colour rgb <1, 1, 1>
}

//--objects-------------------------

sphere {
  <0, 0, 0>, 1
  pigment {
    colour rgb <1,1,1>
  }
}
sphere {
  <0, 0, 0>, 1
  pigment {
    colour rgb <1,1,1>
  }
  translate <-1.5, 0, 0>
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <2,2,2>    // light's color
  translate <-20, 40, -20>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <0.0, 2.0, -5.0>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
