//--global--------------------------
//--includes------------------------

#include "woods.inc"
#include "metals.inc"

//--declares------------------------

//mode
#declare bEdit = true;
/**********************
 * image:
 * 1 - main design
 * 2 - cabinet
 * 3 - moved cabinet
 * 4 - air duct
 * 5 - open cabinet
 **********************/
#declare img = 5;

//textures
#if (bEdit)
  #declare Wall = pigment {
                    colour rgb <.9,.9,.6>
                  };
  #declare Floor = pigment {
                     colour rgb <1,1,.6>
                   };
  #declare Cabinet = texture {
                       pigment {
                         colour rgb <0,.05,.3>
                       }
                       finish {
                        reflection .09
                       }
                     };
  #declare Fixings = T_Brass_4B;
  #declare Door = T_Wood2;
  #declare Doorknob = T_Brass_5A;
  #declare Duct = texture {
                    pigment {
                      colour rgb <.2,.2,.2>
                    }
                    finish {
                      reflection .1
                    }
                  };
  #declare Desk = T_Wood24;
#else
  #declare Wall = pigment {
                    colour rgb <1,0,0>
                  };
  #declare Floor = pigment {
                     colour rgb <0,1,0>
                   };
  #declare Cabinet = pigment {
                       colour rgb <0,0,1>
                     };
  #declare Fixings = pigment {
                       colour rgb <1,1,0>
                     };
  #declare Door = pigment {
                    colour rgb <1,0,1>
                  };
  #declare Doorknob = pigment {
                        colour rgb <0,1,1>
                      };
  #declare Duct = pigment {
                    colour rgb <1,.5,0>
                  };
  #declare Desk = pigment {
                    colour rgb <1,0,.5>
                  }
#end

//--objects-------------------------

//walls
box {
  <22,18,20>,
  <-20,-18,22>
  texture {
    Wall
  }
}
difference {
  box {
    <-22,18,-22>,
    <-20,-18,20>
  }
  box {
    <-19,3,0>,
    <-23,7,5>
  }
  texture {
    Wall
  }
}
difference {
  box {
    <-22,-18,-22>,
    <22,-20,22>
  }
  box {
    <0,0,0>,
    <7,14.5,6>
    translate <7,-18.1,14>
  }
  texture {
    Floor
  }
}

//door
box {
  <-17,2,19.9>,
  <-6,-18,20.1>
  texture {
    Door
  }
}
lathe {
  cubic_spline 7
  <-1,0>,
  <0,0>,
  <1,.2>,
  <1,.4>,
  <.4,.6>,
  <.4,1>,
  <.4,1.2>
  texture {
    Doorknob
  }
  rotate <90,0,0>
  scale .6
  translate <-7,-8,18.8>
}

//cabinet
union {
  difference {
    box {
      <0,0,0>,
      <7,14.5,6>
    }
    #declare counter = 0;
    #while (counter < 3)
      box {
        <.5,1,-1>,
        <6.5,5,0.05>
        translate <0,4.5*counter,0>
      }
      #declare counter = counter+1;
    #end
    texture {
      Cabinet
    }
  }
  union {
  #declare counter = 0;
    #while (counter < 3)
      union {
        difference {
          box {
            <2.8,3,0.05>,
            <4.2,4,0>
          }
          box {
            <3,3.2,0.1>,
            <4,3.8,-1>
          }
        }
        difference {
          box {
            <2.6,1.8,.2>,
            <4.4,2,-.5>
          }
          box {
            <2.8,1,.2>,
            <4.2,2.2,-.3>
          }
        }
        translate <0,4.5*counter+.2,0>
        #if ((img=5)&(counter=1))
          translate <0,0,-6.05>
        #end
      }
      #declare counter = counter+1;
    #end
    texture {
      Fixings
    }
  }
  #if ((img=3)|(img=5))
    translate <7,-18,14>
  #else
    translate <0,-18,14>
  #end
}
//open drawer
union {
  difference {
    box {
      <.5,1,-6>,
      <6.5,5,0.05>
    }
    box {
      <.6,1.1,-5.9>,
      <6.4,5.1,-0.05>
    }
    texture {
      Cabinet
    }
  }
  translate <0,4.5,0>
  translate <7,-18,14>
  #if (!(img=5))
    no_image
    no_shadow
    no_reflection
  #end
}

//duct
#declare counter = 0;
#while(counter < 30)
  union {
    difference {
      box {
        <-20,3,0>,
        <-26,7,5>
      }
      box {
        <-19,3.1,0.1>,
        <-27,6.9,4.9>
      }
    }
    difference {
      box {
        <-25.9,3,0>,
        <-26,7,5>
      }
      box {
        <-25,3.2,0.2>,
        <-26.1,6.8,4.8>
      }
    }
    texture {
      Duct
    }
    translate <-6*counter,0,0>
  }
  #declare counter = counter+1;
#end

//desk
union {
  //legs
  box {
    <0,-18,0>,
    <1,-8,1>
  }
  box {
    <17,-18,0>,
    <18,-8,1>
  }
  box {
    <0,-18,8>,
    <1,-8,9>
  }
  box {
    <17,-18,8>,
    <18,-8,9>
  }
  //panels
  box {
    <0,-16,0.2>,
    <18,-8,1>
  }
  box {
    <17,-14,9>,
    <17.8,-8,0>
  }
  box {
    <-1.5,-8,-1.5>,
    <19.5,-7.5,10.5>
  }
  texture {
    Desk
  }
  translate <-5,0,-5>  
  #if((img=2)|(img=3)|(img=5))
    no_image
  #end
}
  

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <0,5,0>
}

//--camera--------------------------

// perspective (default) camera
camera {
  #switch(img)
    #case (1) 
      location  <22,22,-26>
      look_at   <0.0, 0, 0.0>
    #break
    #case (2) 
      location  <3,-10,-3>
      look_at   <3,-10,10>
    #break
    #case (3) 
      location  <3,-10,-3>
      look_at   <3,-10,10>
    #break
    #case (4) 
      location  <-14,4,1.5>
      look_at   <-20,5,2.5>
    #break
    #case (5) 
      location  <14,7,5>
      look_at   <8,-10,13> 
    #break
  #end
  right     x*image_width/image_height
}
