//--mode---------------------------- 
#declare bEdit = !true;

//--includes------------------------
//--global-------------------------- 

global_settings {
  assumed_gamma 1.0
  max_trace_level 5
  #if (!bEdit)          // global photon block
    photons {
      count 200000      // alternatively use a total number of photons
     jitter 1.0         // jitter phor photon rays
    }
  #end
}

//--declares------------------------


//textures 
#if (bEdit) 
  #declare tGround = texture {
             pigment {
               colour rgb <1,1,0>
             }        
             finish {    
               reflection .4
             }
           };               
         
  #declare tRed = texture {
             pigment{
               colour rgbt <1,0,0,.5>
             }
           }; 
   #declare tGreen = texture {
             pigment{
               colour rgbt <0,1,0,.5>
             }
           }; 
   #declare tBlue = texture {
             pigment{
               colour rgbt <0,0,1,.5>
             }
           };     
   #declare tYellow = texture {
             pigment{
               colour rgbt <1,1,0,.5>
             }
           }; 
         
#else
  #declare tGround = texture {
             pigment {
               colour rgb <0,0,0>
             }        
             finish {    
               reflection .4
             }
           };      
         
  #declare tGlass = pigment {colour rgbf <0.8, 0.9, 0.85, 0.85>};                          
  #declare tRed = texture {
             pigment{
               colour rgbf <.8,.1,.1,.85>
             }
           }; 
   #declare tGreen = texture {
             pigment{
               colour rgbf <.1,.85,.1,.85>
             }
           }; 
   #declare tBlue = texture {
             pigment{
               colour rgbf <.1,.1,.8,.95>
             }
           };     
   #declare tYellow = texture {
             pigment{
               colour rgbf <.9,.9,.1,.95>
             }
           }; 
              
#end     

//--global--------------------------





//--objects-------------------------

//floor
plane {
  y, 0
  texture {
    tGround
  }
}
//cubes 
union {        
  box {
    <-1,0,-1>,
    <1,2,1>
    texture {
      tRed
    }
  } 
  box {
    <-1,2,-1>,
    <1,4,1>
    texture {
      tBlue
    } 
    rotate <0,30,0>
  }
  box {
    <-1,4,-1>,
    <1,6,1>
    texture {
      tGreen
    }              
    rotate <0,70,0>
  }      
  box {
    <-1,6,-1>,
    <1,8,1>
    texture {
      tYellow
    }              
    rotate <0,50,0>
  }
  #if (!bEdit)
    photons{              // creates photon use
      target 1.0          // spacing multiplier for photons hitting the object
      refraction on    
      reflection on
    }
    interior {
      ior 1.35
      fade_power 1001
      fade_distance 0.9
      fade_color .98
    }
   #end
}

//--lights--------------------------
    

  // create a regular point light source
  light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <20, 20, -40>
  }
#if(!bEdit)     
  light_source {
    0*x              
    color .5
    translate <0, 1, 0>
  }                
  light_source {
    0*x                    
    color .5
    translate <0, 3, 0>
  }
  light_source {
    0*x                      
    color .5
    translate <0, 5, 0>
  }
  light_source {
    0*x                       
    color .5
    translate <0, 7, 0>
  }
#end           






//--camera--------------------------

// perspective (default) camera
camera {
  location  <20,8,-8>
  look_at   <-30, -3,  -5>
  right     x*image_width/image_height
}
