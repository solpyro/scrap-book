//--global--------------------------

global_settings {
  assumed_gamma 1.0
  max_trace_level 5
    photons {
      //spacing 0.02                 // specify the density of photons
      count 200000               // alternatively use a total number of photons

      //gather min, max            // amount of photons gathered during render [20, 100]
      //media max_steps [,factor]  // media photons
      jitter 1.0                 // jitter phor photon rays
      //max_trace_level 5          // optional separate max_trace_level
      //adc_bailout 1/255          // see global adc_bailout
      //save_file "filename"       // save photons to file
      //load_file "filename"       // load photons from file
      //autostop 0                 // photon autostop option
      //radius 10                  // manually specified search radius
      // (---Adaptive Search Radius---)
      //steps 1
      //expand_thresholds 0.2, 40
    }
}

//--includes------------------------

#include "metals.inc"
#include "woods.inc"
#include "glass.inc"

//--declares------------------------

#declare glassColour = pigment { Col_Glass_General };
#declare brassColour = T_Brass_3D;
#declare copperColour = T_Copper_4C;
#declare woodColour = T_Wood2;

#declare objectType = 1;
/* 1 = magnifying glass
 * 2 = spy glass
 */

#if (objectType = 1)
//magnifying glass rotation
#declare xRotate = 0;
#declare yRotate = 20;
#declare zRotate = 40;
#end
#if (objectType = 2)
//spyglass rotation
#declare xRotate = 0;
#declare yRotate = 0;
#declare zRotate = 0;
//spyglass extention - .1 = none, 1 = full
#declare centreCylinder = 1;
#declare bottomCylinder = 1;
#end

//--objects-------------------------

#if (objectType = 1)
//Magnifying glass
union {
//--lens
  intersection {
    sphere {
      <0, 0, 5.4>, 5.5
    }
    sphere {
      <0, 0, -5.4>, 5.5
    }
    cylinder {
      <0, 0, -.5>,
      <0, 0, .5>,
      1
    }
    texture {
      glassColour
    }
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
  }
//--collar
  difference {
    cylinder {
      <0, 0, -.1>,
      <0, 0, .1>,
      1.01
    }
    cylinder {
      <0, 0, -1>,
      <0, 0, 1>,
      1
    }
    texture {
      brassColour
    }
  }
//--handle
//----brass neck
  lathe {
    cubic_spline
    9,
    <.1, 1>, <.1, 0>, <.1, -.05>,
    <.08, -.1>, <.1, -.15>, <.08, -.2>,
    <.1, -.25>, <.1, -.3> <.1, -1>
    texture {
      brassColour
    }
    translate <0, -1.01, 0>
  }
//----wooden shaft
  lathe {
    cubic_spline
    5,
    <.1, 1>, <.1, 0>, <.15, -2>,
    <0, -2.15>, <.15, -2>
    texture {
      woodColour
    }
    translate <0, -1.31, 0>
  }
  rotate <0, yRotate, 0>
  rotate <0, 0, zRotate>
  rotate <xRotate, 0, 0>
}
#end

#if (objectType = 2)
//Spyglass
union {
//--lens
//----large lens
  intersection {
    sphere {
      <0, 1.4, 0>, 1.5
    }
    sphere {
      <0, -1.4, 0>, 1.5
    }
    cylinder {
      <0, .1, 0>,
      <0, -.1, 0>,
      .5
    }
    texture {
      glassColour
    }
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
  }
//----small lens
  intersection {
    sphere {
      <0, 1, 0>, 1.1
    }
    sphere {
      <0, -1, 0>, 1.1
    }
    cylinder {
      <0, .1, 0>,
      <0, -.1, 0>,
      .4
    }
    texture {
      glassColour
    }
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
    translate <0, -centreCylinder-bottomCylinder-.9, 0>
  }
//--tube
//----large tube
  difference {
    union {
      cylinder {
        <0, .1, 0>,
        <0, -1, 0>,
        .55
        texture {
          brassColour
        }
      }
      torus {
        .55, .05
        texture {
          copperColour
        }
        translate <0, .1, 0>
      }
      torus {
        .55, .05
        texture {
          copperColour
        }
        translate <0, -1, 0>
      }
    }
    cylinder {
      <0, .2, 0>,
      <0, -1.1, 0>,
      .5
      texture {
        brassColour
      }
    }
  }
//----medium tube
  difference {
    union {
      cylinder {
        <0, .1, 0>,
        <0, -1, 0>,
        .5
        texture {
          brassColour
        }
      }
      torus {
        .50, .05
        texture {
          copperColour
        }
        translate <0, -1, 0>
      }
    }
    cylinder {
      <0, .11, 0>,
      <0, -1.01, 0>,
      .45
      texture {
        brassColour
      }
    }
    translate <0, -centreCylinder, 0>
  }
//----small tube
  difference {
    union {
      cylinder {
        <0, .1, 0>,
        <0, -1, 0>,
        .45
        texture {
          brassColour
        }
      }
      lathe {
        cubic_spline
        9,
        <.4, 0>, <.45, .05>, <.5, 0>,
        <.45, -.05>, <.35, -.15>, <.4, -.2>,
        <.3, -.2>, <.34, -.14>, <.34, -0> 
        texture {
          copperColour
        }
        translate <0, -1, 0>
      }
    }
    cylinder {
      <0, .11, 0>,
      <0, -1.01, 0>,
      .4
      texture {
        brassColour
      }
    }
    translate <0, -centreCylinder-bottomCylinder, 0>
  }
  rotate <0, yRotate, 0>
  rotate <0, 0, zRotate>
  rotate <xRotate, 0, 0>
}
#end

//Background
plane {
  z, 5
  texture {
    pigment {
      checker
        color rgb <1, 1, 1>,
        color rgb <.5, .5, .5>
    }
  }
}    
text {
  ttf "trebuc.ttf"
  "The Quick Brown Fox Jumped Over The Lazy Dog"
  1,0
  pigment {color rgb <1,0,0>} 
  scale <.5,.5,0> 
  translate <-5,3.3,4.99>
}


//--lights--------------------------

light_source {
  0*x
  color rgb <1,1,1>
  translate <5, 10, -5>
}

//--camera--------------------------

camera {
  location  <0, -4, -6>
  look_at   <1, -1,  0.0>
  right     x*image_width/image_height
}
