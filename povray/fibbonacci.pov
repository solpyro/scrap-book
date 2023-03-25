//--includes------------------------
//--declares------------------------ 
//--objects-------------------------

// create a curved tube object translating a sphere along a certain path
sphere_sweep {
  b_spline                // alternative spline curves
  //b_spline
  10,
  <0, 0, 0>, 1                            // number of specified sphere positions
  <0, 1, 0>, 1                // position, radius
  <1, 0, 0>, 1                 // ...
  <0, -2, 0>, 1
  <-3, 0, 0>, 1
  <0, 5, 0>, 1
  <8, 0, 0>, 1
  <0, -13, 0>, 1
  <-21, 0, 0>, 1
  <0, 34, 0>, 1
  //tolerance 0.001             // optional
  pigment {
    colour rgb <1, 0, 0>
  }
  rotate <0, 0, 180>
}


//--lights-------------------------- 

// An area light (creates soft shadows)
// WARNING: This special light can significantly slow down rendering times!
light_source {
  0*x                 // light's position (translated below)
  color rgb 1.0       // light's color
  area_light
  <8, 0, 0> <0, 0, 8> // lights spread out across this distance (x * z)
  4, 4                // total number of lights in grid (4x*4z = 16 lights)
  adaptive 0          // 0,1,2,3...
  jitter              // adds random softening of light
  circular            // make the shape of the light circular
  orient              // orient light
  translate <40, 80, -40>   // <x y z> position of light
}

//--camera--------------------------  

// perspective (default) camera
camera {
  location  <0.0, 0, -35>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
