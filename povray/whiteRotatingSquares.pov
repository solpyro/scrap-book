//--decares----------------------------------

#declare countX = 0;
#declare countY = 0;
#declare countZ = 0;
#declare totalRevolution = 90;
#declare ballCount = 20;

//--objects----------------------------------

//generates cube of spheres
#while (countZ < ballCount)
  #while (countY < ballCount)
    #while (countX < ballCount)
      box {
        <-.5, -.5, -.5>, <.5, .5, .5>
        pigment {
          colour rgb 2
        }
        finish {
          reflection 0
        }
        rotate <countX*(totalRevolution/ballCount), countY*(totalRevolution/ballCount), countZ*(totalRevolution/ballCount)>
        translate <countX, countY, countZ>
      }
      #declare countX = countX + 1;
    #end
    #declare countX = 0;
    #declare countY = countY + 1;
  #end 
  #declare countY = 0; 
  #declare countZ = countZ + 1;
#end

background {
  colour rgb <1,1,1>
}

//--lights-----------------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 30, -10>
}

//--camera-----------------------------------

// perspective (default) camera
camera {
  location  <-10, 30, -15>
  look_at   <6, 13, 3>
  right     x*image_width/image_height
}
