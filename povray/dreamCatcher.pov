//--includes------------------------

#include "woods.inc"

//--declares------------------------ 

#declare finalRotation = 25;
#declare rotation = 0;
#declare rotation2 = 0;
#declare counter = 0;
#declare counter2 = 0;

//--objects-------------------------

//dreamcatcher
union {
//--ring
  torus {
    7,
    .25
    texture {
      T_Wood5
    }
    rotate <90, 0, 0>
  }
//--web
  #while (rotation < 8)
    union {
//----radial thread
      sphere_sweep {
        linear_spline
        2,
        <0, 0, 0>, .1
        <0, 7, 0>, .1
        pigment {
          colour rgb <.6, .6, .6>
        }
      }
//----spiral threads
      sphere_sweep {
        linear_spline
        2,
        <0, 1, 0>, .1
        <1.4, 1.4, 0>, .1
        pigment {
          colour rgb <1, 0, 0>
        }
      }
      sphere_sweep {
        linear_spline
        2,
        <0, 2, 0>, .1
        <2.1, 2.1, 0>, .1
        pigment {
          colour rgb <1, .5, 0>
        }
      }
      sphere_sweep {
        linear_spline
        2,
        <0, 3, 0>, .1
        <2.8, 2.8, 0>, .1
        pigment {
          colour rgb <1, 1, 0>
        }
      }
      sphere_sweep {
        linear_spline
        2,
        <0, 4, 0>, .1
        <3.6, 3.6, 0>, .1
        pigment {
          colour rgb <0, 1, 0>
        }
      }
      sphere_sweep {
        linear_spline
        2,
        <0, 5, 0>, .1
        <4.3, 4.3, 0>, .1
        pigment {
          colour rgb <0, 0, 1>
        }
      }
      sphere_sweep {
        linear_spline
        2,
        <0, 6, 0>, .1
        <4.8, 4.8, 0>, .1
        pigment {
          colour rgb <1, 0, 1>
        }
      }
      rotate <0, 0, 45*rotation>
    }
    #declare rotation = rotation + 1;
  #end
//--tassles
  #while (rotation2 < 3)
//----beads
    union {
      union {
        #while (counter < 7)
          sphere {
            <0, -7.5-(counter*2), 0>, .5
            pigment {
              colour rgb <0, 0, 1>
            }
          }
          sphere {
            <0, -8.5-(counter*2), 0>, .5
            pigment {
              colour rgb <.5, 0, 1>
            }
          }
          #declare counter = counter + 1;
        #end
        finish {
          reflection .6
        }
      } 
      sphere {
        <0, -22, 0>, 1
        pigment {
          colour rgb <1, 0, .6>
        }
      }
//----feather
      union {
//------spine
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
//------hairs
        #while (counter2 < 26)
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
            #if (counter2 < 6)
              translate <.9+(.02*counter2), .2*counter2, 0>
              scale <0, 0, .17*(counter2+.01)>
            #else
              translate <1-((.002*counter2)*(counter2-6)), .2*counter2, 0>
              scale <0, 0, 1-(.035*counter2)>
            #end
          }
          #declare counter2 = counter2 + 1;
        #end
        #declare counter2 = 0;
        scale <.5, .5, .5>
        rotate <180, 0, 0>
        translate <0, -23, 0>
      }
      rotate <0, 170, -10+(10*rotation2)>
    }
    #declare counter = 0;
    #declare rotation2 = rotation2 + 1;
  #end
  rotate <0, finalRotation, 0>
} 
//planes
plane {
  y, -30
  pigment {
    colour rgb <.3, .3, .3>
  }      
  finish {
    reflection .3
  }
}
plane {
  z, 30
  pigment {
    colour rgb <.2, .2, .2>
  }      
  finish {
    reflection .2
  }
}


//--lights-------------------------- 

light_source {
  0*x                  // light's position (translated below)
  color rgb <3,3,3>    // light's color
  translate <-20, 40, -20>
}

//--camera--------------------------  

camera {
  location  <0, 2, -40>
  look_at   <0, -10, 0>
  right     x*image_width/image_height
}
