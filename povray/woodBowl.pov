//--includes------------------------

#include "woods.inc"

//--declares------------------------

#declare vectorX = 0;
#declare vectorY = 0;
#declare vectorZ = 0;    
#declare scaleX = 0;
#declare scaleY = 0;
#declare scaleZ = 0;
#declare rotateX = 0;
#declare rotateY = 0;
#declare rotateZ = 0;
#declare reflectivity = .2;

//--objects-------------------------

plane {
  y, 0
  texture {
    T_Wood8
  }
  finish {
    reflection .4
  }
}
//--pyramid of balls
difference {  
//----bottom layer 
  sphere {
    <6, 6, 6>, 6
  }
  sphere {
    <6, 6, 6>, 5.4
  }                
  box {
    <0, 6, 0>, <12, 12, 12>
  } 
  texture {
    T_Wood7
  }
  finish {
    reflection reflectivity 
    roughness .9
  }
  translate <vectorX, vectorY, vectorZ> 
  scale <scaleX, scaleY, scaleZ> 
  rotate <rotateX, rotateY, rotateZ>
}

//--lights-------------------------- 

light_source {
  0*x                 
  color rgb <2, 2, 2>    
  translate <-5, 15, -5>
}

//--camera--------------------------

camera {
  location  <12, 12, -12>
  look_at   <6, 4, 6>
  right     x*image_width/image_height
}

