//--includes------------------------
//--declares------------------------ 

/*
 * 1 = pyramid of spheres
 * 2 = bars in box
 * 3 = cylinder
 * 4 = lathed wood
 * 5 = file
 * 6 = feather
 */
#declare objectNumber = 6;

#switch (objectNumber)
//----Pyramid of Balls
  #case (1)
    #declare vectorX = 0;
    #declare vectorY = 0;
    #declare vectorZ = 0;    
    #declare scaleX = 0;
    #declare scaleY = 0;
    #declare scaleZ = 0;
    #declare rotateX = 0;
    #declare rotateY = 0;
    #declare rotateZ = 0;
    #declare colourR = .7;
    #declare colourG = .5;
    #declare colourB = .9;
    #declare reflectivity = .4;
  #break
//----Bars in Box
  #case (2)          
    #declare vectorX2 = 0;
    #declare vectorY2 = 0;
    #declare vectorZ2 = 0;    
    #declare scaleX2 = 0;
    #declare scaleY2 = 0;
    #declare scaleZ2 = 0;
    #declare rotateX2 = 0;
    #declare rotateY2 = 0;
    #declare rotateZ2 = 0;
    #declare colourR2a = .6;
    #declare colourG2a = .6;
    #declare colourB2a = .6;
    #declare translucent = .85;
    #declare countY = 0;
    #declare countZ = 0;
    #declare colourRb = 0.70;
    #declare colourGb = 0.25; 
    #declare colourBb = 0.15;
  #break 
  #case (5)
   #declare metalColour = .4;
   #declare counter = 0;
 #break
 #case (6)
   #declare counter = 0;
   #declare counter2 = 0;
#end

//--objects-------------------------

//plane
plane {
  y, 0 
  pigment {
    colour rgb <.4, .4, .4>
  }
  finish {
    reflection .7
  }
}
//objects
#switch (objectNumber)
  #case (1)
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
        colour rgb <colourR, colourG, colourB>
      }
      finish {
        reflection reflectivity
      }
      translate <vectorX, vectorY, vectorZ> 
      scale <scaleX, scaleY, scaleZ> 
      rotate <rotateX, rotateY, rotateZ>
    }
  #break
  #case (2)                 
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
          color rgbt <boxColourR, boxColourG, boxColourB, translucent>
        }
      }
//----bars
    #while (countY < 2)
       #while (countZ < 4)  
          box {
            <.21, .22+(countY*.69), .21+(countZ*1.84)>, <3.79, .995+(countY*.69), 1.94+(countZ*1.84)>
            pigment {
              color rgb <0.70, 0.25, 0.15>
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
      translate <vectorX, vectorY, vectorZ> 
      scale <scaleX, scaleY, scaleZ> 
      rotate <rotateX, rotateY, rotateZ>
    }
  #break
  #case (3)
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
    }
  #break
  #case (4)
//--lathed object
    lathe {
      cubic_spline
      11, // number of points
      <0, 1>, <0, 0>, <2, 1>, <1.5, 2>, <1.5, 3>, <.2, 3.5>, <1.5, 4>, <1.5, 5>, <2, 6>, <0, 7>, <0, 6>
      pigment {
        colour rgb <1, .3, .3>
      }
      rotate <0, 0, 90>
      translate <0, 2, 0>
    }
  #break
  #case (5)
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
      } 
//----handle
      lathe {
        cubic_spline
        8,
        <0, 0>, <0, 0>, <1.5, 2>, <1, 4>, <1, 6>, <1.5, 8>, <0, 10>, <0, 7>
        pigment {
          colour rgb .8
        } 
        scale <.5, .5, .5>
        rotate <-90, 0, 0>
        translate <1, 1, -.75>
      }         
      translate <0, 0, 0>
      rotate <0, 0, 0>
      scale <0, 0, 0>
    }
  #break
  #case (6)
//--feather
    union {
//----spine
      sphere_sweep {
        cubic_spline
        6,
        <-1, -1, 0>, 0
        <0, 0, 0>, .1
        <0, 0, 0>, .1
        <1, 4, 0>, .15
        <0, 8, 0>, .05
        <-1, 9, 0>, 0
        pigment {
          colour rgb <1, 1, 1>
        }
      }
//----hairs
      #while (counter < 26)
        union {
          sphere_sweep {
            cubic_spline
            4,
            <0, 3, -1>, .09
            <0, 3, 0>, .09
            <0, 3, 4>, .09
            <-5, 3, 5>, .09
            pigment {
              colour rgb <1, 1, 1>
            }
          }
          sphere_sweep {
            cubic_spline
            4,
            <0, 3, 1>, .09
            <0, 3, 0>, .09
            <0, 3, -4>, .09
            <-5, 3, -5>, .09
            pigment {
              colour rgb <1, 1, 1>
            }
          }
          #if (counter < 6)
            translate <.9+(.02*counter), .2*counter, 0>
            scale <0, 0, .17*(counter+.01)>
          #else
            translate <1-((.002*counter)*(counter-6)), .2*counter, 0>
            scale <0, 0, 1-(.035*counter)>
          #end
        }
        #declare counter = counter + 1;
      #end
      #declare counter = 0;
      scale <0, 0, 0>
      translate <0, 0, 0>
      rotate <0, 0, 0>
    }
#end    

//--lights--------------------------

//point light
light_source {
  0*x      
  color rgb <2,2,2>
  translate <-12, 16, -20>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <-4, 1, -10>
  look_at   <1, 4, 0>
  right     x*image_width/image_height
}
