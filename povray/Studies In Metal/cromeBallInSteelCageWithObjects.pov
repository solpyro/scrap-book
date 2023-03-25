//--includes------------------------
//--declares------------------------ 
 
global_settings {
  assumed_gamma 1.0
  max_trace_level 5
    photons {
      spacing 0.02    
      jitter 1.0              
    }
}
//----Pyramid of Balls
#declare vectorX1 = 2;
#declare vectorY1 = 0;
#declare vectorZ1 = -10;    
#declare scaleX1 = 0;
#declare scaleY1 = 0;
#declare scaleZ1 = 0;
#declare rotateX1 = 0;
#declare rotateY1 = 45;
#declare rotateZ1 = 0;
#declare colourR1 = .7;
#declare colourG1 = .5;
#declare colourB1 = .9;
#declare reflectivity = .4;  
//----Bars in Box     
#declare vectorX2 = 6;
#declare vectorY2 = 0;
#declare vectorZ2 = -16;    
#declare scaleX2 = 0;
#declare scaleY2 = 0;
#declare scaleZ2 = 0;
#declare rotateX2 = 0;
#declare rotateY2 = -20;
#declare rotateZ2 = 0;
#declare colourR2a = .6;
#declare colourG2a = .6;
#declare colourB2a = .6;
#declare translucent = .85;
#declare countY = 0;
#declare countZ = 0;
#declare colourR2b = 0.70;
#declare colourG2b = 0.25; 
#declare colourB2b = 0.15; 
//----Cylinders
#declare vectorX3 = 0;
#declare vectorY3 = 0;
#declare vectorZ3 = 5;    
#declare scaleX3 = 0;
#declare scaleY3 = 0;
#declare scaleZ3 = 0;
#declare rotateX3 = 0;
#declare rotateY3 = 130;
#declare rotateZ3 = 0;

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
      reflection .4
      diffuse .5
    }  
    hollow
  }
  sphere {
    <3, 3, 3>, 3.8
  } 
  finish {
    conserve_energy
  }
  photons { 
    target 1.0
    refraction on
    reflection on  
  }
}
//chrome ball
sphere {
  <3, 3, 3>, 2.8
  pigment {
    colour rgb <.9, .9, .9>
  }
  finish {
    reflection .85
    roughness .5 
    conserve_energy
  }
  photons { 
    target 1.0
    refraction on
    reflection on  
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
  pigment {
    colour rgb <colourR1, colourG1, colourB1>
  }
  finish {
    reflection reflectivity
  } 
  photons { 
    target 1.0
    refraction on
    reflection on  
  }
  translate <vectorX1, vectorY1, vectorZ1> 
  scale <scaleX1, scaleY1, scaleZ1> 
  rotate <rotateX1, rotateY1, rotateZ1>
} 
//--bars in box
union { 
//----glass box
  difference {
    box {
      <0, 0, 0>, <4, 2, 8>
      hollow off
    }
    box {
      <.2, .2, .2>, <3.8, 1.8, 7.8>
      hollow off
    }
    pigment { 
      color rgbt <colourR2a, colourG2a, colourB2a, translucent>
    }
  }
//----bars
  #while (countY < 2)
    #while (countZ < 4)  
      box {
        <.21, .22+(countY*.69), .21+(countZ*1.84)>, <3.79, .995+(countY*.69), 1.94+(countZ*1.84)>
        pigment {
          colour rgb <colourR2b, colourG2b, colourB2b>
        }   
        finish {
          ambient 0.1             
          brilliance 2
          diffuse 0.7
          metallic
          specular 1
          roughness 1/120
          reflection 0.8
        }
      }
      #declare countZ = countZ + 1;
    #end
    #declare countZ = 0; 
    #declare countY = countY + 1;
  #end 
  photons { 
    target 1.0
    refraction on
    reflection on  
  }
  translate <vectorX2, vectorY2, vectorZ2> 
  scale <scaleX2, scaleY2, scaleZ2> 
  rotate <rotateX2, rotateY2, rotateZ2>
}  
//--cylinder
union {
  cylinder {
    <0, 1, 1>, <4, 1, 1>, 1
    pigment {
      colour rgb <.4, .7, 0>
    } 
    finish {
      reflection .6
    }
  } 
  cylinder {
    <1, 0, 3.4>, <1, 5, 3.4>, 1
    pigment {
      colour rgb <.2, 1, .1>
    } 
    finish {
      reflection .4
    }
  } 
  photons { 
    target 1.0
    refraction on
    reflection on  
  } 
  translate <vectorX3, vectorY3, vectorZ3> 
  scale <scaleX3, scaleY3, scaleZ3> 
  rotate <rotateX3, rotateY3, rotateZ3>
}              
   
//--lights--------------------------

//area light
light_source {
  0*x 
  color rgb 1.5      
  area_light
  <8, 0, 0> <0, 0, 8>
  4, 4               
  adaptive 0         
  jitter             
  circular           
  orient             
  translate <0, 80, -40>
  photons {           
    refraction on
    reflection on 
  }
}

//--camera--------------------------

// perspective camera
camera {
  location  <-3, 8, -8>
  look_at   <3, 3, 3>
  right     x*image_width/image_height
}
