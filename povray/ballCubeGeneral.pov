//--declares----------------------------------

//number of spheres in x-axis
#declare xCount = 6;         
//number of spheres in y-axis
#declare yCount = 6;         
//number of spheres in z-axis
#declare zCount = 6;
//end sphere colour in x-axis
#declare XR = 1;    
#declare XG = 0;
#declare XB = 1;             
//end sphere colour in y-axis
#declare YR = 1;
#declare YG = 1;
#declare YB = 0;             
//end sphere colour in z-axis
#declare ZR = 0;
#declare ZG = 1;
#declare ZB = 1;

//--Do Not Touch!----------------------------

#declare countX = 0;
#declare countY = 0;
#declare countZ = 0;
#declare colourR = 0;
#declare colourG = 0;
#declare colourB = 0;
#declare countRy = 0;
#declare countGy = 0;
#declare countBy = 0;
#declare countRz = 0;
#declare countGz = 0;
#declare countBz = 0;
//Steps for colour change
#declare RXStep = XR/(xCount - 1);
#declare RYStep = YR/(yCount - 1);
#declare RZStep = ZR/(zCount - 1);
#declare GXStep = XG/(xCount - 1);
#declare GYStep = YG/(yCount - 1);
#declare GZStep = ZG/(zCount - 1);
#declare BXStep = XB/(xCount - 1);
#declare BYStep = YB/(yCount - 1);
#declare BZStep = ZB/(zCount - 1);

//--objects----------------------------------

//generates cube of spheres
#while (countZ < zCount)
  #while (countY < yCount)
    #while (countX < xCount)
      sphere {
        <countX, countY, countZ>, .5
        pigment {
          colour rgb <colourR, colourG, colourB>
        }
        finish {
          reflection .4
        }
      }
      //x increments
      #declare colourR = colourR + RXStep;
      #declare colourG = colourG + GXStep;
      #declare colourB = colourB + BXStep;
      #declare countX = countX + 1;
    #end
    //y increments
    #declare countRy = countRy + RYStep;
    #declare colourR = countRy;
    #declare countGy = countGy + GYStep;
    #declare colourG = countGy;
    #declare countBy = countBy + BYStep;
    #declare colourB = countBy;
    #declare countX = 0;
    #declare countY = countY + 1;
  #end
  //z increments
  #declare countRz = countRz + RZStep;
  #declare countRy = countRz;
  #declare colourR = countRy;
  #declare countGz = countGz + GZStep;
  #declare countGy = countGz; 
  #declare colourG = countGy;
  #declare countBz = countBz + BZStep;
  #declare countBy = countBz;
  #declare colourB = countBy;
  #declare countY = 0; 
  #declare countZ = countZ + 1;
#end
plane {
  y, -.5
  pigment {
    colour rgb <.6, .6, .6>
  }
  finish {
    reflection .7
  }
}  

//--lights-----------------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 20, -20>
}

//--camera-----------------------------------

// perspective (default) camera
camera {
  location  <-10, 9, -15>
  look_at   <3, 3, 3>
  right     x*image_width/image_height
} 