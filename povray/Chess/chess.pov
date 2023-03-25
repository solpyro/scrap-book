//--includes------------------------       

#include "colors.inc" 
#include "stones.inc" 
#include "woods.inc"  
#include "metals.inc"

//--declares------------------------


//piece positional declares
#declare BKR  = <1,0,1>; //1,0,1
#declare BKN  = <2,0,1>; //2,0,1
#declare BKB  = <3,0,1>; //3,0,1
#declare BK   = <4,0,1>; //4,0,1
#declare BQ   = <5,0,1>; //5,0,1
#declare BQB  = <6,0,1>; //6,0,1
#declare BQN  = <7,0,1>; //7,0,1
#declare BQR  = <8,0,1>; //8,0,1

#declare BKRP = <1,0,2>; //1,0,2
#declare BKNP = <2,0,2>; //2,0,2
#declare BKBP = <3,0,2>; //3,0,2
#declare BKP  = <4,0,2>; //4,0,2
#declare BQP  = <5,0,2>; //5,0,2
#declare BQBP = <6,0,2>; //6,0,2
#declare BQNP = <7,0,2>; //7,0,2
#declare BQRP = <8,0,2>; //8,0,2

#declare WKR  = <1,0,8>; //1,0,8
#declare WKN  = <2,0,8>; //2,0,8
#declare WKB  = <3,0,8>; //3,0,8
#declare WK   = <4,0,8>; //4,0,8
#declare WQ   = <5,0,8>; //5,0,8
#declare WQB  = <6,0,8>; //6,0,8
#declare WQN  = <7,0,8>; //7,0,8
#declare WQR  = <8,0,8>; //8,0,8

#declare WKRP = <1,0,7>; //1,0,7
#declare WKNP = <2,0,7>; //2,0,7
#declare WKBP = <3,0,7>; //3,0,7
#declare WKP  = <4,0,7>; //4,0,7
#declare WQP  = <5,0,7>; //5,0,7
#declare WQBP = <6,0,7>; //6,0,7
#declare WQNP = <7,0,7>; //7,0,7
#declare WQRP = <8,0,7>; //8,0,7

//internal declares
#declare textures = true;
                     
//boolean show/hide
#declare king     = true;
#declare queen    = true;
#declare bishop   = true;
#declare knight   = true;
#declare rook     = true;
#declare pawn     = true;
#declare board    = true;
#declare numbers  = true;

#declare scene    = false; //still building                            
    
//camera translations:   full board (black end) | full board (white end) | angle        | side view   | full scene   | clock view
#declare cameraPos  = <0,30,30>; //<0, 30, -30> |            <0, 30, 30> | <30, 30, 30> | <30, 30, 0> | <100,100, 0> | <  0, 10, 0>
#declare cameraLook = <0, 0, 0>; //<0,  0,   0> |            <0,  0,  0> | < 0,  0,  0> | < 0,  0, 0> | <  0,  0, 0> | <-30,  0, 0>


//textures         
#if (textures)    
  
  #declare tBlack = T_Stone31;
  #declare tWhite = T_Stone8;
  #declare tGrey  = T_Stone4;
  #declare tWood  = T_Wood18;                                  
  #declare tMetal = T_Chrome_2D;
  
  #declare tcMetal = T_Chrome_3B;
  #declare tcWood  = T_Wood27;
  #declare tcHands = pigment{colour rgb <.0,.0,.0>};
  
  #declare tcGlass = pigment {
                       colour rgbt
                        <0.8, 0.9, 0.85, 0.85>
                     };
  
       
#else
       
  #declare tBlack = pigment{colour rgb <1,0,0>};
  #declare tWhite = pigment{colour rgb <0,1,0>};
  #declare tGrey  = pigment{colour rgb <0,0,1>}; 
  #declare tWood  = pigment{colour rgb <1,1,0>};
  #declare tMetal = pigment{colour rgb <0,1,1>};
  
  #declare tcMetal = pigment{colour rgb <1,0,1>};
  #declare tcWood  = pigment{colour rgb <1,.5,0>}; 
  #declare tcHands = pigment{colour rgb <.5,1,0>};
   
  #declare tcGlass = pigment{colour rgbf <1,1,1,1>};

#end        

#declare xCount   = 0;
#declare zCount   = 0; 
#declare rCount   = 0;
#declare bCurrent = false;    
#declare font     = "bkant.ttf";

//--global--------------------------

global_settings {
  assumed_gamma 1.0
  max_trace_level 5
  #if (textures)          // global photon block
    photons {
      count 200000               // alternatively use a total number of photons
     jitter 1.0                 // jitter phor photon rays
    }
  #end
}

//--objects-------------------------


#if(board)
union {
  box {
    <-18,-2,-18>,<18,0,18>
    texture {tGrey}
    finish {
      reflection .2
    } 
  }
  #while (xCount < 8)
    #while(zCount < 8)
      box {
        <-1.9,-1.9,-1.9>,<1.9,0.001,1.9>
        #if (bCurrent) 
          texture {tWhite}  
        #else
          texture {tBlack}  
        #end 
        finish {
          reflection .5
        }     
        translate <-14+(xCount*4),0,-14+(zCount*4)>
      }     
      #declare bCurrent = !bCurrent;
      #declare zCount = zCount + 1;
    #end         
    #declare bCurrent = !bCurrent;                  
    #declare xCount = xCount + 1;
    #declare zCount = 0;
  #end
  
  #declare xCount = 0;
  #while ((xCount < 8)&(numbers))
    text {
      ttf font str(xCount+1,1,0) 1, 0
      texture{tMetal}
      scale 1.8
      rotate<90,180,0>
      translate<-13.7+(4*xCount),0.001,17.5>
    }   
    text {
      ttf font str(xCount+1,1,0) 1, 0
      texture{tMetal}
      scale 1.8
      rotate<90,0,0>
      translate<-14.3+(4*xCount),0.001,-17.5>
    }  
    
    text {
      ttf font str(xCount+1,1,0) 1, 0
      texture{tMetal}
      scale 1.8
      rotate<90,180,0>
      translate<17.3,0.001,-13.5+(4*xCount)>
    }  
    text {
      ttf font str(xCount+1,1,0) 1, 0
      texture{tMetal}
      scale 1.8
      rotate<90,0,0>
      translate<-17.3,0.001,-14.6+(4*xCount)>
    }
    #declare xCount = xCount + 1;
  #end                   
}         
#end      

#if(king)    
   
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.8
      scale <0,.3,0>  
      translate <0,3.5,0>
    }
    lathe {
      cubic_spline
      6,
      <0,3>,<.3,3.4>,<.6,4.4>,<.4,4.6>,<0,4.5>,<-1,4.2>
    }
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3.7,0>
    } 
    texture{tWhite}
  }
  translate (BK*4)-<18,0,18>//<2,0,-14>
}       

union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.8
      scale <0,.3,0>  
      translate <0,3.5,0>
    }
    lathe {
      cubic_spline
      6,
      <0,3>,<.3,3.4>,<.6,4.4>,<.4,4.6>,<0,4.5>,<-1,4.2>
    }
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3.7,0>
    } 
    texture{tBlack}
  }
  translate (WK*4)-<18,0,18>//<-2,0,14>
}

#end      

#if(queen)

union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.8
      scale <0,.3,0>  
      translate <0,3.5,0>
    }
    difference {           
      cone {        
        <0,3.6,0>,.4,
        <0,4.5,0>,.6
      }
      #while (rCount < 3)
        cylinder {
          <-1,0,0>,<1,0,0>,.5
          translate <0,4.9,0> 
          rotate <0,60*rCount,0>
        }
        #declare rCount = rCount + 1;
      #end
    }
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3.7,0>
    } 
    texture{tWhite}
  }
  translate (BQ*4)-<18,0,18>//<-2,0,-14> 
}  

union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.8
      scale <0,.3,0>  
      translate <0,3.5,0>
    }
    difference {           
      cone {        
        <0,3.6,0>,.4,
        <0,4.5,0>,.6
      }   
      #declare rCount = 0;
      #while (rCount < 3)
        cylinder {
          <-1,0,0>,<1,0,0>,.5
          translate <0,4.9,0> 
          rotate <0,60*rCount,0>
        }
        #declare rCount = rCount + 1;
      #end
    }
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3.7,0>
    } 
    texture{tBlack}
  }
  translate (WQ*4)-<18,0,18>//<2,0,14> 
}

#end      

#if(bishop) 

union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,3.5,0>
    }
    difference {
      sphere {
        <0,4,0>,.7
        scale <.7,0,.7>
      }
      box {
        <-1,0,-.05>,<1,1,.05>
        rotate <-25,0,0>
        translate <0,3.9,0>
      }
    } 
    sphere {
      <0,4.7,0>,.15
    }
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3.7,0>
    } 
    texture{tWhite}
  }
  translate (BQB*4)-<18,0,18>//<6,0,-14>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,3.5,0>
    }
    difference {
      sphere {
        <0,4,0>,.7
        scale <.7,0,.7>
      }
      box {
        <-1,0,-.05>,<1,1,.05>
        rotate <-25,0,0>
        translate <0,3.9,0>
      }
    } 
    sphere {
      <0,4.7,0>,.15
    }
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3.7,0>
    } 
    texture{tWhite}
  }
  translate (BKB*4)-<18,0,18>//<-6,0,-14>
} 

union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,3.5,0>
    }
    difference {
      sphere {
        <0,4,0>,.7
        scale <.7,0,.7>
      }
      box {
        <-1,0,-.05>,<1,1,.05>
        rotate <-25,0,0>
        translate <0,3.9,0>
      }
    } 
    sphere {
      <0,4.7,0>,.15
    }
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3.7,0>
    } 
    texture{tBlack}
  }       
  rotate <0,180,0>
  translate (WQB*4)-<18,0,18>//<6,0,14>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,3.5,0>
    }
    difference {
      sphere {
        <0,4,0>,.7
        scale <.7,0,.7>
      }
      box {
        <-1,0,-.05>,<1,1,.05>
        rotate <-25,0,0>
        translate <0,3.9,0>
      }
    } 
    sphere {
      <0,4.7,0>,.15
    }
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3.7,0>
    } 
    texture{tBlack}
  }                  
  rotate <0,180,0>
  translate (WKB*4)-<18,0,18>//<-6,0,14>
}     

#end      

#if(knight)

union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    cylinder {
      <0,3.5,0>,<0,4.7,0>,.7
      
    }
    cone {
      <0,4.7,0>,.7,
      <0,4.9,0>,0
    }    
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    } 
    intersection {
      union {
        box {
          <-.5,4.4,0>,<.5,4.5,1>
        }
        box {
          <-.05,3.5,0>,<.05,4.5,1>
        }
      }
      cylinder {
        <0,3.5,0>,<0,4.7,0>,.7001
      
      }
    }
    texture{tWhite}
  }   
  translate (BKN*4)-<18,0,18>//<10,0,-14> 
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    cylinder {
      <0,3.5,0>,<0,4.7,0>,.7
      
    }
    cone {
      <0,4.7,0>,.7,
      <0,4.9,0>,0
    }    
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    } 
    intersection {
      union {
        box {
          <-.5,4.4,0>,<.5,4.5,1>
        }
        box {
          <-.05,3.5,0>,<.05,4.5,1>
        }
      }
      cylinder {
        <0,3.5,0>,<0,4.7,0>,.7001
      
      }
    }
    texture{tWhite}
  }   
  translate (BQN*4)-<18,0,18>//<-10,0,-14> 
}  



union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    cylinder {
      <0,3.5,0>,<0,4.7,0>,.7
      
    }
    cone {
      <0,4.7,0>,.7,
      <0,4.9,0>,0
    }    
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    } 
    intersection {
      union {
        box {
          <-.5,4.4,0>,<.5,4.5,1>
        }
        box {
          <-.05,3.5,0>,<.05,4.5,1>
        }
      }
      cylinder {
        <0,3.5,0>,<0,4.7,0>,.7001
      
      }
    }
    texture{tBlack}
  }                   
  rotate y*180
  translate (WKN*4)-<18,0,18>//<10,0,14> 
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    cylinder {
      <0,3.5,0>,<0,4.7,0>,.7
      
    }
    cone {
      <0,4.7,0>,.7,
      <0,4.9,0>,0
    }    
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    } 
    intersection {
      union {
        box {
          <-.5,4.4,0>,<.5,4.5,1>
        }
        box {
          <-.05,3.5,0>,<.05,4.5,1>
        }
      }
      cylinder {
        <0,3.5,0>,<0,4.7,0>,.7001
      
      }
    }
    texture{tBlack}
  }                  
  rotate y*180
  translate (WQN*4)-<18,0,18>//<-10,0,14> 
}  

#end      

#if(rook) 

union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    torus { 
      .5,.1
      translate <0,3.7,0>
    }
    torus { 
      .7,.1
      translate <0,3.9,0>
    }
    difference {
      cylinder {
        <0,3.9,0>,<0,4.6,0>,.8
      }
      cylinder {
        <0,4,0>,<0,4.7,0>,.6
      }
      #declare rCount = 0;
      #while (rCount < 3)
        box {
          <-.05,4.2,-1>,<.05,4.8,1>
          rotate <0,60*rCount,0>
        }               
        #declare rCount = rCount + 1;
      #end           
    }
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3.6,0>
    }    
    torus { 
      .6,.1
      translate <0,3.8,0>
    } 
    texture{tWhite}
  }
  translate (BKR*4)-<18,0,18>//<-14,0,-14>
}  
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    torus { 
      .5,.1
      translate <0,3.7,0>
    }
    torus { 
      .7,.1
      translate <0,3.9,0>
    }
    difference {
      cylinder {
        <0,3.9,0>,<0,4.6,0>,.8
      }
      cylinder {
        <0,4,0>,<0,4.7,0>,.6
      }
      #declare rCount = 0;
      #while (rCount < 3)
        box {
          <-.05,4.2,-1>,<.05,4.8,1>
          rotate <0,60*rCount,0>
        }               
        #declare rCount = rCount + 1;
      #end           
    }
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3.6,0>
    }    
    torus { 
      .6,.1
      translate <0,3.8,0>
    } 
    texture{tWhite}
  }
  translate (BQR*4)-<18,0,18>//<14,0,-14>
} 

union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    torus { 
      .5,.1
      translate <0,3.7,0>
    }
    torus { 
      .7,.1
      translate <0,3.9,0>
    }
    difference {
      cylinder {
        <0,3.9,0>,<0,4.6,0>,.8
      }
      cylinder {
        <0,4,0>,<0,4.7,0>,.6
      }
      #declare rCount = 0;
      #while (rCount < 3)
        box {
          <-.05,4.2,-1>,<.05,4.8,1>
          rotate <0,60*rCount,0>
        }               
        #declare rCount = rCount + 1;
      #end           
    }
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3.6,0>
    }    
    torus { 
      .6,.1
      translate <0,3.8,0>
    } 
    texture{tBlack}
  }
  translate (WKR*4)-<18,0,18>//<-14,0,14>
}  
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,3.5>,<1,4>
    }
    //--crown
    torus { 
      .5,.1
      translate <0,3.7,0>
    }
    torus { 
      .7,.1
      translate <0,3.9,0>
    }
    difference {
      cylinder {
        <0,3.9,0>,<0,4.6,0>,.8
      }
      cylinder {
        <0,4,0>,<0,4.7,0>,.6
      }
      #declare rCount = 0;
      #while (rCount < 3)
        box {
          <-.05,4.2,-1>,<.05,4.8,1>
          rotate <0,60*rCount,0>
        }               
        #declare rCount = rCount + 1;
      #end           
    }
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.3,.1
      translate <0,.4,0>
    } 
    torus {
      1.1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3.6,0>
    }    
    torus { 
      .6,.1
      translate <0,3.8,0>
    } 
    texture{tBlack}
  }
  translate (WQR*4)-<18,0,18>//<14,0,14>
}     

#end      

#if(pawn) 

union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tWhite}
  }
  translate (BQRP*4)-<18,0,18>//<-14,0,-10>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tWhite}
  }
  translate (BQNP*4)-<18,0,18>//<-10,0,-10>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tWhite}
  }
  translate (BQBP*4)-<18,0,18>//<-6,0,-10>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tWhite}
  }
  translate (BQP*4)-<18,0,18>//<-2,0,-10>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tWhite}
  }
  translate (BKP*4)-<18,0,18>//<2,0,-10>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tWhite}
  }
  translate (BKBP*4)-<18,0,18>//<6,0,-10>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tWhite}
  }
  translate (BKNP*4)-<18,0,18>//<10,0,-10>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tBlack}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tWhite}
  }
  translate (BKRP*4)-<18,0,18>//<14,0,-10>
}

union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tBlack}
  }
  translate (WKRP*4)-<18,0,18>//<-14,0,10>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tBlack}
  }
  translate (WKNP*4)-<18,0,18>//<-10,0,10>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tBlack}
  }
  translate (WKBP*4)-<18,0,18>//<-6,0,10>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tBlack}
  }
  translate (WKP*4)-<18,0,18>//<-2,0,10>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tBlack}
  }
  translate (WQP*4)-<18,0,18>//<2,0,10>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tBlack}
  }
  translate (WQBP*4)-<18,0,18>//<6,0,10>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tBlack}
  }
  translate (WQNP*4)-<18,0,18>//<10,0,10>
}
union { 
  //body
  union {   
    //--base
    cylinder {
      <0,0,0>,<0,.2,0>,1.5
    }
    //--trunk  
    lathe {
      cubic_spline
      4,
      <5,.2>,<1.5,.2>,<.4,2.8>,<1,4>
    }
    //--crown
    sphere {
      <0,0,0>,.7
      scale <0,.3,0>  
      translate <0,2.8,0>
    }
    sphere {
      <0,3.5,0>,.6
    }
    texture{tWhite}    
  }   
  //decoration
  union {  
    torus {
      1.2,.1
      translate <0,.4,0>
    } 
    torus {
      1,.1
      translate <0,.7,0>
    }     
    torus { 
      .4,.1
      translate <0,3,0>
    } 
    texture{tBlack}
  }
  translate (WQRP*4)-<18,0,18>//<14,0,10>
}
 
#end  

#if (scene)
  //table
  box {
    <-40,-2,-30>,<40,-4,30>  
    texture{tWood}
  }
  //chess clock
  union {
    //main block
    difference {
      box {
        <-2,0,-8>,<2,8,8>
      }        
      cylinder {
        <1,4,4>,<4,4,4>,3
      }       
      cylinder {
        <1,4,-4>,<4,4,-4>,3
      }
      texture{tcWood}
    }
    //clock fittings
    torus {
      3,.25
      rotate z*90
      translate <2,4,4>
      texture {tcMetal}
    }               
    torus {
      3,.25
      rotate z*90
      translate <2,4,-4>
      texture {tcMetal}
    }
    cylinder {
      <1.9,4,-4>,<2,4,-4>,3
      texture {tcGlass}
      #if (textures)
        photons{              
          target 1.0      
          refraction on
          reflection on
        }
        interior {
          ior 1.35
          fade_power 1001
          fade_distance 0.9
          fade_color .98
        } 
        finish {
         reflection .03
        }
      #end
    } 
    cylinder {
      <1.9,4,4>,<2,4,4>,3
      texture {tcGlass}
      #if (textures)
        photons{              
          target 1.0      
          refraction on
          reflection on
        }
        interior {
          ior 1.35
          fade_power 1001
          fade_distance 0.9
          fade_color .98
        } 
        finish {
         reflection .03
        }
      #end
    }
    //clock faces
    cylinder {
      <1,4,-4>,<1.1,4,-4>,3 
      texture {
        pigment {
          colour rgb <1,1,1>
        }
      }
    }        
    cylinder {
      <1,4,4>,<1.1,4,4>,3 
      texture {
        pigment {
          colour rgb <1,1,1>
        }
      }
    }
    //clock hands
    union {
      sphere_sweep {
        linear_spline
        2,
        <0,0,0>,.25
        <0,2.5,0>,0
        rotate x*30
      }
      sphere_sweep {
        linear_spline
        2,
        <0,0,0>,.25
        <0,1.6,0>,0
        translate <.5,0,0>
        rotate x*120
      }
      scale x*.1
      translate <1.1,4,-4>
      texture {tcHands}
    } 
    union {
      sphere_sweep {
        linear_spline
        2,
        <0,0,0>,.25
        <0,2.5,0>,0
        rotate x*70
      }
      sphere_sweep {
        linear_spline
        2,
        <0,0,0>,.25
        <0,1.6,0>,0
        translate <.5,0,0>
        rotate x*140
      }
      scale x*.1
      translate <1.1,4,4>
      texture {tcHands}
    }             
    //clock lights
    light_source {
      0*x                  
      color rgb <.2,.2,.2>
      translate <1.3,7,4>
    }         
    light_source {
      0*x                  
      color rgb <.2,.2,.2>
      translate <1.3,7,-4>
    }    
    //buttons
    torus {
      1,.25
      translate <0,8,-6>
      texture {tcMetal}
    }        
    torus {
      1,.25
      translate <0,8,6>
      texture {tcMetal}
    }
    cylinder {
      <0,8,-6>,<0,8.4,-6>,.9
      texture {tcMetal}
    } 
    cylinder {
      <0,8,6>,<0,8.8,6>,.9
      texture {tcMetal}
    }
    sphere {
      <0,0,0>,.9
      scale y*.2
      translate <0,8.8,6> 
      texture {tcMetal}
    }   
    sphere {
      <0,0,0>,.9
      scale y*.2
      translate <0,8.4,-6> 
      texture {tcMetal}
    }
    translate <-24,-2,0>
  }
#end

//--lights--------------------------

light_source {
  0*x                  // light's position (translated below)
  color rgb <.7,.7,.7>    // light's color
  translate <0, 135, 0>
}              

//--camera--------------------------

// perspective (default) camera
camera {
  location  cameraPos
  look_at   cameraLook
  right     x*image_width/image_height
}