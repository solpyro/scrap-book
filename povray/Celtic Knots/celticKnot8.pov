//--includes------------------------
//--declares------------------------

//knot 1
#declare colour1R = 1;
#declare colour1G = 0;
#declare colour1B = 0;
//knot 2
#declare colour2R = 0;
#declare colour2G = 1;
#declare colour2B = 0;
//knot 3
#declare colour3R = 0;
#declare colour3G = 0;
#declare colour3B = 1;
//ribbon size
#declare sphereRadius = .3;
//crossover distance
#declare distanceSpacing = .1;
//oriinal rotation
#declare rotation = 0;
 
//--objects-------------------------

//knot 1
union {
//--red knot
  sphere_sweep {
    cubic_spline
    59,
    <-5, 4, -distanceSpacing>, sphereRadius
    <-5.5, 5.5, 0>, sphereRadius //corner
    <-4, 5, distanceSpacing>, sphereRadius
    <-3, 4, -distanceSpacing>, sphereRadius
    <-2, 3, distanceSpacing>, sphereRadius
    <-1, 2, -distanceSpacing>, sphereRadius
    <0, 1.5, 0>, sphereRadius //corner
    <1, 2, distanceSpacing>, sphereRadius
    <2, 3, -distanceSpacing>, sphereRadius
    <3, 4, distanceSpacing>, sphereRadius
    <4, 5, -distanceSpacing>, sphereRadius
    <5.5, 5.5, 0>, sphereRadius //corner
    <5, 4, distanceSpacing>, sphereRadius
    <4, 3, -distanceSpacing>, sphereRadius
    <3, 2.5, 0>, sphereRadius //corner
    <2, 3, distanceSpacing>, sphereRadius
    <1, 4, -distanceSpacing>, sphereRadius
    <0, 5, distanceSpacing>, sphereRadius
    <-1, 5.5, 0>, sphereRadius //corner
    <-2, 5, -distanceSpacing>, sphereRadius
    <-3, 4, distanceSpacing>, sphereRadius
    <-4, 3, -distanceSpacing>, sphereRadius
    <-5, 2, distanceSpacing>, sphereRadius
    <-5.5, 1, 0>, sphereRadius //corner
    <-5, 0, -distanceSpacing>, sphereRadius
    <-4, -1, distanceSpacing>, sphereRadius
    <-3.5, -2, 0>, sphereRadius //corner
    <-4, -3, -distanceSpacing>, sphereRadius
    <-5, -4, distanceSpacing>, sphereRadius
    <-5.5, -5.5, 0>, sphereRadius //corner
    <-4, -5, -distanceSpacing>, sphereRadius
    <-3, -4, distanceSpacing>, sphereRadius
    <-2, -3, -distanceSpacing>, sphereRadius
    <-1, -2, distanceSpacing>, sphereRadius
    <0, -1.5, 0>, sphereRadius //corner
    <1, -2, -distanceSpacing>, sphereRadius
    <2, -3, distanceSpacing>, sphereRadius
    <3, -4, -distanceSpacing>, sphereRadius
    <4, -5, distanceSpacing>, sphereRadius
    <5.5, -5.5, 0>, sphereRadius //corner
    <5, -4, -distanceSpacing>, sphereRadius
    <4, -3, distanceSpacing>, sphereRadius
    <3.5, -2, 0>, sphereRadius //corner
    <4, -1, -distanceSpacing>, sphereRadius
    <5, 0, distanceSpacing>, sphereRadius
    <5.5, 1, 0>, sphereRadius //corner
    <5, 2, -distanceSpacing>, sphereRadius
    <4, 3, distanceSpacing>, sphereRadius
    <3, 4, -distanceSpacing>, sphereRadius
    <2, 5, distanceSpacing>, sphereRadius
    <1, 5.5, 0>, sphereRadius //corner
    <0, 5, -distanceSpacing>, sphereRadius
    <-1, 4, distanceSpacing>, sphereRadius
    <-2, 3, -distanceSpacing>, sphereRadius
    <-3, 2.5, 0>, sphereRadius //corner
    <-4, 3, distanceSpacing>, sphereRadius
    <-5, 4, -distanceSpacing>, sphereRadius
    <-5.5, 5.5, 0>, sphereRadius //corner
    <-4, 5, distanceSpacing>, sphereRadius
    pigment {
      colour rgb <colour1R, colour1G, colour1B>
    }
  }
//--green knot
  #while (rotation < 2)
    sphere_sweep {
      cubic_spline
      27,
      <-1, 2, distanceSpacing>, sphereRadius
      <0, 3, -distanceSpacing>, sphereRadius
      <1, 4, distanceSpacing>, sphereRadius
      <2, 5, -distanceSpacing>, sphereRadius
      <3, 5.5, 0>, sphereRadius //corner
      <4, 5, distanceSpacing>, sphereRadius
      <5, 4, -distanceSpacing>, sphereRadius
      <5.5, 3, 0>, sphereRadius //corner
      <5, 2, distanceSpacing>, sphereRadius
      <4, 1, -distanceSpacing>, sphereRadius
      <3, 0, distanceSpacing>, sphereRadius
      <2, -1, -distanceSpacing>, sphereRadius
      <1, -2, distanceSpacing>, sphereRadius
      <0, -3, -distanceSpacing>, sphereRadius
      <-1, -4, distanceSpacing>, sphereRadius
      <-2, -5, -distanceSpacing>, sphereRadius
      <-3, -5.5, 0>, sphereRadius //corner
      <-4, -5, distanceSpacing>, sphereRadius
      <-5, -4, -distanceSpacing>, sphereRadius
      <-5.5, -3, 0>, sphereRadius //corner
      <-5, -2, distanceSpacing>, sphereRadius
      <-4, -1, -distanceSpacing>, sphereRadius
      <-3, 0, distanceSpacing>, sphereRadius
      <-2, 1, -distanceSpacing>, sphereRadius
      <-1, 2, distanceSpacing>, sphereRadius
      <0, 3, -distanceSpacing>, sphereRadius
      <1, 4, distanceSpacing>, sphereRadius
      pigment {
        colour rgb <colour2R, colour2G, colour2B>
      }
      rotate <0, 0, 90*rotation>
    }
    #declare rotation = rotation + 1;
  #end
  sphere_sweep {
    cubic_spline
    39,
    <-1, 0, distanceSpacing>, sphereRadius
    <0, .5, 0>, sphereRadius //corner
    <1, 0, -distanceSpacing>, sphereRadius
    <2, -1, distanceSpacing>, sphereRadius
    <2.5, -2, 0>, sphereRadius //corner
    <2, -3, -distanceSpacing>, sphereRadius
    <1, -4, distanceSpacing>, sphereRadius
    <0, -5, -distanceSpacing>, sphereRadius
    <-1, -5.5, 0>, sphereRadius //corner
    <-2, -5, distanceSpacing>, sphereRadius
    <-3, -4, -distanceSpacing>, sphereRadius
    <-4, -3, distanceSpacing>, sphereRadius
    <-5, -2, -distanceSpacing>, sphereRadius
    <-5.5, -1, 0>, sphereRadius //corner
    <-5, 0, distanceSpacing>, sphereRadius
    <-4, 1, -distanceSpacing>, sphereRadius
    <-3, 1.5, 0>, sphereRadius //corner
    <-2, 1, distanceSpacing>, sphereRadius
    <-1, 0, -distanceSpacing>, sphereRadius
    <0, -.5, 0>, sphereRadius //corner
    <1, 0, distanceSpacing>, sphereRadius
    <2, 1, -distanceSpacing>, sphereRadius
    <3, 1.5, 0>, sphereRadius //corner
    <4, 1, distanceSpacing>, sphereRadius
    <5, 0, -distanceSpacing>, sphereRadius
    <5.5, -1, 0>, sphereRadius //corner
    <5, -2, distanceSpacing>, sphereRadius
    <4, -3, -distanceSpacing>, sphereRadius
    <3, -4, distanceSpacing>, sphereRadius
    <2, -5, -distanceSpacing>, sphereRadius
    <1, -5.5, 0>, sphereRadius //corner
    <0, -5, distanceSpacing>, sphereRadius
    <-1, -4, -distanceSpacing>, sphereRadius
    <-2, -3, distanceSpacing>, sphereRadius
    <-2.5, -2, 0>, sphereRadius //corner
    <-2, -1, -distanceSpacing>, sphereRadius
    <-1, 0, distanceSpacing>, sphereRadius
    <0, .5, 0>, sphereRadius //corner
    <1, 0, -distanceSpacing>, sphereRadius
    pigment {
      colour rgb <colour3R, colour3G, colour3B>
    }
  }
  scale <5, 5, 5>
  rotate <45, 0, -45>
  translate <15, 25, -15>
}
//orb on pedastal
union {
  cone {
    <0, -11, 0>, 5
    <0, -3, 0>, 2
    pigment {
      colour rgb <.2, .2, .2>
    }
    finish { 
      reflection .4
    }
  }
  sphere {
    <0, -3, 0>, 5
    pigment {
      colour rgb <.7, .7, .7>
    }
    finish {
      reflection .85
    }
  }
}
//floor
plane {
  y, -11
  pigment {
    colour rgb <.3, .3, .3>
  }
  finish {
    reflection .4
  }
}
//back wall
plane {
  z, 50
  pigment {
    colour rgb <.3, .3, .3>
  }
}

//--lights-------------------------- 

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 20, -10>
}

//--camera--------------------------  

// perspective (default) camera
camera {
  location  <10, 5, -10>
  look_at   <0, -3, 0>
  right     x*image_width/image_height
}
