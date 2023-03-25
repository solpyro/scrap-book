//--global--------------------------
//--includes------------------------
//--declares------------------------

//----Pyramid of Balls
#declare colourR1 = .7;
#declare colourG1 = .5;
#declare colourB1 = .9;
#declare reflectivity = .4;  

//----textures
#declare steel = texture {
                   pigment {
                     colour rgb .6
                   }
                   finish {
                   reflection .6
                   phong .2
                   metallic
                   }
                 };
#declare glass = texture {
                   pigment {
                     colour rgbf <0,1,0,.9>
                   }
                   finish {
                    reflection .6
                    phong .2
                   }
                 };
                 
//----objects
#declare textBar = union {
                     difference {
                       cylinder {
                         <-5,0,0>,
                         <8,0,0>,
                         1.5
                       }
                       cylinder {
                         <-7.8,0,0>,
                         <7.8,0,0>,
                         1
                       }
                       text {
                         ttf
                         "arialbd.ttf", 
                         "SolPyro's 3D Prints",   
                         1.5,           
                         0 
                         rotate<0,180,0> 
                         translate<6.2,-.4,1.5>
                         scale <1.2,1.2,0>
                       }
                       texture {
                         steel
                         pigment {
                           colour rgb .3
                         }
                       }
                     }
                     intersection {
                       union {
                         cylinder {
                           <-4.8,0,0>,
                           <7.8,0,0>,
                           1
                         }
                         text {
                           ttf
                           "arialbd.ttf", 
                           "SolPyro's 3D Prints",   
                           1.5,           
                           0 
                           rotate<0,180,0> 
                           translate<6.2,-.4,1.5>
                           scale <1.2,1.2,0>
                         }
                       }
                       cylinder {
                         <-5,0,0>,
                         <8,0,0>,
                         1.5
                       }
                       texture {
                         glass
                       }
                     }
                     /*light_source {
                       0*x                  // light's position (translated below)
                       color rgb <1,1,1>    // light's color
                       translate <-4,0,0>
                     }*/
                     light_source {
                       0*x                  // light's position (translated below)
                       color rgb 3    // light's color
                       translate <6.5,0,0>
                     }
                     translate<-1.5,-3.5,-8>
                   };
                   
//--objects-------------------------

//--room
union {
  plane {
    y,-5
  }
  plane {
    z,-30
  }
  texture {
    steel
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
  rotate <0,10,0>
  translate <18,-10,-20> 
  scale .5
  no_shadow
}

//--Title {
object {
  textBar
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 0, 40>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <0,-3,10>
  look_at   <0,-3,0>
  right     x*image_width/image_height
}
