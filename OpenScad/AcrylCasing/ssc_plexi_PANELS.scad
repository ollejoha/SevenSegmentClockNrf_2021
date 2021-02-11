////////////////////////////////////////////////////////////////////////
//////////////////////// Unit Information  ///////////////////////////////////
/*//////////////////////////////////////////////////////////////////////
date stated   : 2021-01-30
date finished : 2021-01-30
modeler       : Olle Johansson
application   : SevenSegmentClock (ClockNet)
module        : scc_plexi_Front_PANEL
version       : 0.1 beta
copyright     : Pipe Dreams / Forrest Floor
subject       : Seven Segment Clock
description   : LED Fram for attaching LED-Display in box.

version history
date            description
2021-01-21	    Start of re-design

*/
$fn = 100;

include <ssc_plexi_DIMENSIONS.scad>;
use <ssc_plexi_DETAIL_PARTS.scad>;

/***************************************************************************
 *
 *                                LOCAL RENDER
 *                      Used to view modules locally
 *
 ***************************************************************************/
//----
*ledFrame();

//...............
*baseSection();          //.. Template from wich top and bottom sections are derived

*translate([0,0,-2])
  bottomSection();        //.. Desktop version of bottom section

*translate([0,0,73])
  rotate([0,180,0])
    topSection();           //.. Top section used for both desktop and wall monted casings

*sideSection();          //.. Template for side secions

*translate([0,0,80])
  rotate([0,-90,0])
    leftSideSection();      //.. Left side section view from front to back

*translate([0,0,80])
  rotate([0,90,0])
    rightSideSection();     //.. Right side section view from fron to back

*blindFrontPanel();      //.. Template for front panel
*frontPanel();           //.. Front panel

*translate([0, 0,-3])
  frontPanelExt();

*templateBackSection();  //.. Template for the back section

*backSecionDesktop();    //.. Back section for desk top 

*barTrailLedStick();     //.. Mounting defintiioon for tha neo pixel stick (UV-index)

*neopixelStick();

/** USE ONLY AS REFERENCE **/
*translate([0,7,8.5])
  ledDisplay();     

  /** MILLING MODULES **/
*boxPanels();   //.. Bottom. sides & top panels

////////////////////////////////////////////////////////////////////////////////
////                     3D PRINTER MODULES RENDER                          ////
////////////////////////////////////////////////////////////////////////////////
3dFrontPanel();

 /***************************************************************************
 *
 *                                MODULES
 *
 ***************************************************************************/
  /** MILLING MODULES **/
module boxPanels() {   //.. Bottom. sides & top panels
  difference() {
    union() {
      translate([0, 0, -2])
        bottomSection();
      
      translate([-5, -87, 80])
        rotate([0, -90, 0])
          leftSideSection();

      translate([0, -87, 80])
        rotate([0, 90, 0])
          rightSideSection();

      translate([30, 50, 0])
        connectorMatrix();
    }
  }
}

module ledDisplay() {
  difference() {
    union() {
      cube([LED_DISPLAY_WIDTH, LED_DISPLAY_DEPTH, LED_DISPLAY_HEIGHT],center=true);
    }
  }
}

 /***************************************************************************
 *
 *                              NEW  MODULE SECTION
 *
 ***************************************************************************/
 
 /************************************************************************************************************
 **  Module:      baseSection
 **  Parameters : None
 **  Description: Box bottom section
 **              
 ************************************************************************************************************/
 module baseSection() {
   difference() {
     union() {
       cube([BOX_WIDTH, BOX_DEPTH, BOX_MATERIAL_THICKNESS],center=true);
     }
     /** front trail **/
    translate([0,-BOX_DEPTH/2 + FRONT_TRAIL_WIDTH/2 ,FRONT_TRAIL_HEIGHT/2]) 
      cube([BOX_WIDTH, FRONT_TRAIL_WIDTH, FRONT_TRAIL_HEIGHT],center=true);

     /** back trail **/
    translate([0,BOX_DEPTH/2 - COMMON_TRAIL_WIDTH/2 ,FRONT_TRAIL_HEIGHT/2]) 
      cube([BOX_WIDTH, COMMON_TRAIL_WIDTH, FRONT_TRAIL_HEIGHT],center=true);      
    
    /** left side trail **/
    translate([-BOX_WIDTH/2 + COMMON_TRAIL_WIDTH/2, 0 , COMMON_TRAIL_HEIGHT/2]) 
      rotate([0,0,90])
        cube([BOX_DEPTH, COMMON_TRAIL_WIDTH, COMMON_TRAIL_HEIGHT],center=true);

    /** right side trail **/
    translate([BOX_WIDTH/2 - COMMON_TRAIL_WIDTH/2, 0 , COMMON_TRAIL_HEIGHT/2]) 
      rotate([0,0,90])
        cube([BOX_DEPTH, COMMON_TRAIL_WIDTH, COMMON_TRAIL_HEIGHT],center=true);        
   }
 }

/************************************************************************************************************
 **  Module:      bottomSection
 **  Parameters : None
 **  Description: Box bottom section
 **              
 ************************************************************************************************************/
module bottomSection() {
  _vent_diameter = 2.5;
  _vent_height = BOX_MATERIAL_THICKNESS;
  
  difference() {
    union() {
      baseSection();
    }
    /** air channels **/
    for (a = [0:16:100])
      translate([-96/2 +a,0,0])
        hull() {
          translate([0,15,0])
            cylinder(d=_vent_diameter, h=_vent_height,center=true);
          translate([0,-15,0])
            cylinder(d=_vent_diameter, h=_vent_height,center=true);
        }
  }
}

  /************************************************************************************************************
 **  Module:      topSection
 **  Parameters : None
 **  Description: Box top section
 **              
 ************************************************************************************************************/
 module topSection() {
   difference() {
     union() {
       translate([0,0,BOX_HEIGHT])
        rotate([0,180,0]) {
          baseSection();
        }
     }
   }
 }

   /************************************************************************************************************
 **  Module:      sideSection
 **  Parameters : None
 **  Description: Box side section
 **              
 ************************************************************************************************************/
 module sideSection() {
   difference(){
     union() {
       cube([BOX_DEPTH, BOX_HEIGHT, BOX_MATERIAL_THICKNESS],center=true);
     }
     /** front trail **/
    translate([-BOX_DEPTH/2 + FRONT_TRAIL_WIDTH/2,0 ,BOX_MATERIAL_THICKNESS/2 - FRONT_TRAIL_HEIGHT/2]) 
      rotate([0,0,0])
        cube([FRONT_TRAIL_WIDTH, BOX_HEIGHT, FRONT_TRAIL_HEIGHT],center=true);

     /** back trail **/
    translate([BOX_DEPTH/2 - COMMON_TRAIL_WIDTH/2,0 ,BOX_MATERIAL_THICKNESS/2 - FRONT_TRAIL_HEIGHT/2]) 
      rotate([0,0,0])
        cube([COMMON_TRAIL_WIDTH, BOX_HEIGHT, FRONT_TRAIL_HEIGHT],center=true);        

   }
 }

 /************************************************************************************************************
 **  Module:      leftSideSection
 **  Parameters : None
 **  Description: Left box side section
 **              
 ************************************************************************************************************/
 module leftSideSection() {
   difference() {
     union() {
       translate([-BOX_WIDTH/2 + BOX_MATERIAL_THICKNESS/2,0,BOX_HEIGHT/2])
        rotate([90,0,90])
         sideSection();
     }
   }
 }

  /************************************************************************************************************
 **  Module:      rightSideSection
 **  Parameters : None
 **  Description: Right box side section
 **              
 ************************************************************************************************************/
 module rightSideSection() {
   difference() {
     union() {
       translate([BOX_WIDTH/2 - BOX_MATERIAL_THICKNESS/2,0,BOX_HEIGHT/2])
        rotate([-90,0,90])
         sideSection();
     }
   }
 }

 /************************************************************************************************************
 **  Module:      blindFrontPanel
 **  Parameters : None
 **  Description: Front panel
 **              
 ************************************************************************************************************/
 module blindFrontPanel() {
   _m3Diameter = 2.7;
   _m3Length = 4;
   _panel_hole_offset = 6;

   difference() {
     union() {
       color("DarkGray") {
       cube([FRONT_PANEL_WIDTH, FRONT_PANEL_DEPTH, FRONT_MATERIAL_THICKNESS],center=true);
       }
     }
     /** FRONT PANEL ATTACH HOLES **/
     translate([-FRONT_PANEL_WIDTH/2 + _panel_hole_offset, FRONT_PANEL_DEPTH/2 - _panel_hole_offset, FRONT_PANEL_HEIGHT/2-_m3Length/2])
      cylinder(d=_m3Diameter, h=_m3Length, center=true);

     translate([-FRONT_PANEL_WIDTH/2 + _panel_hole_offset, -FRONT_PANEL_DEPTH/2 + _panel_hole_offset, FRONT_PANEL_HEIGHT/2-_m3Length/2])
      cylinder(d=_m3Diameter, h=_m3Length, center=true);      

     translate([FRONT_PANEL_WIDTH/2 - _panel_hole_offset, FRONT_PANEL_DEPTH/2 - _panel_hole_offset, FRONT_PANEL_HEIGHT/2-_m3Length/2])
      cylinder(d=_m3Diameter, h=_m3Length, center=true);      

     translate([FRONT_PANEL_WIDTH/2 - _panel_hole_offset, -FRONT_PANEL_DEPTH/2 + _panel_hole_offset, FRONT_PANEL_HEIGHT/2-_m3Length/2])
      cylinder(d=_m3Diameter, h=_m3Length, center=true);            
   }
 }

 /************************************************************************************************************
 **  Module:      frontPanelExt
 **  Parameters : None
 **  Description: Front panel
 **              
 ************************************************************************************************************/
module frontPanelExt() {
  _tighten_cylinder_diam = 4;
  _tighten_cylinder_height = 5.8;
  _side_attach_knob_offset = 1.8;
  _lower_knob_attach_offset = 5.2;
  _upper_knob_attach_offset = 8.8;

  difference() {
    union() {
      frontPanel();

      /** LEFT DISPLAY ATTACH KNOBS **/
      translate([-LED_DISPLAY_WIDTH/2 - _side_attach_knob_offset,-7, 0.1])
        cylinder(d=_tighten_cylinder_diam, h=_tighten_cylinder_height,center=true);

      translate([-LED_DISPLAY_WIDTH/2 - _side_attach_knob_offset,6.5, 0.1])
        cylinder(d=_tighten_cylinder_diam, h=_tighten_cylinder_height,center=true);        

      translate([-LED_DISPLAY_WIDTH/2 - _side_attach_knob_offset,20, 0.1])
        cylinder(d=_tighten_cylinder_diam, h=_tighten_cylinder_height,center=true);         

      /** RIGHT DISPLAY ATTACH KNOBS **/
      translate([LED_DISPLAY_WIDTH/2 + _side_attach_knob_offset,-7, 0.1])
        cylinder(d=_tighten_cylinder_diam, h=_tighten_cylinder_height,center=true);

      translate([LED_DISPLAY_WIDTH/2 + _side_attach_knob_offset,6.5, 0.1])
        cylinder(d=_tighten_cylinder_diam, h=_tighten_cylinder_height,center=true);        

      translate([LED_DISPLAY_WIDTH/2 + _side_attach_knob_offset,20, 0.1])
        cylinder(d=_tighten_cylinder_diam, h=_tighten_cylinder_height,center=true);

      /** LOWER DISPLAY ATTACH KNOBS **/
      translate([0,-LED_DISPLAY_DEPTH/2 + _lower_knob_attach_offset, 0.1])
        cylinder(d=_tighten_cylinder_diam, h=_tighten_cylinder_height,center=true);

      translate([LED_DISPLAY_WIDTH/2 - 8,-LED_DISPLAY_DEPTH/2 + _lower_knob_attach_offset, 0.1])
        cylinder(d=_tighten_cylinder_diam, h=_tighten_cylinder_height,center=true);        

      translate([-LED_DISPLAY_WIDTH/2+8, - LED_DISPLAY_DEPTH/2 + _lower_knob_attach_offset, 0.1])
        cylinder(d=_tighten_cylinder_diam, h=_tighten_cylinder_height,center=true);

      /** UPPER DISPLAY ATTACH KNOBS **/
      translate([0, LED_DISPLAY_DEPTH/2 + _upper_knob_attach_offset, 0.1])
        cylinder(d=_tighten_cylinder_diam, h=_tighten_cylinder_height,center=true);

      translate([LED_DISPLAY_WIDTH/2 - 8, LED_DISPLAY_DEPTH/2 + _upper_knob_attach_offset, 0.1])
        cylinder(d=_tighten_cylinder_diam, h=_tighten_cylinder_height, center=true);        

      translate([-LED_DISPLAY_WIDTH/2 + 8, LED_DISPLAY_DEPTH/2 + _upper_knob_attach_offset, 0.1])
        cylinder(d=_tighten_cylinder_diam, h=_tighten_cylinder_height, center=true);

      /** THE TWO SECTIONS BELOW ARE USED TO SHOW HOW THE NEOPIXEL STICKS ARE MOUNTED ON THE FRONTPANEL **/
      ////////////////////////////////////////////
      *translate([-54/2,-25,4])
        rotate([0, 180, 180])
        neopixelStick();

      *translate([54/2,-25,4])
        rotate([0, 180, 180])
        neopixelStick();      

    }
    /** ACTIVATE TO SE THRU THE CONSTRUCTION **/
    *translate([60,0,0])
      cube([50,100,50],center=true)  ;
  }
}

 /************************************************************************************************************
 **  Module:      frontPanel
 **  Parameters : None
 **  Description: Front panel
 **              
 ************************************************************************************************************/
  module frontPanel() {
  _led_display_edge = 2;
  _m3Diameter = 2.7;
  _m3Length = 4;

   difference() {
     union() {
       blindFrontPanel();
     }
    /** create a hole in the panel width that is 1 mm narrower on each side and let it go thru the panel  **/
    translate([0,7,0])
      cube([LED_DISPLAY_WIDTH - _led_display_edge,
            LED_DISPLAY_DEPTH - _led_display_edge,
            FRONT_PANEL_HEIGHT],
            center=true);

        /**  create a hole that is 0.5 mm wider than the LED display.  **/
    translate([0,7,FRONT_PANEL_HEIGHT-5])  
      cube([LED_DISPLAY_WIDTH + 1,
              LED_DISPLAY_DEPTH + 1,
              FRONT_PANEL_HEIGHT],
              center=true);

    /** add a hole for the photo resistor **/
    translate([(LED_DISPLAY_WIDTH / 2)+((FRONT_PANEL_WIDTH-LED_DISPLAY_WIDTH) / 2)/2,7,0])
      cylinder(d=5, h=FRONT_PANEL_HEIGHT+0.1,center=true);

    /** add a hole sink for the photo resistor **/
    translate([(LED_DISPLAY_WIDTH / 2)+((FRONT_PANEL_WIDTH-LED_DISPLAY_WIDTH) / 2)/2,7,1])
      cylinder(d=10, h=FRONT_PANEL_HEIGHT,center=true); 

    /** bar trail led stick mounting pocket **/
    translate([-0,-25,4.0])
      barTrailLedStick();
     
    /* neo stick attach holes **/ 
    translate([-54/2, -28, 1])
      neoStickAttchHoles(); 

    translate([54/2 + 0.5, -28, 1])
      neoStickAttchHoles(); 

    /** led attach holes **/
    translate([LED_DISPLAY_WIDTH/2 + 6, 6, 1])
      rotate([0, 0, 90])
        ledAttchHoles(); 

    translate([-LED_DISPLAY_WIDTH/2 - 6, 7, 1])
      rotate([0, 0, 90])
        ledAttchHoles();  

   /** LED INDICATOR TRAIL **/ 
   translate([-FRONT_PANEL_WIDTH/2 + 9, 7, FRONT_PANEL_HEIGHT/2 - 1.5])     
    rotate([0,0,90])
      ledIndicatorTrail();
   }
 }

 /************************************************************************************************************
 **  Module:      barTrailLedStick
 **  Parameters : None
 **  Description: Back panel for DC power connection and FTDI.
 **              
 ************************************************************************************************************/
 module barTrailLedStick() {
  /** definition for the connection trail **/
  _led_trail_bar_width = 130;
  _led_trail_bar_depth =  11;
  _led_trail_bar_height =  3;  
  _led_trail_horiz_offset = 0; //10;

  /** definion for the neo pixel trail **/
  _neopixel_led_width = 110;
  _neopixel_led_depth =   5.7;
  _neopixel_led_height =  2.0;

  /** support resistor bar **/
  _support_bar_width = _neopixel_led_width;
  _support_bar_depth =  4.0;
  _support_bar_height = 2.0;

   difference() {
     union() {
       /** connection stick trail **/
       /** Removed 2021-02-07, it is not needed. It is better to get more material in fron of the LED to get a more diffuse look **/
      *cube([_led_trail_bar_width, _led_trail_bar_depth,_led_trail_bar_height],center=true);
       
      /** neopixel row trail **/
      translate([_led_trail_horiz_offset,(_led_trail_bar_depth - _neopixel_led_depth)/2 - 1.7,-_led_trail_bar_height/2 - _neopixel_led_height/2+0.5])
        cube([_neopixel_led_width, _neopixel_led_depth+0.3,_neopixel_led_height],center=true);

      /** support resistor bar **/
      translate([_led_trail_horiz_offset, -_support_bar_depth-0.2,(-_led_trail_bar_height/2 - _neopixel_led_height/2)+1])
        cube([_support_bar_width, _support_bar_depth-1,_support_bar_height],center=true);        
     }
     
   }
 }


 /************************************************************************************************************
 **  Module:      neoStickAttchHoles
 **  Parameters : None
 **  Description: 
 **              
 ************************************************************************************************************/
module neoStickAttchHoles() {
  _m3Diameter = 2.7;
  _m3Height  = 4;
  _m3Distance = 27/2;


  difference() {
    union() {
      translate([-_m3Distance, 0, 0])
        cylinder(d = _m3Diameter, h = _m3Height, center=true);
      translate([_m3Distance, 0, 0])  
        cylinder(d = _m3Diameter, h = _m3Height, center=true);
    }
  }
}

 /************************************************************************************************************
 **  Module:      ledAttchHoles
 **  Parameters : None
 **  Description: 
 **              
 ************************************************************************************************************/
module ledAttchHoles() {
  _m3Diameter = 2.7;
  _m3Height  = 4;
  _m3Distance = 20/2;


  difference() {
    union() {
      translate([-_m3Distance, 0, 0])
        cylinder(d = _m3Diameter, h = _m3Height, center=true);
      translate([_m3Distance, 0, 0])  
        cylinder(d = _m3Diameter, h = _m3Height, center=true);
    }
  }
}

/************************************************************************************************************
 **  Module:      backSectionDesktop
 **  Parameters : None
 **  Description: Back panel for DC power connection and FTDI.
 **              
 ************************************************************************************************************/
module templateBackSection() {
  difference() {
    union() {
      cube([BACK_PANEL_WIDTH, BACK_PANEL_DEPTH, BOX_MATERIAL_THICKNESS],center=true);
    }
  }
}

/************************************************************************************************************
 **  Module:      backSectionDesktop
 **  Parameters : None
 **  Description:
 **              
 ************************************************************************************************************/
 module backSecionDesktop() {
   difference() {
     union() {
       templateBackSection();
     }
   }
 }

 /************************************************************************************************************
 **  Module:      neopixelStick
 **  Parameters : None
 **  Description:
 **              
 ************************************************************************************************************/
 module neopixelStick() {
   _neo_stick_width           = 54;
   _neo_stick_depth           = 10.3;
   _neo_stick_height          = 1.6;

   _neo_stick_led_width       = 52.4;
   _neo_stick_led_depth       = 5;
   _neo_stick_led_height      = 1.42;

   _neo_stick_resistor_width  = 52.4;
   _neo_stick_resistor_depth  = 0.95;
   _neo_stick_resistor_height = 0.9;

   difference() {
     union() {
       /** pcb **/
       cube([_neo_stick_width, _neo_stick_depth, _neo_stick_height],center=true);

       /** leds **/
       translate([0,-2.65+0.77, _neo_stick_led_height/2 + _neo_stick_height/2])
        cube([_neo_stick_led_width, _neo_stick_led_depth, _neo_stick_led_height],center=true);

      /** resistors **/
      translate([0, 4.675 - 0.475, _neo_stick_resistor_height/2 + _neo_stick_height/2])
        cube([_neo_stick_resistor_width, _neo_stick_resistor_depth, _neo_stick_resistor_height],center=true);
     }
     translate([0, 2.15, 0])
      neoHoles();
   }
 }

 /************************************************************************************************************
 **  Module:      neoHoles
 **  Parameters : None
 **  Description: 
 **              
 ************************************************************************************************************/
 module neoHoles() {
   _neo_hole_diam = 3.1;
   _neo_hole_length = 1.8;;
   _neo_hole_dist    = 27/2;

   difference() {
     union() {
      translate([_neo_hole_dist, 0, 0])
        cylinder(d = _neo_hole_diam, h = _neo_hole_length, center=true);
  
      translate([-_neo_hole_dist, 0, 0])       
        cylinder(d = _neo_hole_diam, h = _neo_hole_length, center=true);
     }
   }
 }

  /************************************************************************************************************
 **  Module:      ledIndicatorTrail
 **  Parameters : None
 **  Description: 
 **              
 ************************************************************************************************************/
  module ledIndicatorTrail() {
  _led_indicator_trail_width  = LED_DISPLAY_DEPTH - 10; // 30;
  _led_indicator_trail_depth  =  8;
  _led_indicator_trail_height = 3;

  _m3Diameter = 2.7;
  _m3Length   = 4;
  _attach_hole_distance = _led_indicator_trail_width/2 + 3;
  _attach_hole_height_offset = -0;

  difference() {
    union() {
      cube([_led_indicator_trail_width, _led_indicator_trail_depth, _led_indicator_trail_height], center=true);
      translate([_attach_hole_distance,0, _attach_hole_height_offset])
        cylinder(d=_m3Diameter, h=_m3Length, center=true);
      translate([-_attach_hole_distance,0, _attach_hole_height_offset])
      cylinder(d=_m3Diameter, h=_m3Length, center=true);
    }
  }
  }



 ////////////////////////////////////////////////////////////////////////////////////////////////////
 ////////////////////////////////////////////////////////////////////////////////////////////////////
 ////////////////////////////////////////////////////////////////////////////////////////////////////
 /////                                3D PRINTER MODULES                                    /////////
 ////////////////////////////////////////////////////////////////////////////////////////////////////
 ////////////////////////////////////////////////////////////////////////////////////////////////////
 ////////////////////////////////////////////////////////////////////////////////////////////////////
/************************************************************************************************************
**  Module:      3dFrontPanel()
**  Parameters : None
**  Description: Box bottom section
**              
************************************************************************************************************/
module 3dFrontPanel() {
  _triangle_diameter = 1;    
   _m3Diameter = 2.7;
   _m3Length = 4;
   _panel_hole_offset = 6;  
  _led_display_edge = 2;   
  _tighten_cylinder_diam = 4;
  _tighten_cylinder_height = 5.8;
  _side_attach_knob_offset = 1.8;
  _lower_knob_attach_offset = 5.2;
  _upper_knob_attach_offset = 8.8;  
 difference() {
    union() {
      3dBlindFrontPanel();
      /** CORNET ATTACHMENT TRIANGLES **/

       translate([-FRONT_PANEL_WIDTH/2 + _triangle_diameter, FRONT_PANEL_DEPTH/2 - _triangle_diameter, 0 ])
         rotate([0, 0,0])
           3dCornerTriangle(_triangle_diameter);
 
       translate([-FRONT_PANEL_WIDTH/2 + _triangle_diameter, -FRONT_PANEL_DEPTH/2 + _triangle_diameter, 0 ])
         rotate([0, 0, 90])
           3dCornerTriangle(_triangle_diameter);          
 
       translate([FRONT_PANEL_WIDTH/2 - _triangle_diameter, FRONT_PANEL_DEPTH/2 - _triangle_diameter, 0 ])
         rotate([0, 0, -90])
           3dCornerTriangle(_triangle_diameter);
 
       translate([FRONT_PANEL_WIDTH/2 - _triangle_diameter, -FRONT_PANEL_DEPTH/2 + _triangle_diameter, 0 ])
         rotate([0, 0, 180])
           3dCornerTriangle(_triangle_diameter);                    

      /** THE TWO SECTIONS BELOW ARE USED TO SHOW HOW THE NEOPIXEL STICKS ARE MOUNTED ON THE FRONTPANEL **/
      ////////////////////////////////////////////
      *translate([-54/2,-25,4])
        rotate([0, 180, 180])
        neopixelStick();

      *translate([54/2,-25,4])
        rotate([0, 180, 180])
        neopixelStick();   

      /** LED WINDOW SECTION **/
      translate([1, 7, 0])
        cube([LED_DISPLAY_WIDTH_3D + 17, LED_DISPLAY_DEPTH_3D + 5, FRONT_PANEL_HEIGHT],center=true);

      /** add a hole sink for the photo resistor **/
      translate([(LED_DISPLAY_WIDTH / 2)+((FRONT_PANEL_WIDTH-LED_DISPLAY_WIDTH) / 2)/2,7,0])
        cylinder(d=14, h=FRONT_PANEL_HEIGHT+0.1,center=true);
       
      /** neobar led stick block **/
      translate([0,-25,0])
        cube([130, 15, FRONT_PANEL_HEIGHT],center=true);

   /** LED INDICATOR BLOCK **/ 
   translate([-FRONT_PANEL_WIDTH/2 + 9, 7, 0])     
    rotate([0,0,90])
      ledIndicatorBlock_3D();        
        
    }
  /** FRONT PANEL ATTACH HOLES **/
     translate([-FRONT_PANEL_WIDTH/2 + _panel_hole_offset, FRONT_PANEL_DEPTH/2 - _panel_hole_offset, FRONT_PANEL_HEIGHT/2-_m3Length/2 + 0.1])
      cylinder(d=_m3Diameter, h=_m3Length, center=true);

     translate([-FRONT_PANEL_WIDTH/2 + _panel_hole_offset, -FRONT_PANEL_DEPTH/2 + _panel_hole_offset, FRONT_PANEL_HEIGHT/2-_m3Length/2 + 0.1])
      cylinder(d=_m3Diameter, h=_m3Length, center=true);      

     translate([FRONT_PANEL_WIDTH/2 - _panel_hole_offset, FRONT_PANEL_DEPTH/2 - _panel_hole_offset, FRONT_PANEL_HEIGHT/2-_m3Length/2 + 0.1])
      cylinder(d=_m3Diameter, h=_m3Length, center=true);      

     translate([FRONT_PANEL_WIDTH/2 - _panel_hole_offset, -FRONT_PANEL_DEPTH/2 + _panel_hole_offset, FRONT_PANEL_HEIGHT/2-_m3Length/2 + 0.1])
      cylinder(d=_m3Diameter, h=_m3Length, center=true);  

    /** LED DISPLAY WINDOW SECTION **/
        /** create a hole in the panel width that is 1 mm narrower on each side and let it go thru the panel  **/
    translate([0,7,0])
      cube([LED_DISPLAY_WIDTH - _led_display_edge,
            LED_DISPLAY_DEPTH - _led_display_edge,
            FRONT_PANEL_HEIGHT],
            center=true);

        /**  create a hole that is 0.5 mm wider than the LED display.  **/
    translate([0,7,FRONT_PANEL_HEIGHT-5])  
      cube([LED_DISPLAY_WIDTH,
              LED_DISPLAY_DEPTH + 0.1,
              FRONT_PANEL_HEIGHT],
              center=true);

    /** add a hole for the photo resistor **/
    translate([(LED_DISPLAY_WIDTH / 2)+((FRONT_PANEL_WIDTH-LED_DISPLAY_WIDTH) / 2)/2,7,0])
      cylinder(d=5, h=FRONT_PANEL_HEIGHT+0.1,center=true);

    /** add a hole sink for the photo resistor **/
    translate([(LED_DISPLAY_WIDTH / 2)+((FRONT_PANEL_WIDTH-LED_DISPLAY_WIDTH) / 2)/2,7,1])
      cylinder(d= 8.8, h=FRONT_PANEL_HEIGHT,center=true); 

    /** bar trail led stick mounting pocket **/
    translate([-0,-25,4.0])
      barTrailLedStick_3D();
     
    /* neo stick attach holes **/ 
    translate([-54/2, -28, 1])
      neoStickAttchHoles(); 

    translate([54/2 + 0.5, -28, 1])
      neoStickAttchHoles(); 

    /** led attach holes **/
    translate([LED_DISPLAY_WIDTH/2 + 6, 6, 1])
      rotate([0, 0, 90])
        ledAttchHoles(); 

    translate([-LED_DISPLAY_WIDTH/2 - 6, 7, 1])
      rotate([0, 0, 90])
        ledAttchHoles();  

   /** LED INDICATOR TRAIL **/ 
   translate([-FRONT_PANEL_WIDTH/2 + 9, 7,1])     
    rotate([0,0,90])
      ledIndicatorTrail_3D();




  }
}

/************************************************************************************************************
**  Module:      3dBlindFrontPanel()
**  Parameters : None
**  Description: Box bottom section
**              
************************************************************************************************************/
module 3dBlindFrontPanel() {
  _main_pocket_reduce_edge = 4;
  difference() {
    union() {
      blindFrontPanel(); 
      }  
      translate([0, 0, 1.5])
        cube([FRONT_PANEL_WIDTH - _main_pocket_reduce_edge, FRONT_PANEL_DEPTH - _main_pocket_reduce_edge, FRONT_PANEL_HEIGHT],center=true);
  }
}

/************************************************************************************************************
**  Module:      3dBlindFrontPanel()
**  Parameters : None
**  Description: Box bottom section
**              
************************************************************************************************************/
module 3dCornerTriangle(tr_diam) {
_triangle_size = 14;
  difference() {
    union() {
      translate([0,0,-FRONT_PANEL_HEIGHT/2])
      hull()   {
        cylinder(d = tr_diam, h=FRONT_PANEL_HEIGHT);
        translate([_triangle_size,0,0])
          cylinder(d = tr_diam, h=FRONT_PANEL_HEIGHT);
        translate([0,-_triangle_size,0])
          cylinder(d = tr_diam, h=FRONT_PANEL_HEIGHT);
      }      
    }
  }
}

 /************************************************************************************************************
 **  Module:      barTrailLedStick_3D
 **  Parameters : None
 **  Description: Module for mounting NEOPIXEL LED stick
 **              
 ************************************************************************************************************/
 module barTrailLedStick_3D() {
  /** definition for the connection trail **/
  _led_trail_bar_width = 130;
  _led_trail_bar_depth =  11;
  _led_trail_bar_height =  3;  
  _led_trail_horiz_offset = 0; //10;

  /** definion for the neo pixel trail **/
  _neopixel_led_width = 110;
  _neopixel_led_depth =   5.7;
  _neopixel_led_height =  2.0;
  _neopixel_led_view_height =  FRONT_PANEL_HEIGHT;
  _neopixel_led_view_depth =  3;  

  /** support resistor bar **/
  _support_bar_width = _neopixel_led_width;
  _support_bar_depth =  4.0;
  _support_bar_height = 2.0;

   difference() {
     union() {
       /** connection stick trail **/
       /** Removed 2021-02-07, it is not needed. It is better to get more material in fron of the LED to get a more diffuse look **/
      *cube([_led_trail_bar_width, _led_trail_bar_depth,_led_trail_bar_height],center=true);
       
      /** neopixel row trail **/
      translate([_led_trail_horiz_offset,(_led_trail_bar_depth - _neopixel_led_depth)/2 - 1.7,-_led_trail_bar_height/2 - _neopixel_led_height/2+0.5])
        cube([_neopixel_led_width, _neopixel_led_depth+0.3,_neopixel_led_height],center=true);

      translate([_led_trail_horiz_offset,(_led_trail_bar_depth - _neopixel_led_depth)/2 - 1.75,-_led_trail_bar_height/2 - _neopixel_led_height/2-1.5])
        cube([_neopixel_led_width - 5, _neopixel_led_view_depth,_neopixel_led_view_height+10],center=true);        

      /** support resistor bar **/
      translate([_led_trail_horiz_offset, -_support_bar_depth-0.2,(-_led_trail_bar_height/2 - _neopixel_led_height/2)+1])
        cube([_support_bar_width, _support_bar_depth-1,_support_bar_height],center=true);        
     }
     
   }
 }

   /************************************************************************************************************
 **  Module:      ledIndicatorBlock_3D
 **  Parameters : None
 **  Description: 
 **              
 ************************************************************************************************************/
  module ledIndicatorBlock_3D() {
  _led_indicator_block_width  = LED_DISPLAY_DEPTH + 5; // 30;
  _led_indicator_block_depth  =  12;
  _led_indicator_block_height = FRONT_PANEL_HEIGHT;

  _m3Diameter = 2.7;
  _m3Length   = 4;
  _attach_hole_distance = _led_indicator_block_width/2 + 3;
  _attach_hole_height_offset = -0;

  difference() {
    union() {
      cube([_led_indicator_block_width, _led_indicator_block_depth, _led_indicator_block_height], center=true);
      *translate([_attach_hole_distance,0, _attach_hole_height_offset])
        cylinder(d=_m3Diameter, h=_m3Length, center=true);
      *translate([-_attach_hole_distance,0, _attach_hole_height_offset])
      cylinder(d=_m3Diameter, h=_m3Length, center=true);
    }
  }
  }


    /************************************************************************************************************
 **  Module:      ledIndicatorTrail_3D
 **  Parameters : None
 **  Description: 
 **              
 ************************************************************************************************************/
  module ledIndicatorTrail_3D() {
  _led_indicator_trail_width  = LED_DISPLAY_DEPTH - 10; // 30;
  _led_indicator_trail_depth  =  8;
  _led_indicator_trail_height = FRONT_PANEL_HEIGHT;

  _m3Diameter = 2.7;
  _m3Length   = 4;
  _attach_hole_distance = _led_indicator_trail_width/2 + 3;
  _attach_hole_height_offset = 0;

  difference() {
    union() {

        cube([_led_indicator_trail_width, _led_indicator_trail_depth, _led_indicator_trail_height], center=true);
      translate([0,0,-1])
        cube([_led_indicator_trail_width - 2, _led_indicator_trail_depth - 2, _led_indicator_trail_height], center=true);
      translate([_attach_hole_distance,0, _attach_hole_height_offset])
        cylinder(d=_m3Diameter, h=_m3Length, center=true);
      translate([-_attach_hole_distance,0, _attach_hole_height_offset])
      cylinder(d=_m3Diameter, h=_m3Length, center=true);
    }
  }
  }