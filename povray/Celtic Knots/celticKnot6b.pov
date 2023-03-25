//--includes------------------------

#include "woods.inc"
 
//--declares------------------------

#declare sphereRadius = .2;
#declare distanceSpacing = .1;
#declare loop1 = T_Wood6 ;
#declare loop2 = T_Wood8;
#declare rotation = 0;

//--objects-------------------------

//knot
#while (rotation < 4)
  union {
//--loop1
    sphere_sweep {
      cubic_spline
      12,
      <-1.5, -3, 0>, sphereRadius //corner
      <0, 0, 0>, sphereRadius //corner
      <1.5, 2, 0>, sphereRadius //corner
      <1, 3, -distanceSpacing>, sphereRadius
      <.5, 4, 0>, sphereRadius //corner
      <1, 5, distanceSpacing>, sphereRadius
      <2, 6, -distanceSpacing>, sphereRadius
      <3, 6.5, 0>, sphereRadius //corner
      <4, 6, distanceSpacing>, sphereRadius
      <5, 5.5, 0>, sphereRadius //corner
      <8, 7, -distanceSpacing>, sphereRadius
      <10, 8.5, -distanceSpacing>, sphereRadius
      texture {
        loop1
      }
    }
    sphere_sweep {
      cubic_spline
      18,
      <10, 5.5, 0>, sphereRadius //corner
      <8, 7, distanceSpacing>, sphereRadius
      <7.2, 7.37, -distanceSpacing>, sphereRadius
      <6, 8, distanceSpacing>, sphereRadius
      <5, 8.5, 0>, sphereRadius //corner
      <4, 8, -distanceSpacing>, sphereRadius
      <3, 7.5, 0>, sphereRadius //corner
      <2, 8, distanceSpacing>, sphereRadius
      <1, 8.5, 0>, sphereRadius //corner
      <0, 8, -distanceSpacing>, sphereRadius
      <-1, 7, distanceSpacing>, sphereRadius
      <-1.5, 6, 0>, sphereRadius //corner
      <-1, 5, -distanceSpacing>, sphereRadius
      <-.5, 4, 0>, sphereRadius //corner
      <-1, 3, distanceSpacing>, sphereRadius
      <-1.5, 2, 0>, sphereRadius //corner
      <0, 0, -distanceSpacing>, sphereRadius
      <1.5, -3, 0>, sphereRadius //corner
      texture {
        loop1
      }
    }
//--loop2
    sphere_sweep {
      cubic_spline
      33,
      <-1, 7, -distanceSpacing>, sphereRadius
      <-1.5, 8.5, 0>, sphereRadius //corner
      <0, 8, distanceSpacing>, sphereRadius
      <1, 7, -distanceSpacing>, sphereRadius
      <2, 6, distanceSpacing>, sphereRadius
      <3, 5, -distanceSpacing>, sphereRadius
      <4, 4, 0>, sphereRadius //corner
      <3, 3, 0>, sphereRadius //corner
      <2, 3.5, 0>, sphereRadius //corner
      <1, 3, distanceSpacing>, sphereRadius
      <0, 2.5, 0>, sphereRadius //corner
      <-1, 3, -distanceSpacing>, sphereRadius
      <-1.5, 4, 0>, sphereRadius //corner
      <-1, 5, distanceSpacing>, sphereRadius
      <0, 6, -distanceSpacing>, sphereRadius
      <1, 7, distanceSpacing>, sphereRadius
      <2, 8, -distanceSpacing>, sphereRadius
      <3, 8.5, 0>, sphereRadius //corner
      <4, 8, distanceSpacing>, sphereRadius
      <5, 7, -distanceSpacing>, sphereRadius
      <6, 6.5, 0>, sphereRadius //corner
      <7, 7, distanceSpacing>, sphereRadius
      <8.5, 8.5, 0>, sphereRadius //corner
      <6, 8, -distanceSpacing>, sphereRadius
      <5, 7, distanceSpacing>, sphereRadius
      <4, 6, -distanceSpacing>, sphereRadius
      <3, 5, distanceSpacing>, sphereRadius
      <2, 4.5, 0>, sphereRadius //corner
      <1, 5, -distanceSpacing>, sphereRadius
      <0, 6, distanceSpacing>, sphereRadius
      <-1, 7, -distanceSpacing>, sphereRadius
      <-1.5, 8.5, 0>, sphereRadius //corner
      <0, 8, distanceSpacing>, sphereRadius
      texture {
        loop2
      }
    }
    translate <-7.5, .5, 0>
    rotate <0, 0, 90*rotation>
  }
  #declare rotation = rotation + 1;
#end
      
//--lights-------------------------- 

light_source {
  0*x                  // light's position (translated below)
  color rgb <3, 3, 3>    // light's color
  translate <-20, 40, -20>
}

//--camera--------------------------  

// perspective (default) camera
camera {
  location  <0.0, 2.0, -25>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
