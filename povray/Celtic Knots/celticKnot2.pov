//--includes------------------------
//--declares------------------------ 

//main knot    
#declare colour1R = 1;
#declare colour1G = 0;
#declare colour1B = 0;
//secondary loop
#declare colour2R = 0;
#declare colour2G = 1;
#declare colour2B = 0;
//ribbon size
#declare sphereRadius = .3;
//crossover distance
#declare distanceSpacing = .1;
//oriinal rotation
#declare rotation = 0;

//--objects-------------------------

#while (rotation < 360)   
  union {
    sphere_sweep {
      cubic_spline
      45,
      <.5, .5, -distanceSpacing>, sphereRadius
      <-.5, .5, distanceSpacing>, sphereRadius
      <-2, 1, -distanceSpacing>, sphereRadius
      <-3, 2, distanceSpacing>, sphereRadius
      <-4, 2.5, 0>, sphereRadius  //corner
      <-5, 2, -distanceSpacing>, sphereRadius
      <-6, 1, distanceSpacing>, sphereRadius
      <-7.5, .5, 0>, sphereRadius  //corner
      <-7, 2, -distanceSpacing>, sphereRadius
      <-6, 3, distanceSpacing>, sphereRadius
      <-5, 4, -distanceSpacing>, sphereRadius
      <-4, 5, distanceSpacing>, sphereRadius
      <-3, 6, -distanceSpacing>, sphereRadius
      <-2, 7, distanceSpacing>, sphereRadius
      <-.5, 7.5, 0>, sphereRadius  //corner
      <-1, 6, -distanceSpacing>, sphereRadius
      <-2, 5, distanceSpacing>, sphereRadius
      <-3, 4, -distanceSpacing>, sphereRadius
      <-4, 3.5, 0>, sphereRadius  //corner
      <-5, 4, distanceSpacing>, sphereRadius
      <-6, 5, -distanceSpacing>, sphereRadius                                                                           
      <-6, 6, distanceSpacing>, sphereRadius
      <-5.5, 6.5, 0>, sphereRadius  //corner
      <-4, 7, -distanceSpacing>, sphereRadius
      <-3, 6, distanceSpacing>, sphereRadius
      <-2, 5, -distanceSpacing>, sphereRadius
      <-1, 4, distanceSpacing>, sphereRadius
      <-.5, 3, 0>, sphereRadius  //corner
      <-1, 2, -distanceSpacing>, sphereRadius
      <-2, 1, distanceSpacing>, sphereRadius
      <-3, .5, 0>, sphereRadius  //corner
      <-4, 1, -distanceSpacing>, sphereRadius
      <-5, 2, distanceSpacing>, sphereRadius
      <-6, 3, -distanceSpacing>, sphereRadius
      <-7, 4, distanceSpacing>, sphereRadius
      <-6.5, 5.5, 0>, sphereRadius  //corner
      <-6, 6, -distanceSpacing>, sphereRadius
      <-5, 6, distanceSpacing>, sphereRadius
      <-4, 5, -distanceSpacing>, sphereRadius
      <-3, 4, distanceSpacing>, sphereRadius
      <-2, 3, -distanceSpacing>, sphereRadius
      <-1, 2, distanceSpacing>, sphereRadius
      <-.5, .5, -distanceSpacing>, sphereRadius
      <-.5, -.5, distanceSpacing>, sphereRadius
      <-1, -2, -distanceSpacing>, sphereRadius
      pigment {
        colour rgb <colour1R, colour1G, colour1B>
      }
    }
    sphere_sweep {
      cubic_spline
      19,
      <-1, 4, -sphereRadius>, sphereRadius
      <-.5, 5, 0>, sphereRadius  //corner
      <-1, 6, sphereRadius>, sphereRadius
      <-2, 7, -sphereRadius>, sphereRadius
      <-3, 7.5, 0>, sphereRadius  //corner
      <-4, 7, sphereRadius>, sphereRadius
      <-5, 6, -sphereRadius>, sphereRadius
      <-6, 5, sphereRadius>, sphereRadius
      <-7, 4, -sphereRadius>, sphereRadius
      <-7.5, 3, 0>, sphereRadius  //corner
      <-7, 2, sphereRadius>, sphereRadius
      <-6, 1, -sphereRadius>, sphereRadius
      <-5, .5, 0>, sphereRadius  //corner
      <-4, 1, sphereRadius>, sphereRadius
      <-3, 2, -sphereRadius>, sphereRadius
      <-2, 3, sphereRadius>, sphereRadius
      <-1, 4, -sphereRadius>, sphereRadius
      <-.5, 5, 0>, sphereRadius  //corner
      <-1, 6, sphereRadius>, sphereRadius
      pigment {
        colour rgb <colour2R, colour2G, colour2B> 
      }
    }
    rotate <0, 0, rotation>
  }
  #declare rotation = rotation + 90; 
#end

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <0, 40, -20>
}

//--camera--------------------------  

// perspective (default) camera
camera {
  location  <0, 0, -20>
  look_at   <0, 0,  0>
  right     x*image_width/image_height
}
