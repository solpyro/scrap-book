//--global--------------------------
//--includes------------------------
//--declares------------------------

//harddrive
#declare counter = 0;
#declare harddrive = union {
                     //--wheels
                     //--base unit
                       difference {
                         box {
                           <-.9, -1, -1>,
                           <.9, .6, 1>
                           pigment {
                             colour rgb <0, 0, 0>
                           }
                           hollow
                         }
                         #while (counter < .5)
                           box {
                             <-.8, .5, -1.1>,
                             <.8, .4, -.9>
                             translate <0, -counter*2, 0>
                             colour rgb <0,1,0>
                           }
                           #declare counter = counter + .1;
                         #end
                       }
                     //----interior
                       box {
                         <-.8, -.9, -.9>,
                         <.8, .5, .9>
                         pigment  {
                           colour rgb <1, 1, 1>
                         }
                       }
                     //----edges
                       box {
                         <-1, -1, -1>,
                         <-.9, .6, 1>
                         pigment {
                           colour rgb <1, 1, 1>
                         }
                       }
                       box {
                         <1, -1, -1>,
                         <.9, .6, 1>
                         pigment {
                           colour rgb <1, 1, 1>
                         }
                       }
                     };
                       
//--objects-------------------------

object {
  harddrive
}
plane {
  y,
  -1.1
  pigment {
    colour rgb <.8, .8, 0>
  }
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
  location  <1.5, 3.0, -5.0>
  look_at   <1.5, 0.0,  0.0>
  right     x*image_width/image_height
}