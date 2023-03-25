//--global--------------------------
//--includes------------------------
//--declares------------------------

//mode
#declare bEdit = true;

//textures
#if (bEdit)
  #declare tPebble = texture {
                       pigment {
                         colour rgb <1,0,0>
                       }
                     }
#else  
  #declare tPebble = texture {
                     }
#end
                   
//--objects-------------------------

background {    
        colour rgb <0,1,1>
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
  location  <0,0,-10>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
