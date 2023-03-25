//--global--------------------------
//--includes------------------------
//--declares------------------------ 

//choose project
//  deathstar   = 1
//  tie fighter = 2
#declare project = 1;
//death star variables
//--trench variables
#declare dimention = .1;
//laser dish variables
#declare depth = .01;
#declare elevation = 45;
//final movement variables
#declare yRotationDeathStar = -20;
//--programming variables - do not touch
#declare rotation1 = 0;
#declare rotation2 = 0;
#declare rotation3 = 0;

//tie fighter variables
//final movement variables
#declare yRotationTieFighter = -20;

//--objects-------------------------

//deathstar
#if (project = 1)
  difference {
  //--main body
    sphere {
      <0, 0, 0>, 5
    }
  //--trench
    difference {
      sphere {
        <0, 0, 0>, 6
      }
      #while (rotation1 < 2)
        box {
          <-6, dimention, -6>, <6, 6, 6>
          rotate x*180*rotation1
        }
        #declare rotation1 = rotation1 + 1;
      #end
      sphere {
        <0, 0, 0>, 5-dimention
      }
      pigment {
        colour rgb <.5, .5, .5>
      }
    }
  //--laser dish
    sphere {
      <0, 0, -5+depth>, 2
      rotate x*elevation
    }
    pigment {
      colour rgb <.6, .6, .6>
    }
    rotate y*yRotationDeathStar
  }
#end 

//tie fighter
#if (project = 2) 
  union {
  //--cockpit
    difference {
  //----main body
      sphere {
        <0, 0, 0>, 2
      }
  //----window 1 (circle)
      cylinder {
        <0, 0, -2>,
        <0, 0, 0>,
        .4
      }
  //----window 2 (trapezioids)
      #while (rotation1 < 8) 
        prism {
          0, -2, 4
          <-.36,1.2>, <.36,1.2>, <.1,.5>, <-.1,.5> 
          rotate x*90
          rotate z*45*rotation1
        }
        #declare rotation1 = rotation1 + 1;
      #end 
  //----wall depth
      sphere {
        <0, 0, 0>, 1.8
      }
    }
  //----rim
    torus {
        1.4,
        0.226
        pigment {
          colour rgb <.55, .55, .55>
        }
        rotate x*90
        translate <0, 0, -1.45>
      }
  //--wings
    #while (rotation2 < 2)
      union {
  //----struts
        difference {
          union {
            cylinder {
              <0, 0, 0>,
              <-4, 0, 0>, 
              .5
            }
            torus {
              .5,
              .2
              rotate z*90
              translate x*-1.9
            }
          }
          sphere {
            <0, 0, 0>, 2
          }  
        }
  //----wing panels
        union {
          cylinder {
            <-.1, 0, 0>, <.1, 0, 0>, 1.5
            pigment {
              colour rgb <1, 1, 1>
            }
          }
          translate x*-4
        }
        #while (rotation3 < 6)
  //------black panels
  //--------left hand side
          union {
            triangle {
              <.1, 0, 0>,
              <0, 5.2, -3>,
              <0, 5.2, 3>
              rotate x*60*rotation3
            }
            triangle {
              <-.1, 0, 0>,
              <0, 5.2, -3>,
              <0, 5.2, 3>
              rotate x*60*rotation3
            }
            prism {                                
              linear_sweep
              linear_spline 
              6,         
              0,         
              4,           
              <-.14, 0>, < 0, .05>, <.14, 0>, <0, .05>
              translate y*-6
              rotate x*150
              rotate x*60*rotation3
              pigment {
                colour rgb <1, 1, 1>
              }
            }
            prism {
              linear_sweep
              linear_spline
              -.08,
              6.08,
              4,
              <.14, .14>, <.14, -.14>, <-.14, -.14>, <-.14, .14>
              translate y*-3
              rotate x*90
              translate y*5.2
              rotate x*60*rotation3
              pigment {
                colour rgb <1, 1, 1>
              }
            }
            translate x*-4
          }
  //--------right hand side
          union {
            triangle {
              <.1, 0, 0>,
              <0, 5.2, -3>,
              <0, 5.2, 3>
              rotate x*60*rotation3
            }
            triangle {
              <-.1, 0, 0>,
              <0, 5.2, -3>,
              <0, 5.2, 3>
              rotate x*60*rotation3
            }
            prism {                                
              linear_sweep
              linear_spline 
              6,         
              0,         
              4,           
              <-.14, 0>, < 0, .05>, <.14, 0>, <0, .05>
              translate y*-6
              rotate x*150
              rotate x*60*rotation3
              pigment {
                colour rgb <1, 1, 1>
              }
            }
            prism {
              linear_sweep
              linear_spline
              -.08,
              6.08,
              4,
              <.14, .14>, <.14, -.14>, <-.14, -.14>, <-.14, .14>
              translate y*-3
              rotate x*90
              translate y*5.2
              rotate x*60*rotation3
              pigment {
                colour rgb <1, 1, 1>
              }
            }
            translate x*4
          }
          #declare rotation3 = rotation3 + 1;
        #end
        rotate y*180*rotation2
      }
      #declare rotation2 = rotation2 + 1;
    #end
    pigment {
      colour rgb <.7, .7, .7>
    }
  }  
#end

//--lights-------------------------- 

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <-20, 40, -20>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <0, 2.0, -15>
  look_at   <0.0, 0.0,  0.0>
  right     x*image_width/image_height
}