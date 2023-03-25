//--decares----------------------------------

#declare countX = 0;
#declare countY = 0;
#declare countZ = 0;

//--objects----------------------------------

//generates cube of spheres
#while (countZ < 5)
  #while (countY < 5)
    #while (countX < 5)
      sphere {
        <countX, countY, countZ>, .5
        pigment {
          colour rgb <.3, 0, 1>
        }
        finish {
          reflection .4
        }
      }
      #declare countX = countX + 1;
    #end
    #declare countX = 0;
    #declare countY = countY + 1;
  #end
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
  location  <-5, 6, -10>
  look_at   <3, 3, 3>
  right     x*image_width/image_height
}
