//--global--------------------------
//--includes------------------------
//--declares------------------------
//--objects-------------------------

box {
  <-2,-2,-2>,
  < 2, 2, 2>
  pigment {
    colour rgb <1,0,0>
  }
}    

box {
  <-3,-3,-3>,
  <-1,-1,-1>
  pigment {
    colour rgb <0,1,0>
  }
}

box {
  < 3, 3, 3>,
  < 1, 1, 1>
  pigment {
    colour rgb <0,0,1>
  }
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <20, 20, -40>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <-.2,0,-10>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
