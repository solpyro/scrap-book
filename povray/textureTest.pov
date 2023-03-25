//--global--------------------------
//--includes------------------------
//--declares------------------------
//--objects-------------------------

// create a isosurface object - the equipotential surface
// of a 3D math function f(x, y, z)
/*#declare f_sphere = function(x,y,z,a) { sqrt(pow(x,2) + pow(y,2) + pow(z,2)) - a }  // cylinder function
#declare fn_Pigm = function { pigment {
                                granite
                                color_map {
                                  [0 color rgb 1]
                                  [1 color rgb 0]
                                }
                              }
                            }
isosurface {
  //function { x*x + y*y - 1 }          // function (can also contain declared functions
  function { f_sphere(x, y, z, .3)-fn_Pigm(x, y, z).grey*0.5 }        // alternative declared function
  contained_by { sphere { 0, .85 } }  // container shape
  threshold 0.1                     // optional threshold value for isosurface [0.0]
  accuracy 0.001                     // accuracy of calculation [0.001]
  max_gradient 2                      // maximum gradient the function can have [1.1]
  //evaluate 5, 1.2, 0.95             // evaluate the maximum gradient
  //max_trace 1                       // maybe increase for use in CSG [1]
  //all_intersections                 // alternative to 'max_trace'
  //open                              // remove visible container surface
  pigment {
    colour rgbt <0, 1, 0, .0>
  }
}
#undef f_sphere
#undef fn_Pigm

#declare f_sphere = function(x,y,z,a) { sqrt(pow(x,2) + pow(y,2) + pow(z,2)) - a }  // cylinder function
#declare fn_Pigm = function { pigment {
                                agate
                                color_map {
                                  [0 color rgb 1]
                                  [1 color rgb 0]
                                }
                              }
                            }
isosurface {
  //function { x*x + y*y - 1 }          // function (can also contain declared functions
  function { f_sphere(x, y, z, .25)-fn_Pigm(x, y, z).grey*0.5 }        // alternative declared function
  contained_by { sphere { 0, .85 } }  // container shape
  threshold 0.1                     // optional threshold value for isosurface [0.0]
  accuracy 0.001                     // accuracy of calculation [0.001]
  max_gradient 2                      // maximum gradient the function can have [1.1]
  //evaluate 5, 1.2, 0.95             // evaluate the maximum gradient
  //max_trace 1                       // maybe increase for use in CSG [1]
  //all_intersections                 // alternative to 'max_trace'
  //open                              // remove visible container surface
  pigment {
    colour rgbt <0, 0, 1, .0>
  }
}
#undef f_sphere
#undef fn_Pigm*/

#declare f_sphere = function(x,y,z,a) { sqrt(pow(x,2) + pow(y,2) + pow(z,2)) - a }  // cylinder function
#declare fn_Pigm = function { pigment {
                                wrinkles
                                color_map {
                                  [0 color rgb 1]
                                  [1 color rgb 0]
                                }
                              }
                            }
isosurface {
  //function { x*x + y*y - 1 }          // function (can also contain declared functions
  function { f_sphere(x, y, z, .3)-fn_Pigm(x, y, z).grey*0.5 }        // alternative declared function
  contained_by { sphere { 0, .85 } }  // container shape
  threshold 0.1                     // optional threshold value for isosurface [0.0]
  accuracy 0.001                     // accuracy of calculation [0.001]
  max_gradient 2                      // maximum gradient the function can have [1.1]
  //evaluate 5, 1.2, 0.95             // evaluate the maximum gradient
  //max_trace 1                       // maybe increase for use in CSG [1]
  //all_intersections                 // alternative to 'max_trace'
  //open                              // remove visible container surface
  pigment {
    colour rgbt <.7, .7, .7, .0>
  }
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <2, 2, 2>    // light's color
  translate <-20, 40, -20>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <0.0, 0.0, -3>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
