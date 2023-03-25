//--global--------------------------
//--includes------------------------
//--declares------------------------

#declare TEXTURE = texture {
                     pigment {
                       colour rgb .6
                     }
                     finish {
                     reflection .8
                     phong .4
                     metallic
                     }
                   };
                   
//--objects-------------------------

union {
  cylinder {
    <0,.6,0>,
    <0,-.6,0>,
    2
  }
  cylinder {
    <-2,.6,.2>,
    <-2,-.6,.2>,
    .3
  }
  cylinder {
    <2,.6,.2>,
    <2,-.6,.2>,
    .3
  }
  sphere {
    <0,-.6,0>,
    2
    scale <1,.6,1>
    translate <0,-.3,0>
  }
  sphere {
    <-2.04,-.6,0>,
    .3
    scale <1,.6,1>
    translate <0,-.28,0>
  }
  sphere {
    <2.04,-.6,0>,
    .3
    scale <1,.6,1>
    translate <0,-.28,0>
  }
  texture {
    TEXTURE
  }
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 0, 40>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <0,0,10>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
