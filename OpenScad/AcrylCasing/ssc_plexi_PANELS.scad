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
*bottomSection();        //.. Desktop version of bottom section
*topSection();           //.. Top section used for both desktop and wall monted casings
*sideSection();          //.. Template for side secions
*leftSideSection();      //.. Left side section view from front to back
*rightSideSection();     //.. Right side section view from fron to back
*blindFrontPanel();      //.. Template for front panel
frontPanel();           //.. Front panel
*templateBackSection();  //.. Template for tha back section
*backSecionDesktop();    //.. Back section for desk top 
*barTrailLedStick();     //.. Mounting defintiioon for tha neo pixel stick (UV-index)


/** USE ONLY AS REFERENCE **/
*translate([0,0,8.5])
  ledDisplay();     
 /***************************************************************************
 *
 *                                MODULES
 *
 ***************************************************************************/

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
  _vent_diameter = 3;
  _vent_height = BOX_MATERIAL_THICKNESS;
  
  difference() {
    union() {
      baseSection();
    }
    /** air channels **/
    for (a = [0:5:55])
      translate([-55/2 +a,0,0])
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
   difference() {
     union() {
       color("DarkGray") {
       cube([FRONT_PANEL_WIDTH, FRONT_PANEL_DEPTH, FRONT_MATERIAL_THICKNESS],center=true);
       }
     }
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
      cube([LED_DISPLAY_WIDTH + 0.25,
              LED_DISPLAY_DEPTH + 0.25,
              FRONT_PANEL_HEIGHT],
              center=true);

    /** add a hole for the photo resistor **/
    translate([(LED_DISPLAY_WIDTH / 2)+((FRONT_PANEL_WIDTH-LED_DISPLAY_WIDTH) / 2)/2,7,0])
      cylinder(d=5, h=FRONT_PANEL_HEIGHT+0.1,center=true);

    /** add a hole sink for the photo resistor **/
    translate([(LED_DISPLAY_WIDTH / 2)+((FRONT_PANEL_WIDTH-LED_DISPLAY_WIDTH) / 2)/2,7,1])
      cylinder(d=10, h=FRONT_PANEL_HEIGHT,center=true); 

    /** bar trail led stick mounting pocket **/
    translate([-10,-25,4.0])
      barTrailLedStick();

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
  _led_trail_bar_height = 3;  
  _led_trail_horiz_offset = 10;

  /** definion for the neo pixel trail **/
  _neopixel_led_width = 110;
  _neopixel_led_depth =   5.2;
  _neopixel_led_height =  2.0;

  /** support resistor bar **/
  _support_bar_width = _neopixel_led_width;
  _support_bar_depth =  3.5;
  _support_bar_height = 2.0;

   difference() {
     union() {
       /** connection stick trail **/
       cube([_led_trail_bar_width, _led_trail_bar_depth,_led_trail_bar_height],center=true);
       
      /** neopixel row trail **/
      translate([_led_trail_horiz_offset,(_led_trail_bar_depth - _neopixel_led_depth)/2 - 1,-_led_trail_bar_height/2 - _neopixel_led_height/2])
        cube([_neopixel_led_width, _neopixel_led_depth,_neopixel_led_height],center=true);

      /** support resistor bar **/
      translate([_led_trail_horiz_offset, -_support_bar_depth+0.3,-_led_trail_bar_height/2 - _neopixel_led_height/2])
        cube([_support_bar_width, _support_bar_depth,_support_bar_height],center=true);        
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
 **  Description: Back panel for DC power connection and FTDI.
 **              
 ************************************************************************************************************/
 module backSecionDesktop() {
   difference() {
     union() {
       templateBackSection();
     }
   }
 }