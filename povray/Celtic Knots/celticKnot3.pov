//--includes------------------------
//--declares------------------------ 

//main knot    
#declare colour1R = 1;
#declare colour1G = 0;
#declare colour1B = 0;
//secondary loop
#declare colour2R = .1;
#declare colour2G = .1;
#declare colour2B = .1;
//ribbon size
#declare sphereRadius = .3;
//crossover distance
#declare distanceSpacing = .1;
//oriinal rotation
#declare rotation = 0;

//--objects-------------------------

union {
  #while (rotation < 2)
    sphere_sweep {
      cubic_spline
      22,
      <2, -3, distanceSpacing>, sphereRadius
      <3.5, -3.5, 0>, sphereRadius  //corner
      <3, -2, -distanceSpacing>, sphereRadius
      <2.5, -1, 0>, sphereRadius  //corner
      <3, 0, distanceSpacing>, sphereRadius
      <3.5, 1, 0>, sphereRadius  //corner
      <3, 2, -distanceSpacing>, sphereRadius
      <2, 3, distanceSpacing>, sphereRadius
      <1, 3.5, 0>, sphereRadius  //corner
      <0, 3.5, 0>, sphereRadius  //corner
      <-1, 3.5, 0>, sphereRadius  //corner
      <-2, 3, -distanceSpacing>, sphereRadius
      <-3, 2, distanceSpacing>, sphereRadius
      <-3.5, 1, 0>, sphereRadius  //corner
      <-3, 0, -distanceSpacing>, sphereRadius
      <-2, -1, distanceSpacing>, sphereRadius
      <-1, -1.5, 0>, sphereRadius  //corner
      <0, -1.5, 0>, sphereRadius  //corner
      <1, -2, -distanceSpacing>, sphereRadius
      <2, -3, distanceSpacing>, sphereRadius
      <3.5, -3.5, 0>, sphereRadius  //corner
      <3, -2, -distanceSpacing>, sphereRadius
      pigment {
        colour rgb <colour1R, colour1G, colour1B>
      }
      rotate <0, 0, rotation*180>  
    }
    sphere_sweep {
      cubic_spline
      14,
      <-1, 0, -distanceSpacing>, sphereRadius
      <0, -.5, 0>, sphereRadius  //corner
      <1, 0, distanceSpacing>, sphereRadius
      <2, 1, -distanceSpacing>, sphereRadius
      <3, 2, distanceSpacing>, sphereRadius
      <3.5, 3.5, 0>, sphereRadius  //corner
      <2, 3, -distanceSpacing>, sphereRadius
      <1, 2.5, 0>, sphereRadius  //corner
      <0, 2.5, 0>, sphereRadius  //corner
      <-1, 2, distanceSpacing>, sphereRadius
      <-1.5, 1, 0>, sphereRadius  //corner
      <-1, 0, -distanceSpacing>, sphereRadius
      <0, -.5, 0>, sphereRadius  //corner
      <1, 0, distanceSpacing>, sphereRadius
      pigment {
        colour rgb <colour2R, colour2G, colour2B>
      }                                    
      rotate <0, 0, 180*rotation>
    }
    #declare rotation = rotation + 1;
  #end
}
plane {
  z, 2
  pigment {
    colour rgb <.3, .3, .3>
  }
}
    
//--lights--------------------------

light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 40, -20>
}

//--camera--------------------------  

camera {
  location  <0, 0, -10>
  look_at   <0, 0, 0>
  right     x*image_width/image_height
}
