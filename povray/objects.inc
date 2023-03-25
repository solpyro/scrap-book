//--default values-------

#declare r = 1;
#declare g = 1;
#declare b = 1;
#declare l = 1;

//--objects--------------

//--simple light bulb
#declare light = union {
                               sphere {
                                 <0, 0, 0>, 1
                                 pigment {
                                   color rgbt <r, g, b, .95>
                                 }
                               }
                               light_source {
                                 0*x
                                 color rgb l
                                 translate <-20, 40, -20>
                               }
                             }
