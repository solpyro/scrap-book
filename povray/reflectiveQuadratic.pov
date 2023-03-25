// Persistence of Vision Ray Tracer Scene Description File
// File: ?.pov
// Vers: 3.6
// Desc: Checkered Floor Example
// Date: mm/dd/yy
// Auth: ?
//

#version 3.6;

#include "colors.inc"

global_settings {
  assumed_gamma 1.0
  max_trace_level 5
}

// ----------------------------------------

camera {
  location  <0.0, 0.5, -4.0>
  direction 1.5*z
  right     x*image_width/image_height
  look_at   <0.0, 0.0,  0.0>
}

sky_sphere {
  pigment {
    gradient y
    color_map {
      [0.0 rgb <0.6,0.7,1.0>]
      [0.7 rgb <0.0,0.1,0.8>]
    }
  }
}

light_source {
  <0, 0, 0>            // light's position (translated below)
  color rgb <1, 1, 1>  // light's color
  translate <-30, 30, -30>
}

// ----------------------------------------

plane {               // checkered floor
  y, -1
  texture
  {
    pigment {
      checker
      color rgb 1
      color blue 1
      scale 0.5
    }
    finish{
      diffuse 0.8
      ambient 0.1
    }
  }
}

// create an Nth order infinite polynomial surface
// poly { N <a,b,c...> [sturm] }
// N = order of poly, M terms where M = (N+1)*(N+2)*(N+3)/6
poly {
  5, // order of polynomial (2...7)
  <
// x^5,        x^4y,       x^4z,       x^4,
   0,          0,          0,          0,
// x^3y^2,     x^3yz,      x^3y,       x^3z^2,
   0,          0,          0,          0,
// x^3z,       x^3,        x^2y^3,     x^2y^2z,
   0,          0,          0,          0,
// x^2y^2,     x^2yz^2,    x^2yz,      x^2y,
   0,          0,          0,          0,
// x^2z^3,     x^2z^2,     x^2z,       x^2,
   0,          0,          0,          0,
// xy^4,       xy^3z,      xy^3,       xy^2z^2,
   0,          0,          0,          0,
// xy^2z,      xy^2,       xyz^3,      xyz^2,
   0,          0,          0,          0,
// xyz,        xy,         xz^4,       xz^3,
   0,          0,          0,          0,
// xz^2,       xz,         x,          y^5,
   0,          0,          0,          0,
// y^4z,       y^4,        y^3z^2,     y^3z,
   0,          0,          0,          0,
// y^3,        y^2z^3,     y^2z^2,     y^2z,
   0,          0,          0,          0,
// y^2,        yz^4,       yz^3,       yz^2,
   0,          0,          0,          0,
// yz,         y,          z^5,        z^4,
   0,          0,          0,          0,
// z^3,        z^2,        z,          C           
   0,          0,          0,          0
  >
  sturm // optional, slower but reduces speckles
  texture {
    pigment {
      color rgb <0.8,0.8,1.0>
    }
    finish{
      diffuse 0.3
      ambient 0.0
      specular 0.6
      reflection {
        0.8
        metallic
      }
      conserve_energy
    }
  }
}

