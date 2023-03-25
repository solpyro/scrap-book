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
//secondary loop
#declare colour3R = 0;
#declare colour3G = 0;
#declare colour3B = 1;
//secondary loop
#declare colour4R = 1;
#declare colour4G = 1;
#declare colour4B = 0;
//ribbon size
#declare sphereRadius = .3;
//crossover distance
#declare distanceSpacing = .1;
//oriinal rotation
#declare rotation = 0;
 
//--objects-------------------------

//knot
union {
//--cross piece
//----main loop
  sphere_sweep {
    cubic_spline
    107,
    <-1, 0, -distanceSpacing>, sphereRadius               
    <0, .7, 0>, sphereRadius  //corner
    <1, 0, distanceSpacing>, sphereRadius
    <2, -1, -distanceSpacing>, sphereRadius
    <3, -1.7, 0>, sphereRadius  //corner
    <4, -1, distanceSpacing>, sphereRadius
    <5, 0, -distanceSpacing>, sphereRadius
    <6, 1, distanceSpacing>, sphereRadius
    <7, 1.7, 0>, sphereRadius  //corner
    <8, 1, -distanceSpacing>, sphereRadius
    <9, 0, distanceSpacing>, sphereRadius               
    <10.5, -.5, 0>, sphereRadius  //corner
    <10, 1, -distanceSpacing>, sphereRadius
    <9, 1.7, 0>, sphereRadius  //corner
    <8, 1, distanceSpacing>, sphereRadius
    <7, 0, -distanceSpacing>, sphereRadius
    <6, -1, distanceSpacing>, sphereRadius
    <5, -1.7, 0>, sphereRadius  //corner
    <4, -1, -distanceSpacing>, sphereRadius
    <3.3, 0, 0>, sphereRadius  //corner
    <4, 1, distanceSpacing>, sphereRadius               
    <5, 1.7, 0>, sphereRadius  //corner
    <6, 1, -distanceSpacing>, sphereRadius
    <7, 0, distanceSpacing>, sphereRadius
    <8, -1, -distanceSpacing>, sphereRadius
    <9, -1.7, 0>, sphereRadius  //corner
    <11, -1.7, 0>, sphereRadius  //corner
    <11.7, -1, 0>, sphereRadius  //corner
    <11.7, 1, 0>, sphereRadius  //corner
    <11, 1.7, 0>, sphereRadius  //corner
    <10, 1, distanceSpacing>, sphereRadius               
    <9, 0, -distanceSpacing>, sphereRadius
    <8, -1, distanceSpacing>, sphereRadius
    <7, -1.7, 0>, sphereRadius  //corner
    <6, -1, -distanceSpacing>, sphereRadius
    <5, 0, distanceSpacing>, sphereRadius
    <4, 1, -distanceSpacing>, sphereRadius
    <3, 1.7, 0>, sphereRadius  //corner
    <2, 1, distanceSpacing>, sphereRadius
    <1, 0, -distanceSpacing>, sphereRadius
    <.5, -1.5, 0>, sphereRadius  //corner               
    <2, -1, distanceSpacing>, sphereRadius
    <2.7, 0, 0>, sphereRadius  //corner
    <2, 1, -distanceSpacing>, sphereRadius
    <1, 2, distanceSpacing>, sphereRadius
    <0, 3, -distanceSpacing>, sphereRadius
    <-1, 4, distanceSpacing>, sphereRadius
    <-1.7, 5, 0>, sphereRadius  //corner
    <-1, 6, -distanceSpacing>, sphereRadius
    <-.3, 7, 0>, sphereRadius  //corner
    <-1, 8, distanceSpacing>, sphereRadius               
    <-1.7, 9, 0>, sphereRadius  //corner
    <-1, 10, -distanceSpacing>, sphereRadius
    <0, 10.7, 0>, sphereRadius  //corner
    <1, 10, distanceSpacing>, sphereRadius
    <1.7, 9, 0>, sphereRadius  //corner
    <1, 8, -distanceSpacing>, sphereRadius
    <.3, 7, 0>, sphereRadius  //corner
    <1, 6, distanceSpacing>, sphereRadius
    <1.7, 5, 0>, sphereRadius  //corner
    <1, 4, -distanceSpacing>, sphereRadius               
    <0, 3, distanceSpacing>, sphereRadius
    <-1, 2, -distanceSpacing>, sphereRadius
    <-2, 1, distanceSpacing>, sphereRadius
    <-2.7, 0, 0>, sphereRadius  //corner
    <-2, -1, -distanceSpacing>, sphereRadius
    <-.5, -1.5, 0>, sphereRadius  //corner
    <-1, 0, distanceSpacing>, sphereRadius
    <-2, 1, -distanceSpacing>, sphereRadius
    <-3, 1.7, 0>, sphereRadius  //corner
    <-4, 1, distanceSpacing>, sphereRadius               
    <-5, 0, -distanceSpacing>, sphereRadius
    <-6, -1, distanceSpacing>, sphereRadius
    <-7, -1.7, 0>, sphereRadius  //corner
    <-8, -1, -distanceSpacing>, sphereRadius
    <-9, 0, distanceSpacing>, sphereRadius
    <-10, 1, -distanceSpacing>, sphereRadius
    <-11, 1.7, 0>, sphereRadius  //corner
    <-11.7, 1, 0>, sphereRadius  //corner
    <-11.7, -1, 0>, sphereRadius  //corner
    <-11, -1.7, 0>, sphereRadius  //corner               
    <-9, -1.7, 0>, sphereRadius  //corner
    <-8, -1, distanceSpacing>, sphereRadius
    <-7, 0, -distanceSpacing>, sphereRadius
    <-6, 1, distanceSpacing>, sphereRadius
    <-5, 1.7, 0>, sphereRadius  //corner
    <-4, 1, -distanceSpacing>, sphereRadius
    <-3.3, 0, 0>, sphereRadius  //corner
    <-4, -1, distanceSpacing>, sphereRadius
    <-5, -1.7, 0>, sphereRadius  //corner
    <-6, -1, -distanceSpacing>, sphereRadius               
    <-7, 0, distanceSpacing>, sphereRadius
    <-8, 1, -distanceSpacing>, sphereRadius
    <-9, 1.7, 0>, sphereRadius  //corner
    <-10, 1, distanceSpacing>, sphereRadius
    <-10.5, -.5, 0>, sphereRadius  //corner
    <-9, 0, -distanceSpacing>, sphereRadius
    <-8, 1, distanceSpacing>, sphereRadius
    <-7, 1.7, 0>, sphereRadius  //corner
    <-6, 1, -distanceSpacing>, sphereRadius
    <-5, 0, distanceSpacing>, sphereRadius
    <-4, -1, -distanceSpacing>, sphereRadius
    <-3, -1.7, 0>, sphereRadius  //corner
    <-2, -1, distanceSpacing>, sphereRadius
    <-1, 0, -distanceSpacing>, sphereRadius
    <0, .7, 0>, sphereRadius  //corner
    <1, 0, distanceSpacing>, sphereRadius
    pigment {
      colour rgb <colour1R, colour1G, colour1B>
    }
  }
//----second loop
  sphere_sweep {
    cubic_spline
    25,
    <-1, 2, distanceSpacing>, sphereRadius
    <0, 1.3, 0>, sphereRadius  //corner
    <1, 2, -distanceSpacing>, sphereRadius
    <1.7, 3, 0>, sphereRadius  //corner
    <1, 4, distanceSpacing>, sphereRadius
    <0, 5, -distanceSpacing>, sphereRadius
    <-1, 6, distanceSpacing>, sphereRadius
    <-1.7, 7, 0>, sphereRadius  //corner
    <-1, 8, -distanceSpacing>, sphereRadius
    <0, 9, distanceSpacing>, sphereRadius
    <1, 10, -distanceSpacing>, sphereRadius
    <1.7, 11, 0>, sphereRadius  //corner
    <0, 11.7, 0>, sphereRadius  //corner
    <-1.7, 11, 0>, sphereRadius  //corner
    <-1, 10, distanceSpacing>, sphereRadius
    <0, 9, -distanceSpacing>, sphereRadius
    <1, 8, distanceSpacing>, sphereRadius
    <1.7, 7, 0>, sphereRadius  //corner
    <1, 6, -distanceSpacing>, sphereRadius
    <0, 5, distanceSpacing>, sphereRadius
    <-1, 4, -distanceSpacing>, sphereRadius
    <-1.7, 3, 0>, sphereRadius  //corner
    <-1, 2, distanceSpacing>, sphereRadius
    <0, 1.3, 0>, sphereRadius  //corner
    <1, 2, -distanceSpacing>, sphereRadius
    pigment {
      colour rgb <colour2R, colour2G, colour2B>
    }
  }
//--semicircle
  #while (rotation < 2)
    union {
//----main loop
      sphere_sweep {
        cubic_spline
        51,
        <3.68, 1.52, -distanceSpacing>, sphereRadius
        <2.1, 2.1, distanceSpacing>, sphereRadius
        <.57, 2.94, 0>, sphereRadius  //corner
        <1.52, 3.68, -distanceSpacing>, sphereRadius
        <3.5, 3.5, distanceSpacing>, sphereRadius
        <4.98, 3.36, -distanceSpacing>, sphereRadius
        <6.44, 2.66, distanceSpacing>, sphereRadius
        <7.84, 1.52, -distanceSpacing>, sphereRadius
        <9.405, .95, 0>, sphereRadius  //corner
        <8.28, 3.42, distanceSpacing>, sphereRadius
        <6.64, 4.48, -distanceSpacing>, sphereRadius
        <5.25, 5.25, 0>, sphereRadius  //corner
        <4.48, 6.64, distanceSpacing>, sphereRadius
        <3.42, 8.28, -distanceSpacing>, sphereRadius
        <.95, 9.405, 0>, sphereRadius  //corner
        <1.52, 7.84, distanceSpacing>, sphereRadius
        <2.66, 6.44, -distanceSpacing>, sphereRadius
        <3.36, 4.98, distanceSpacing>, sphereRadius
        <3.5, 3.5, -distanceSpacing>, sphereRadius
        <3.68, 1.52, distanceSpacing>, sphereRadius
        <2.94, 0.57, 0>, sphereRadius  //corner
        <2.1, 2.1, -distanceSpacing>, sphereRadius
        <1.52, 3.68, distanceSpacing>, sphereRadius
        <0.6, 4.9, 0>, sphereRadius  //corner
        <1.14, 5.88, -distanceSpacing>, sphereRadius
        <2.66, 6.44, distanceSpacing>, sphereRadius
        <4.48, 6.64, -distanceSpacing>, sphereRadius
        <6.3, 6.3, distanceSpacing>, sphereRadius
        <7.885, 5.32, 0>, sphereRadius  //corner
        <8.28, 3.42, -distanceSpacing>, sphereRadius
        <7.84, 1.52, distanceSpacing>, sphereRadius
        <6.93, .7, 0>, sphereRadius  //corner
        <5.88, 1.14, -distanceSpacing>, sphereRadius
        <4.6, 1.9, 0>, sphereRadius  //corner
        <4.98, 3.36, distanceSpacing>, sphereRadius
        <4.55, 4.55, 0>, sphereRadius  //corner
        <3.36, 4.98, -distanceSpacing>, sphereRadius
        <1.9, 4.6, 0>, sphereRadius  //corner
        <1.14, 5.88, distanceSpacing>, sphereRadius
        <.6, 6.86, 0>, sphereRadius  //corner
        <1.52, 7.84, -distanceSpacing>, sphereRadius
        <3.42, 8.28, distanceSpacing>, sphereRadius
        <5.32, 7.885, 0>, sphereRadius  //corner
        <6.3, 6.3, -distanceSpacing>, sphereRadius  
        <6.64, 4.48, distanceSpacing>, sphereRadius
        <6.44, 2.66, -distanceSpacing>, sphereRadius
        <5.88, 1.14, distanceSpacing>, sphereRadius
        <4.95, .5, 0>, sphereRadius  //corner
        <3.68, 1.52, -distanceSpacing>, sphereRadius
        <2.1, 2.1, distanceSpacing>, sphereRadius
        <.57, 2.94, 0>, sphereRadius  //corner
        pigment {
          colour rgb <colour3R, colour3G, colour3B>
        }
      }
//----second loop
      sphere_sweep {
        cubic_spline
        7,
        <.5, 1.3, 0>, sphereRadius
        <.3, .3, 0>, sphereRadius
        <1.3, .5, 0>, sphereRadius
        <1.5, 1.5, 0>, sphereRadius
        <.5, 1.3, 0>, sphereRadius
        <.3, .3, 0>, sphereRadius
        <1.3, .5, 0>, sphereRadius
        pigment {
          colour rgb <colour4R, colour4G, colour4B>
        }
      }
      translate <2, 2, 0>
      rotate <0, 0, 90*rotation>
    }
    #declare rotation = rotation + 1;
  #end
}

//--lights--------------------------

light_source {
  0*x 
  color rgb <1,1,1> 
  translate <-20, 40, -20>
}
 
//--camera--------------------------  

camera {
  location  <0, 2, -20>
  look_at   <0, 5.5, 0>
  right     x*image_width/image_height
}
