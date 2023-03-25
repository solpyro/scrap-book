//--global--------------------------
//--includes------------------------

#include "woods.inc"
#include "metals.inc"

//--declares------------------------

//define pigment set    true uses basic colours
//                      false uses final render textures                        
#declare designMode = false;
//define positioning    0 = standing
//                      1 = angled as played
//                      2 = other (specify)
#declare position = 1;
#declare rotator = <0,0,0>;
#declare translator = <0,-8,-30>;


#if (designMode)

//define pigment set: basic colours
  #declare woodT_light = pigment {
                           colour rgb <0,1,0>
                         }
  #declare woodT_black = pigment {
                           colour rgb <1,0,0>
                         }
  #declare woodT_white = pigment {
                           colour rgb <0,0,1>
                         }
  #declare woodT_dark = pigment {
                          colour rgb <1,1,0>
                        }
  #declare woodT_dark2 = pigment {
                           colour rgb <1,.3,0>
                         }
  #declare woodT_red = pigment {
                         colour rgb <0,1,1>
                       }
  #declare metalT_chrome = pigment {
                             colour rgb <1,0,1>
                           }
  #declare metalT_steel = pigment {
                            colour rgb <1,1,1>
                          }
  #declare guitar = 0;
  #declare scratchplate = 0;
  #declare chrome = 0;
  #declare steel = 0;

#else

//define pigment set: final render
  #declare woodT_light = T_Wood10;
  #declare woodT_black = T_Wood2;
  #declare woodT_white = T_Wood3;
  #declare woodT_dark = T_Wood18;
  #declare woodT_dark2 = T_Wood15;
  #declare woodT_red = T_Wood14;
  #declare metalT_chrome = T_Chrome_5A;
  #declare metalT_steel = T_Chrome_5C;
  #declare guitar = .2;
  #declare scratchplate = .5;
  #declare chrome = .8;
  #declare steel = .3;

#end

#declare counter = 0;
#declare translation = 1.3;
#declare dTranslation = 1.3;
#declare ddTranslation = 0.0476;
#declare xCounter = 0;
#declare yCounter = 0;
#declare random1 = seed(1285);
#declare random2 = seed(1457);

//--objects-------------------------

//guitar
union {
//--body
  difference {
    union {
      prism {
        cubic_spline  
        0,4,18,
        <10,4>,<1,6>,<-4.5,4>,<-4,0>,
        <-3.6,-2>,<-4,-3.5>,<-6,-7>,<-4,-10.5>,
        <0,-12>,<4,-10.5>,<6,-7>,<4,-3.5>,
        <3.6,-2>,<4,0>,<5,3.5>,<2,3>,
        <1,6>,<1,8>
        texture {
          woodT_light
        }
      }
//----decorations
//------rings
      cylinder {
        <0,2,0>,
        <0,4.001,0>,
        3
        texture {
          woodT_black
        }
      }
      cylinder {
        <0,2,0>,
        <0,4.002,0>,
        2.9
        texture {
          woodT_white
        }
      }
      cylinder {
        <0,2,0>,
        <0,4.003,0>,
        2.8
        texture {
          woodT_black
        }
      }
      cylinder {
        <0,2,0>,
        <0,4.004,0>,
        2.7
        texture {
          woodT_light
        }
      }
      cylinder {
        <0,2,0>,
        <0,4.005,0>,
        2.5
        texture {
          woodT_black
        }
      }
      cylinder {
        <0,2,0>,
        <0,4.006,0>,
        2.4
        texture {
          woodT_white
        }
      }
      cylinder {
        <0,2,0>,
        <0,4.007,0>,
        2.2
        texture {
          woodT_black
        }
      }
      cylinder {
        <0,2,0>,
        <0,4.008,0>,
        2.1
        texture {
          woodT_light
        }
      }
//------side of guitar
      prism {
        cubic_spline  
        3.7,3.98,18,
        <10,4>,<1,6>,<-4.5,4>,<-4,0>,
        <-3.6,-2>,<-4,-3.5>,<-6,-7>,<-4,-10.5>,
        <0,-12>,<4,-10.5>,<6,-7>,<4,-3.5>,
        <3.6,-2>,<4,0>,<5,3.5>,<2,3>,
        <1,6>,<1,8>
        texture {
          woodT_white
        }
      }
      prism {
        cubic_spline  
        0.02,0.3,18,
        <10,4>,<1,6>,<-4.5,4>,<-4,0>,
        <-3.6,-2>,<-4,-3.5>,<-6,-7>,<-4,-10.5>,
        <0,-12>,<4,-10.5>,<6,-7>,<4,-3.5>,
        <3.6,-2>,<4,0>,<5,3.5>,<2,3>,
        <1,6>,<1,8>
        texture {
          woodT_white
        }
      }
      prism {
        cubic_spline  
        0.3,3.7,18,
        <10,4>,<1,6>,<-4.5,4>,<-4,0>,
        <-3.6,-2>,<-4,-3.5>,<-6,-7>,<-4,-10.5>,
        <0,-12>,<4,-10.5>,<6,-7>,<4,-3.5>,
        <3.6,-2>,<4,0>,<5,3.5>,<2,3>,
        <1,6>,<1,8>
        texture {
          woodT_dark
        }
      }
//------scratchplate
      prism {
        cubic_spline
        4.03, 1, 11,
        <-2,0>,<0,0>,<2,0>,<3.5,-.5>,
        <3.3,-2>,<3.6,-4>,<2,-5>,<.5,-5>,
        <0,-2>,<0,0>,<0,2>
        texture {
          woodT_red
        }
        finish {
          reflection scratchplate
        }
      }
    } //end union
//----interior cutaway
    prism {
      cubic_spline  
      0.1,3.9,18,
      <10,4>,<1,6>,<-4.5,4>,<-4,0>,
      <-3.6,-2>,<-4,-3.5>,<-6,-7>,<-4,-10.5>,
      <0,-12>,<4,-10.5>,<6,-7>,<4,-3.5>,
      <3.6,-2>,<4,0>,<5,3.5>,<2,3>,
      <1,6>,<1,8>
      translate <0, 0, 3>
      scale <.9,0,.95>
      translate <0, 0, -3>
      texture {
        woodT_light
      }
    }
    cylinder {
      <0,5,0>,
      <0,0.2,0>,
      2
      texture {
        woodT_light
      }
    }
    finish {
      reflection guitar
    }
  } //end difference
//--neck
  difference {
    union {
//----fretboard
      #while (counter<21)
        box {
          <-1,0,0>,
          <1,.2,2>
          texture {
            woodT_dark2
          }
          translate <0,0,translation>
        }
        difference {
          sphere_sweep {
            linear_spline,
            2,
            <-1,.2,2>,.1
            <1,.2,2>,.1
            texture {
              metalT_chrome
            }
            finish {
              reflection chrome
            }
          }
          box {
            <-1,0,1.8>,
            <-1.2,.4,2.2>
          }
          box {
            <1,0,1.8>,
            <1.2,.4,2.2>
          }
          translate <0,0,translation>
        }
        #declare translation = translation-dTranslation;
        #declare dTranslation = dTranslation-ddTranslation;
        #declare counter = counter + 1;
      #end
//----neck piece
      difference{
        blob {
          cylinder {
            <0,0,-11>,
            <0,0,4.3>,
            1, 1
            scale <1.1,.75,1>
          }
          cylinder {
            <0,0,-10>,
            <0,-4,-10>,
            1, 1
          }
          threshold .1
        }
        box {
          <-1,-.01,-12>,
          <1,1,7>
        }
        box {
          <-1.5,0.1,3>,
          <1.5,1,6>
          rotate <5,0,0>
        } 
        box { 
          <-1,-4,-9>,
          <1,-5,-11>
        }
        texture {
          woodT_dark
        }
        finish {
          reflection guitar
        }
      }
      translate <0,4,16>
    } //end union
    cylinder {
      <0,5,0>,
      <0,0.2,0>,
      2
      texture {
        woodT_dark2
      }
    }
  } //end difference
//--nut
  box {
    <-1,4.1,19.2>,
    <1,4.35,19.4>
    texture {
      woodT_white
    }
  }
//--head
  union {
    difference {
      box {
        <-1.5,0,0>,
        <1.5,-.59,6>
      }
      cylinder {
        <-5.9,.1,-.5>,
        <-5.9,-.6,-.5>,
        5
      }
      cylinder {
        <5.9,.1,-.5>,
        <5.9,-.6,-.5>,
        5
      }
      box {
        <-1.5,0,0>,
        <1.5,-.59,6>
        rotate <17.5,0,0>
      }
      texture {
        woodT_dark
      }
      finish {
        reflection guitar
      }
    }
    difference {
      box {
        <-1.5,-0,0>,
        <1.5,.001,6>
      }
      cylinder {
        <-5.9,.1,-.5>,
        <-5.9,-.501,-.5>,
        5
      }
      cylinder {
        <5.9,.1,-.5>,
        <5.9,-.501,-.5>,
        5
      }
      box {
        <-1.5,0,0>,
        <1.5,-.59,6>
        rotate <17,0,0>
      }
      scale <.9,1,.97>
      texture {
        woodT_dark2
      }
      finish {
        reflection guitar
      }
    }
    #while (yCounter < 3)
      #while (xCounter < 2)
        lathe {
          linear_spline
          7,
          <0,-.6>,<.25,-.6>,
          <.3,0>,<.1,.05>,
          <.1,.22>,<.125,.27>,
          <0,.3>
          texture {
            metalT_chrome
          }
          finish {
            reflection chrome
          }
          translate <1.8*xCounter-.9,0,5.2-1.45*yCounter>
        }
        superellipsoid {
          <.2,.2>
          scale <.5,.3,.4>
          translate <1.6*xCounter-.8,-.7,5.2-1.45*yCounter>
          texture {
            metalT_chrome
          }
          finish {
            reflection chrome
          }
        }
        #declare xCounter = xCounter + 1;
      #end
      #declare xCounter = 0;
      union {
        cylinder {
          <0,0,0>,
          <-1,0,0>,
          .1
          translate <-.9,-.75,5.1-1.45*yCounter>
          texture {
            metalT_chrome
          }
          finish {
            reflection chrome
          }
        }
        cylinder {
          <0,0,0>,
          <1,0,0>,
          .1
          translate <.9,-.75,5.1-1.45*yCounter>
          texture {
            metalT_chrome
          }
          finish {
            reflection chrome
          }
        }
        lathe {
          cubic_spline
          6,
          <-1,-.2>,<0,0>,
          <.4,.2>,<.3,.55>,
          <0,.65>,<-1,.75>
          scale <.3,1,1>
          rotate <0,100*rand(random1),90>
          translate <-1.7,-.75,5.1-1.45*yCounter>
          texture {
            metalT_chrome
          }
          finish {
            reflection chrome
          }
        }
        lathe {
          cubic_spline
          6,
          <-1,.2>,<0,0>,
          <.4,-.2>,<.3,-.55>,
          <0,-.65>,<-1,-.75>
          scale <.3,1,1>
          rotate <0,100*rand(random2),90>
          translate <1.7,-.75,5.1-1.45*yCounter>
          texture {
            metalT_chrome
          }
          finish {
            reflection chrome
          }
        }
        
      }
      #declare yCounter = yCounter + 1;
    #end
    #declare yCounter = 0;  
    rotate <5,0,0>
    translate <0,4,19>
  }
//--bridge
  union {
//----wooden block
    difference {
      box {
        <-2.5,0,0>,
        <2.5,.15,2>
      }
      prism {
        cubic_spline
        .6,-.1,11,
        <2,2>,<0,2>,<-1.7,1.8>,<-2.5,2>,
        <-3,3>,<0,6>,<3,3>,
        <2.5,2>,<1.7,1.8>,<0,2>,<-2,2>
      }
      prism {
        cubic_spline
        .6,-.1,9,
        <-6,1><-5,1>,<-3,2>,
        <-2.5,2>,<-2.1,0.7>,<-2.5,0>,
        <-3,-1>,<-5,1>,<-4,1>
      }
      prism {
        cubic_spline
        .6,-.1,9,
        <6,1><5,1>,<3,2>,
        <2.5,2>,<2.1,0.7>,<2.5,0>,
        <3,-1>,<5,1>,<4,1>
      }
      prism {
        cubic_spline
        .6,-.1,11,
        <1,-2>,<0,0>,<-1,.2>,<-2.5,0>,
        <-3,-1>,<0,-2>,<3,-1>,
        <2.5,0>,<1,.2>,<0,0>,<-1,-2>
      }
      box {
        <-2.5,0,0>,
        <2.5,.2,2>
        rotate <-16,0,0>
      }
       box {
        <-2.5,0,0>,
        <2.5,.2,-2>
        rotate <8,0,0>
        translate <0,0,2>
      }
      texture {
        woodT_black
      }
    }
//----bar
    box {
      <-1,0,1.5>
      <1,.35,1.4>
      texture {
        woodT_white
      }
    }
//----string pegs
    #while (xCounter < 6)
      sphere {
        <0,.2,.725>,.1
        translate <-.7+(xCounter*.28),0,0>
        texture {
          woodT_white
        }
      }
      #declare xCounter = xCounter + 1;
    #end
    #declare xCounter = 0;
    translate<0,4,-8>
    finish {
      reflection guitar
    }
  }
//--strings
//----main strings
  #while (xCounter < 6)
    sphere_sweep {
      linear_spline
      3,
      <0,4.15,-7.275>,.03-((.02/6)*xCounter),
      <0,4.35,-6.6>,.03-((.02/6)*xCounter),
      <0,4.35,19.4>,.03-((.02/6)*xCounter)
      translate <-.7+(xCounter*.28),0,0>
      texture {
        metalT_steel
      }
      finish {
        reflection steel
      }
    }
    #declare xCounter = xCounter + 1;
  #end
//----strings at head
  union {
    sphere_sweep {
      linear_spline
      2,
      <-.7,4.35,19.4>,.03
      <-.9,3.9,21.3>,.03
    }
    sphere_sweep {
      linear_spline
      2,
      <-.42,4.35,19.4>,.03-(.02/6),
      <-.9,3.8,22.75>,.03-(.02/6)
    }
    sphere_sweep {
      linear_spline
      2,
      <-.14,4.35,19.4>,.03-2*(.02/6),
      <-.9,3.7,24.2>,.03-2*(.02/6)
    }
    sphere_sweep {
      linear_spline
      2,
      <.14,4.35,19.4>,.03-3*(.02/6),
      <.9,3.7,24.2>,.03-3*(.02/6)
    }
    sphere_sweep {
      linear_spline
      2,
      <.42,4.35,19.4>,.03-4*(.02/6),
      <.9,3.8,22.75>,.03-4*(.02/6)
    }
    sphere_sweep {
      linear_spline
      2,
      <.7,4.35,19.4>,.03-5*(.02/6),
      <.9,3.9,21.3>,.03-5*(.02/6)
    }
    texture {
      metalT_steel
    }
    finish {
      reflection steel
    }
  }
  #if (position=0)
    rotate <-90, 40, 0>
    translate <1, -6.5, 0>
  #else
    #if (position=1)
      rotate <-90, 0,-70>
      rotate <25,0,0>
      translate <-5, -.5, -10>
    #else
      rotate rotator
      translate translator
    #end 
  #end
}

//--lights--------------------------

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <2,2,2>    // light's color
  translate <-20, 40, -20>
}

//--camera--------------------------

// perspective (default) camera
camera {
  location  <0.0, 0.0, -41.0>
  look_at   <0.0, -23.0,  0.0> 
  right     x*image_width/image_height
}
