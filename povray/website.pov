//--global--------------------------
//--includes------------------------
//--declares------------------------
//--objects-------------------------

difference {
  box {
    <-4,-2,0>,
    <4,2,.05>
  }
  prism {                                
    conic_sweep  // or conic_sweep for tapering to a point
    linear_spline // linear_spline | quadratic_spline | cubic_spline | bezier_spline 
    0,         // height 1
    2,         // height 2
    5,           // number of points
    // (--- the <u,v> points ---)
    <-2.4,-1.8>,<2.4,-1.8>,
    <2.4,1.8>,<-2.4,1.8>,
    <-2.4,-1.8>
    rotate <-90,0,0>
    scale <.6,.52,1>
    translate <1,0,1.99>
  }
  texture {
    pigment {
      colour rgb <.1,.1,.17>
    }
    finish {
      phong .4
    }
  }
}

background {
  <0,1,0> 
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb 2    // light's color
  translate <-8, 4, -15>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <0,0,-7>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}
