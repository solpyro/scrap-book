//--declares---------------------------------

//I don't know what you'll be using the declares for, you don't really need them in the starscape
#declare variableName = <0,0,0>; //POV variables are untyped, you can put whatevewr you want in here :D

//NOTE: it doesn't matter what order your different objects come in, you can define your lights and cameras first if you want...

//--objects----------------------------------

//your series of spheres representing stars can go here
sphere { <0,0,0>,.1 pigment {colour rgb <1,1,1>} }        
sphere { <3,0,0>,.1 pigment {colour rgb <1,1,1>} }
sphere { <0,3,0>,.1 pigment {colour rgb <1,1,1>} }
sphere { <0,0,3>,.1 pigment {colour rgb <1,1,1>} }
sphere { <4,0,4>,.1 pigment {colour rgb <1,1,1>} } 
//sphere declarations can take the form of a single line as above
//or they can be split over many lines as below
sphere {
  <6,6,0>, //this line controls the position of your star
  .1 //this line controls the radius of the star
  pigment {
    colour rgb <1,1,1> //this is the colour, currently white <1,1,1>
  }
}

//--lights-----------------------------------

//creates a regular point light source.
//you will need this to display the spheres,
//but you should experiment to find the best position for it
light_source {
  0*x                  //ignore this line, it's pointless here
  color rgb <1,1,1>    //light's color, you probably want it white <1,1,1>
  translate <-20, 20, -20> //use this to reposition for shadows, shading etc
}

//--camera-----------------------------------

// perspective (default) camera
camera {
  location  <-10, 9, -15> //defines the position your camera takes
  look_at   <3, 3, 3> //defines the coordinate your camera looks at
  right     x*image_width/image_height //creates the image size thingymajig, useful for depth of focus/field of view
}
