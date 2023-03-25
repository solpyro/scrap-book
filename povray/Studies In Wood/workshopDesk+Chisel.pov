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
#declare metalColour = .4;
#declare counter = 0;

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
//--file
union {
//----file surface
  difference {
    box {
      <0, 0, 0>, <2, 1, 8>
      pigment {
        colour rgb <metalColour, metalColour, metalColour> 
      }                                                   
      
    }
//------cuts
    #while (counter < 8)
      box { 
        <-12, 0.98, 0>, <12, 1, .02>
        translate <0, 0, counter>
        rotate <0, 45, 0>
      }  
      box { 
        <-12, 0.98, 0>, <12, 1, .02>
        translate <0, 0, counter-2>
        rotate <0, -45, 0>
      }
      box { 
        <-12, 0, 0>, <12, .02, .02>
        translate <0, 0, counter>
        rotate <0, 45, 0>
      }  
      box { 
        <-12, 0, 0>, <12, .02, .02>
        translate <0, 0, counter-2>
        rotate <0, -45, 0>
      }
      #declare counter = counter + .05;
    #end
    scale <0, .75, 0>
    translate <0, .125, 0>
  }
//----file neck  
  difference {
    lathe {
      quadratic_spline
      4,
      <0, 0>, <0, 0>, <1, 2>, <0, 2>
      pigment {
        colour rgb <metalColour, metalColour, metalColour>
      }
    }
    box {
      <-1, 0, -.5>, <1, 3, -1>
      pigment {
        colour rgb <metalColour, metalColour, metalColour>
      }
    } 
    box {
      <-1, 0, .5>, <1, 3, 1> 
      pigment {
        colour rgb <metalColour, metalColour, metalColour>
      }
    } 
    rotate <90, 0, 0> 
    translate <1, .5, -2>
    scale <0, .75, 0>
    translate <0, .125, 0>
  } 
//----handle
  lathe {
    cubic_spline
    8,
    <0, 0>, <0, 0>, <1.5, 2>, <1, 4>, <1, 6>, <1.5, 8>, <0, 10>, <0, 7>
    texture {
      T_Wood5
    }
    scale <.75, .75, .75>
    rotate <-90, 0, 0>
    translate <1, .5, -.75>
  }         
  rotate <-15, 70, 0>
  translate <11, 4, 2>
  scale <0, 0, 0>
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

