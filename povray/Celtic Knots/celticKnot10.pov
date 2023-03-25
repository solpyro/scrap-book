//--global--------------------------
//--includes------------------------
//--declares------------------------ 

#declare sphereRadius = .2;
#declare distanceSpacing = .1;
#declare brownRibbon = colour rgb <1, .5, .5>;
#declare darkBlueRibbon = colour rgb <0, 0, 1>;
#declare lightBlueRibbon = colour rgb <.6, .6, 1>;
#declare redRibbon = colour rgb <1, 0, 0>; 
#declare rotation = 0;

//--objects-------------------------

//knot
union {
//--brown ribbon
  sphere_sweep {
    cubic_spline,
    35,
    <-0.78, 2.9, distanceSpacing>, sphereRadius
    <0, 4, 0>, sphereRadius //corner
    <0.78, 2.9, -distanceSpacing>, sphereRadius
    <1, 1.73, distanceSpacing>, sphereRadius
    <0.71, 0.71, 0>, sphereRadius //corner
    <1.73, 1, -distanceSpacing>, sphereRadius
    <2.9, 0.78, distanceSpacing>, sphereRadius
    <4, 0, -distanceSpacing>, sphereRadius
    <4.83, -1.29, distanceSpacing>, sphereRadius
    <5.2, -3, 0>, sphereRadius //corner
    <3.54, -3.54, -distanceSpacing>, sphereRadius
    <2, -3.46, distanceSpacing>, sphereRadius
    <0.78,-2.9, -distanceSpacing>, sphereRadius
    <0, -2, distanceSpacing>, sphereRadius
    <-0.26, -0.97, 0>, sphereRadius //corner
    <-0.85, -1.81, 0>, sphereRadius //corner
    <-0.78, -2.9, -distanceSpacing>, sphereRadius
    <0, -4, 0>, sphereRadius //corner
    <0.78, -2.9, distanceSpacing>, sphereRadius
    <0.85, -1.81, 0>, sphereRadius //corner
    <0.26, -0.97, 0>, sphereRadius //corner
    <0, -2, -distanceSpacing>, sphereRadius
    <-0.78, -2.9, distanceSpacing>, sphereRadius
    <-2, -3.46, -distanceSpacing>, sphereRadius
    <-3.54, -3.54, distanceSpacing>, sphereRadius
    <-5.2, -3, 0>, sphereRadius //corner
    <-4.83, -1.29, -distanceSpacing>, sphereRadius
    <-4, 0, distanceSpacing>, sphereRadius
    <-2.9, 0.78, -distanceSpacing>, sphereRadius
    <-1.73, 1, distanceSpacing>, sphereRadius
    <-0.71, 0.71, 0>, sphereRadius //corner
    <-1, 1.73, -distanceSpacing>, sphereRadius
    <-0.78, 2.9, distanceSpacing>, sphereRadius
    <0, 4, 0>, sphereRadius //corner
    <0.78, 2.9, -distanceSpacing>, sphereRadius
    pigment {
      brownRibbon
    }
  }
//--light blue ribbon
  sphere_sweep {
    cubic_spline,
    27,
    <-1.29, 4.83, -distanceSpacing>, sphereRadius 
    <0.00, 4.50, 0>, sphereRadius //corner
    <1.29, 4.83, distanceSpacing>, sphereRadius
    <3.00, 5.20, 0>, sphereRadius //corner
    <3.54, 3.54, -distanceSpacing>, sphereRadius
    <3.90, 2.25, 0>, sphereRadius //corner
    <4.83, 1.29, distanceSpacing>, sphereRadius
    <6.00, 0.00, 0>, sphereRadius //corner
    <4.83, -1.29, -distanceSpacing>, sphereRadius
    <3.90, -2.25, 0>, sphereRadius //corner
    <3.54, -3.54, distanceSpacing>, sphereRadius
    <3.00, -5.20, 0>, sphereRadius //corner
    <1.29, -4.83, -distanceSpacing>, sphereRadius
    <0.00, -4.50, 0>, sphereRadius //corner
    <-1.29, -4.83, distanceSpacing>, sphereRadius
    <-3.00, -5.20, 0>, sphereRadius //corner
    <-3.54, -3.54, -distanceSpacing>, sphereRadius
    <-3.90, -2.25, 0>, sphereRadius //corner
    <-4.83, -1.29, distanceSpacing>, sphereRadius
    <-6.00, 0.00, 0>, sphereRadius //corner
    <-4.83, 1.29, -distanceSpacing>, sphereRadius
    <-3.90, 2.25, 0>, sphereRadius //corner
    <-3.54, 3.54, distanceSpacing>, sphereRadius
    <-3.00, 5.20, 0>, sphereRadius //corner
    <-1.29, 4.83, -distanceSpacing>, sphereRadius
    <0.00, 4.50, 0>, sphereRadius //corner
    <1.29, 4.83, distanceSpacing>, sphereRadius
    pigment {
      lightBlueRibbon
    }
  }
//--dark blue ribbon
  sphere_sweep {
    cubic_spline,
    35,
    <-1.29, 4.83, distanceSpacing>, sphereRadius
    <0.00, 6.00, 0>, sphereRadius //corner
    <1.29, 4.83, -distanceSpacing>, sphereRadius
    <1.69, 3.63, 0>, sphereRadius //corner
    <0.78, 2.90, distanceSpacing>, sphereRadius
    <0.00, 2.00, -distanceSpacing>, sphereRadius
    <-0.26, 0.97, 0>, sphereRadius //corner
    <-1.00, 1.73, distanceSpacing>, sphereRadius
    <-2.12, 2.12, -distanceSpacing>, sphereRadius
    <-3.03, 1.75, 0>, sphereRadius //corner
    <-2.90, 0.78, distanceSpacing>, sphereRadius
    <-2.00, 0.00, -distanceSpacing>, sphereRadius
    <-0.97, -0.26, 0>, sphereRadius //corner
    <-1.73, -1.00, distanceSpacing>, sphereRadius
    <-2.12, -2.12, -distanceSpacing>, sphereRadius
    <-2.00, -3.46, distanceSpacing>, sphereRadius
    <-1.29, -4.83, -distanceSpacing>, sphereRadius
    <0.00, -6.00, 0>, sphereRadius //corner
    <1.29, -4.83, distanceSpacing>, sphereRadius
    <2.00, -3.46, -distanceSpacing>, sphereRadius
    <2.12, -2.12, distanceSpacing>, sphereRadius
    <1.73, -1.00, -distanceSpacing>, sphereRadius
    <0.97, -0.26, 0>, sphereRadius //corner
    <2.00, 0.00, distanceSpacing>, sphereRadius
    <2.90, 0.78, -distanceSpacing>, sphereRadius
    <3.03, 1.75, 0>, sphereRadius //corner
    <2.12, 2.12, distanceSpacing>, sphereRadius
    <1.00, 1.73, -distanceSpacing>, sphereRadius
    <0.26, 0.97, 0>, sphereRadius //corner
    <0.00, 2.00, distanceSpacing>, sphereRadius
    <-0.78, 2.90, -distanceSpacing>, sphereRadius
    <-1.69, 3.63, 0>, sphereRadius //corner
    <-1.29, 4.83, distanceSpacing>, sphereRadius
    <0.00, 6.00, 0>, sphereRadius //corner
    <1.29, 4.83, -distanceSpacing>, sphereRadius
    pigment {
      darkBlueRibbon
    } 
  }
//--red ribbons
  #while (rotation < 2)
    sphere_sweep {
      cubic_spline,
      19,
      <-4.83, 1.29, distanceSpacing>, sphereRadius
      <-5.20, 3.00, 0>, sphereRadius //corner
      <-3.54, 3.54, -distanceSpacing>, sphereRadius
      <-2.29, 3.28, 0>, sphereRadius //corner
      <-2.12, 2.12, distanceSpacing>, sphereRadius
      <-1.73, 1.00, -distanceSpacing>, sphereRadius
      <-0.97, 0.26, 0>, sphereRadius //corner
      <-2.00, 0.00, distanceSpacing>, sphereRadius
      <-2.90, -0.78, -distanceSpacing>, sphereRadius
      <-3.03, -1.75, 0>, sphereRadius //corner
      <-2.12, -2.12, distanceSpacing>, sphereRadius
      <-1.15, -1.64, 0>, sphereRadius //corner
      <-0.71, -0.71, 0>, sphereRadius //corner
      <-1.73, -1.00, -distanceSpacing>, sphereRadius
      <-2.90, -0.78, distanceSpacing>, sphereRadius
      <-4.00, 0.00, -distanceSpacing>, sphereRadius
      <-4.83, 1.29, distanceSpacing>, sphereRadius
      <-5.20, 3.00, 0>, sphereRadius //corner
      <-3.54, 3.54, -distanceSpacing>, sphereRadius
      pigment {
        redRibbon
      }
      rotate <0, 180*rotation, 0>
    }
  #declare rotation = rotation + 1;
  #end
      
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
  location  <0.0, 2.0, -15.0>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}

