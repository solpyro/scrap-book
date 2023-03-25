#declare boxNumberY = 0;
#declare boxNumberZ = 0;

difference {
  plane {
    x, 0
    pigment {
      colour rgb <0, 0, 1>
    }
  }
  //#while (boxNumberY < 2)
  //  #while (boxNumberZ < 2)
      box {
        <0, (boxNumberY*3)+4, (boxNumberZ*3)+4>, <0, (boxNumberY*3)+6, (boxNumberZ*3)+6>
      }
      #declare boxNumberZ = boxNumberZ + 1;
//    #end
    #declare boxNumberY = boxNumberY + 1;
//  #end       
}
plane {
  y, 0
  pigment {
    colour rgb <0, 0, 1>
  }
} 
//plane {
//  z, 30
//  pigment {
//    colour rgb <0, 0, 1>
//  }
//}
// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <20, 40, -20>
}
// atmospheric media can be generated by adding a media statement
// to the scene not attached to any specific object

media {    // atmospheric media sample
  intervals 10
  scattering { 1, rgb 0.03 }
  samples 1, 10
  confidence 0.9999
  variance 1/1000
  ratio 0.9
}
// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <10,10,10>    // light's color
  translate <-20, 40, -20>
}
// perspective (default) camera
camera {
  location  <5.0, 5.0, -5.0>
  look_at   <0.0, 6, 6>
  right     x*image_width/image_height
}

      