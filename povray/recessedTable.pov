//--global--------------------------
//--includes------------------------
//--declares------------------------

//mode
#declare bEdit = false;

//textures
#if (bEdit)
  #declare mainTexture = texture {
                           pigment {
                             colour rgb <1,1,1>
                           }
                           finish {
                             reflection 0
                           }
                         };
#else  
  
  #declare mainTexture = texture {
                           pigment {
                               agate
                               agate_turb 0.8
                               colour_map {
                                 [0.03 colour <.25,.125,0>]
                                 [0.05 colour <.5,.25,0>]
                                 [0.1 colour <1,.5,0>]
                                 [0.15 colour <.5,.25,0>]
                                 [0.17 colour <.25,.125,0>]
                                 [0.2 colour .25]
                               }
                           }
                         };
   #declare surfaceTexture = texture {
                               pigment {
                                 agate
                                 agate_turb 0.1
                                 colour_map {
                                   [0.1 colour rgbt <0,0,0,0>]
                                   [0.2 colour <1,1,1>]
                                 }
                                 rotate <0,100,0>
                               }
                             };
#end
                   
//--objects-------------------------

union {
  difference {
    box {
      <-20,-4,-10>,
      < 10, 0, 20>
    }
    sphere {
      <0,-.2,0>, 2
    }
    cylinder {
      <0,  1,0>,
      <0,-.25,0>, 2.5
    }
  } 
  torus {
    2.5, .5
    scale <1,.5,1>
    translate <0,-.25,0>
  }
  texture {
    surfaceTexture
  }
}
     
sphere {
  <0,1.5,0>, 2
  texture {
    mainTexture
  }
  no_shadow
} 

background {
  color rgb <.5,.5,.5>
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
  location  <0,5,-5>
  look_at   <0.0, 0.0,  0.0>
  rotate <0,0,-40>
  right     x*image_width/image_height
}
