#include "colors.inc"

sky_sphere {
    pigment {
        gradient y
        color_map {
            [0.5 color MidnightBlue]
            [1.0 color Black]
        }
        scale 2
        translate -1
    }               
}           

plane { 
    y,0
    texture { 
        pigment {
            bozo    
            turbulence 2
            color_map {
                [0.0 color Red]
                [0.4 color Blue]
            }
        }
        scale 0.5
        rotate y*90
        rotate <10, 0, 15>
        translate z*4
    }
}                                         


camera {
   location <-5, 2, -15>
   angle 45 // direction <0, 0,  1.7>
   right x*image_width/image_height
   look_at <0,0,0>
}