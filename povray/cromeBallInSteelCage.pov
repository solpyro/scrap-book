//--includes------------------------
//--declares------------------------
//--objects-------------------------

plane {
  y, 0 
  pigment {
    colour rgb <.4, .4, .4>
  }
  finish {
    reflection .7
  }
}
//steel cage
difference {
  box {
    <0, 0, 0>
    <6, 6, 6>
    pigment {   
      colour rgb <.6, .6, .6>
    }
    finish {
      reflection .6
    }  
    hollow
  }
  sphere {
    <3, 3, 3>, 3.8
  }
}
//chrome ball
sphere {
  <3, 3, 3>, 2.8
  pigment {
    colour rgb <.9, .9, .9>
  }
  finish {
    reflection .7
    roughness .5
  }
}
   
//--lights--------------------------

//area light
light_source {
  0*x 
  color rgb 1.0      
  area_light
  <8, 0, 0> <0, 0, 8>
  4, 4               
  adaptive 0         
  jitter             
  circular           
  orient             
  translate <0, 80, -40>
}
//point light
light_source {
  0*x      
  color rgb <1,1,1>
  translate <-12, 16, -20>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <-3, 8, -8>
  look_at   <3, 3, 3>
  right     x*image_width/image_height
}
