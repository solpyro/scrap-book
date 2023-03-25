//--global--------------------------
//--includes------------------------

//--declares------------------------
                          
//--objects-------------------------

// uses image color index as height, extends along X-Z axes
// from <0 0 0> to <1 1 1>
height_field {
  sys               // the file type to read (tga/pot/pgm/ppm/png/sys)
  "bitmap1.bmp"     // the file name to read
//  [smooth]        // smooth surface normal
  water_level .2 // truncate/clip below N (0.0 ... 1.0)
//  texture {...}
//  translate VECTOR | rotate VECTOR | scale VECTOR
  pigment {
    colour rgb <.6,.3,0>
  }
  translate <-1,0,-3>
}
height_field {
  sys               // the file type to read (tga/pot/pgm/ppm/png/sys)
  "bitmap1.bmp"     // the file name to read
//  [smooth]        // smooth surface normal
  water_level .2 // truncate/clip below N (0.0 ... 1.0)
//  texture {...}
//  translate VECTOR | rotate VECTOR | scale VECTOR
  pigment {
    colour rgb <.8,.4,0>
  }
  scale <.7,1,.7>
  translate <-.85,0.001,-2.85>
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 40, -20>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <1.0, 2.0, -5.0>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
