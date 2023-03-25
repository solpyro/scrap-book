//--global--------------------------
//--includes------------------------
//--declares------------------------

#declare rock = colour rgb <.9, .85, .6>;
#declare crystal = colour rgbt <.9, .2, .9, .7>;
#declare f_sphere = function(x,y,z,a) { sqrt(pow(x,2) + pow(y,2) + pow(z,2)) - a }
#declare f_cylinder = function(a,b,c) { pow(a,2) + pow(b,2) - c }  // cylinder function
#declare fP_granite = function { 
                        pigment {
                          granite
                            color_map {
                              [0 color rgb 1]
                              [1 color rgb 0]
                            }
                          }
                        }
#declare fP_crystal = function {
                        pigment {
                          crackle
                            colour_map {
                              [0 colour rgb 1]
                              [1 colour rgb 0]
                            }
                          }
                        }
#declare cutAway = union {
                     box {
                       <-2, -2, -2>, <2, 2, 0>
                     }
                     /*difference {
                       sphere {
                         0, 3
                       }
                       isosurface {
                         function { f_cylinder(x,y,1)-fP_granite(x,y,z).grey*.2 }        // alternative declared function
                         contained_by { box { -2, 2 } }  // container shape
                         threshold 0.2                     // optional threshold value for isosurface [0.0]
                         accuracy 0.001                     // accuracy of calculation [0.001]
                         max_gradient 2                      // maximum gradient the function can have [1.1]
                         hollow off
                       }
                     }*/
                   }

//--objects-------------------------

union {
  //--shell
  difference {
    isosurface {
      function { f_sphere(x,y,z,1.5)-fP_granite(x,y,z).grey*.05 }        // alternative declared function
      contained_by { box { -2, 2 } }  // container shape
      threshold 0.2                     // optional threshold value for isosurface [0.0]
      accuracy 0.001                     // accuracy of calculation [0.001]
      max_gradient 2                      // maximum gradient the function can have [1.1]
      //evaluate 5, 1.2, 0.95             // evaluate the maximum gradient
      //max_trace 1                       // maybe increase for use in CSG [1]
      //all_intersections                 // alternative to 'max_trace'
      //open                              // remove visible container surface
      hollow off
      pigment {
        rock
      }
    }
    isosurface {
      function { f_sphere(x,y,z,1.3)-fP_granite(x,y,z).grey*.05 }        // alternative declared function
      contained_by { box { -2, 2 } }  // container shape
      threshold 0.2                     // optional threshold value for isosurface [0.0]
      accuracy 0.001                     // accuracy of calculation [0.001]
      max_gradient 2                      // maximum gradient the function can have [1.1]
      //evaluate 5, 1.2, 0.95             // evaluate the maximum gradient
      //max_trace 1                       // maybe increase for use in CSG [1]
      //all_intersections                 // alternative to 'max_trace'
      //open                              // remove visible container surface
      pigment {
        rock
      }
    }
    object {
      cutAway
    }
    pigment {
      rock
    }
  }
//--crystals
  difference {
    isosurface {
      function { f_sphere(x,y,z,1.3)-fP_granite(x,y,z).grey*.05 }        // alternative declared function
      contained_by { box { -2, 2 } }  // container shape
      threshold 0.2                     // optional threshold value for isosurface [0.0]
      accuracy 0.001                     // accuracy of calculation [0.001]
      max_gradient 2                      // maximum gradient the function can have [1.1]
      //evaluate 5, 1.2, 0.95             // evaluate the maximum gradient
      //max_trace 1                       // maybe increase for use in CSG [1]
      //all_intersections                 // alternative to 'max_trace'
      //open                              // remove visible container surface
      pigment {
        crystal
      }
    }
    isosurface {
      function { f_sphere(x,y,z,.8)-fP_crystal(4*x,4*y,4*z).grey*.4 }        // alternative declared function
      contained_by { box { -2, 2 } }  // container shape
      threshold 0.2                     // optional threshold value for isosurface [0.0]
      accuracy 0.001                     // accuracy of calculation [0.001]
      max_gradient 2                      // maximum gradient the function can have [1.1]
      //evaluate 5, 1.2, 0.95             // evaluate the maximum gradient
      //max_trace 1                       // maybe increase for use in CSG [1]
      //all_intersections                 // alternative to 'max_trace'
      //open                              // remove visible container surface
      pigment {
        crystal
      }
    }
    object {
      cutAway
    }
    pigment {
      crystal
    }
  }
  rotate y*45
  translate <-.5, 0, 0>
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-0, 0, -0>
}
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-0, 0, -20>
}


//--camera--------------------------

// perspective (default) camera
camera {
  location  <0.0, 0.0, -4.0>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
