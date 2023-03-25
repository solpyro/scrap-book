//--includes------------------------
//--declares------------------------

#declare dist = .5;
global_settings {
  photons {
    spacing .2
    jitter 1
  }
}

//--objects-------------------------
    
//plane
plane {
  y, -.5
  pigment {
    colour rgb <.5, .5, .5>
  }
  finish {
    reflection .2
  }
}
//knot
sphere_sweep {
  cubic_spline                
  12, 
  <1.5, 2.6, -dist>, .5                         
  <0, 0, 0>, .5               
  <3, 0, dist>, .5               
  <4.5, 2.6, -dist>, .5
  <3, 5.2, 0>, .5
  <1.5, 2.6, dist>, .5
  <3, 0, -dist>, .5
  <6, 0, 0>, .5
  <4.5, 2.6, dist>, .5
  <1.5, 2.6, -dist>, .5
  <0, 0, 0>, .5
  <3, 0, dist>, .5
  pigment {
    colour rgbt <1, .1, .1, .75>
  }  
  finish {
    reflection .2
  }
  photons {  // photon block for an object
    target 1.0
    refraction on
    reflection on
  }
  interior {
    ior 1.5
    fade_power 1001
    fade_distance 0.9
    fade_color <1, .1, .1>
  }
} 

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 40, -20> 
  photons {           // photon block for a light source
    refraction on
    reflection on
  }
}
 
//--camera--------------------------  

// perspective (default) camera
camera {
  location  <3, 3, -10>
  look_at   <3, 3, 0>
  right     x*image_width/image_height
}