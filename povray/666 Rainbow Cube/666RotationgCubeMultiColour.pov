//--decares----------------------------------

#declare countX = 0;
#declare countY = 0;
#declare countZ = 0;
#declare colourR = 0;
#declare colourG = 0;
#declare colourB = 0;
#declare totalRevolution = 90;
#declare ballCount = 6;

//--objects----------------------------------

//generates cube of spheres
#while (countZ < ballCount)
  #while (countY < ballCount)
    #while (countX < ballCount)
      box {
        <-.5, -.5, -.5>, <.5, .5, .5>
        pigment {
          colour rgb <colourR, colourG, colourB>
        }
        finish {
          reflection 0
        }
        rotate <countX*(totalRevolution/ballCount), countY*(totalRevolution/ballCount), countZ*(totalRevolution/ballCount)>
        translate <countX, countY, countZ>
      }
      #declare colourR = colourR + .2;
      #declare countX = countX + 1;
    #end
    #declare colourR = 0;
    #declare countX = 0;
    #declare colourG = colourG + .2;
    #declare countY = countY + 1;
  #end 
  #declare colourG = 0;
  #declare countY = 0; 
  #declare colourB = colourB + .2;
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
