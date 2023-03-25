//--includes------------------------

#include "woods.inc"

//--declares------------------------

//----pyramid
#declare vectorX = -8;
#declare vectorY = 0;
#declare vectorZ = 2;    
#declare scaleX = 0;
#declare scaleY = 0;
#declare scaleZ = 0;
#declare rotateX = 0;
#declare rotateY = 0;
#declare rotateZ = 0;
#declare reflectivity = .3;

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
union {  
//----bottom layer 
  sphere {
    <1, 1, 1>, 1
  }
  sphere {
    <3, 1, 1>, 1
  }                
  sphere {
    <5, 1, 1>, 1
  } 
  sphere {
    <2, 1, 2.7>, 1
  }           
  sphere {
    <4, 1, 2.7>, 1
  } 
  sphere {
    <3, 1, 4.4>, 1
  }    
//----second layer
  sphere {
    <2, 2.5, 1.7>, 1
  }
  sphere {
    <4, 2.5, 1.7>, 1
  }    
  sphere {
    <3, 2.5, 3.4>, 1
  } 
//----third layer
  sphere {
    <3, 4, 2.4>, 1
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
//--big ball
sphere {  
  <4, 4, 4>, 4
  texture {
    T_Wood2
  }
  finish {
    reflection .3
  }
} 
//--cylinders
cylinder {
  <3, 1, -2>, <4, 1, -6>, 1
  texture {
    T_Wood9
  }
  finish {
    reflection .2
  }
} 
cylinder {
  <6.1, 0, -5>, <6.1, 6, -5>, 1
  texture {
    T_Wood24
  }
  finish {
    reflection .3
  }
}   
//--lathed wood
lathe {
  cubic_spline
  11, 
  <0, 1>, <0, 0>, <2, 1>, <1.5, 2>, <1.5, 3>, <.5, 3.5>, <1.5, 4>, <1.5, 5>, <2, 6>, <0, 7>, <0, 6>
  texture {
    T_Wood5
  } 
  finish {
    reflection .2
  }
  rotate <20, 0, 90>
  translate <1, 2, -4>
  scale <.5, .5, .5>
}

//--lights-------------------------- 

light_source {
  0*x                 
  color rgb <2, 2, 2>    
  translate <0, 10, -7>
}

//--camera--------------------------

camera {
  location  <-6, 8, -7>
  look_at   <2, 2, 2>
  right     x*image_width/image_height
}

