////////////////////////////////////////////////////////////////////////
//////////////////////// Unit Information  ///////////////////////////////////
/*//////////////////////////////////////////////////////////////////////
date stated   : 2021-01-21
date finished : 2021-01-21
modeler       : Olle Johansson
application   : SevenSegmentClock (ClockNet)
module        : scc_Front_PANEL
version       : 0.1 beta
copyright     : Pipe Dreams / Forrest Floor
subject       : Seven Segment Clock
description   : LED Fram for attaching LED-Display in box.

version history
date            description
2021-01-21	    Start of re-design

*/
$fn = 100;

include <ssc_DIMENSIONS.scad>;
use <ssc_LED_FRAME.scad>;

/***************************************************************************
 *
 *                                LOCAL RENDER
 *                      Used to view modules locally
 *
 ***************************************************************************/
  frontPanel();


*translate([0,0,4.5])
  ledDisplay();     
 /***************************************************************************
 *
 *                                MODULES
 *
 ***************************************************************************/
 /******************************/
 /**       FRONT PANE BASE    **/
 /******************************/
 module frontPanel() {
   difference() {
     union() {
       frontPanelBase();
     }
   }
 }
 
 /******************************/
 /**       FRONT PANE BASE    **/
 /******************************/
module frontPanelBase() {
  _grid_offset = 2.54*4;
  difference() {
    union() {
      cube([FRONT_PANEL_WIDTH, FRONT_PANEL_DEPTH, FRONT_PANEL_HEIGHT], center=true);
      /**  Position the led fram on the backside of the front panel  **/
      translate([0,0,3])
        ledFrame();  

      /** Add the LED information bar on the backside of the front panel  **/
      translate([-73,0,3.4])
        rotate([0,0,90])
          ledBar();        
    }
    
    /**  Create a pocket for the LED Display with a small edge to hold the LED Display  **/
    displayPocket();
    /** positition the photo resistor pipe hole  **/
    translate([FRONT_PANEL_WIDTH / 2 - 13, 28, 0])
      photoResistor();    

    /** Add LED holes in the led bar  **/
    for (a = [0 : 1 : 6]) {
      translate([-73, -28 + a * (7 + 2.54),3])
        cylinder(d=5.2, h=10,center=true);
    }



  }
}

/************************************************************************************************************
 **  Module:      frontPanelPocket
 **  Parameters : None
 **  Description: Create a pocket on backside of the font panel to create a frame that goes on the outside
 **               of the casing
 ************************************************************************************************************/
module frontPanelPocket() {
  _size_reduction = 2;
  _pocket_height = FRONT_PANEL_HEIGHT / 2;
  difference() {
    union() {
      translate([0, 0, _pocket_height / 2 + 0.1])
        cube([FRONT_PANEL_WIDTH - _size_reduction, FRONT_PANEL_DEPTH - _size_reduction, _pocket_height],center=true);
     }
   }
 }

/************************************************************************************************************
 **  Module:      displayPocket
 **  Parameters : None
 **  Description: Create a pocket that goes thru the panel to make the LED display visible. This pocket
 **               shall be 1 mm smaller on all sides than the LED display so that the display connects to
 **               the panel and get a thin edge that holds back the display
 ************************************************************************************************************/
module displayPocket() {
  _size_reduction = 2;
  _size_extension = 0;
  _pocket_height = 2;
  difference() {
    union() {
      *translate([0,0, _size_reduction / 2]) 
        cube([LED_DISPLAY_WIDTH, LED_DISPLAY_DEPTH, 6]);
      
     translate([0,0, _size_reduction / 2]) 
      cube([LED_DISPLAY_WIDTH - _size_reduction, LED_DISPLAY_DEPTH - _size_reduction, LED_DISPLAY_HEIGHT],center=true);

     translate([0,0, 1]) 
      cube([LED_DISPLAY_WIDTH + _size_extension, LED_DISPLAY_DEPTH + _size_extension, FRONT_PANEL_HEIGHT],center=true);      
    }
  }
}

 /************************************************************************************************************
 **  Module:      ledFrame
 **  Parameters : None
 **  Description: CReate a fram module to fix the LED diaplay to the front panel.
 ************************************************************************************************************/
 module ledFrame() {
   difference() {
     union() {
       cube([LED_DISPLAY_FRAME_WIDTH, LED_DISPLAY_FRAME_DEPTH, LED_DISPLAY_FRAME_HEIGHT], center=true);
     }
     cube([LED_DISPLAY_WIDTH, LED_DISPLAY_DEPTH, LED_DISPLAY_HEIGHT+0.1],center=true);
   }
 }

 /************************************************************************************************************
 **  Module:      photoResistor
 **  Parameters : None
 **  Description: Definition of a hole to attach the photo resistor component
  ************************************************************************************************************/
  module photoResistor() {
    _photo_resistor_diam = 8;
    _resistor_pipe_diam = 10;
    difference() {
      union() {
        cylinder(d=_photo_resistor_diam, h= FRONT_PANEL_HEIGHT +5 + 0.1, center=true);
        translate([0,0,1])
          cylinder(d=_resistor_pipe_diam, h=FRONT_PANEL_HEIGHT + 0.1, center=true);
      }
    }
  }

 /************************************************************************************************************
 **  Module:      ledBar
 **  Parameters : None
 **  Description: Bar to hold the information leds
 ************************************************************************************************************/
 module ledBar() {
   difference() {
     union() {
       cube([FRONT_PANEL_DEPTH-10, 8, 5],center=true);
     }
   }
 }

 /************************************************************************************************************
 **  Module:      ledDisplay. ONLY FOR TEST
 **  Parameters : None
 **  Description: This is a dummy module representing the LED displays dimensions and is used to visually
 **               show how the LED display fits in the panel
 ************************************************************************************************************/
 module ledDisplay() {
   difference() {
     union() {
       cube([LED_DISPLAY_WIDTH, LED_DISPLAY_DEPTH, LED_DISPLAY_HEIGHT],center=true);
     }
   }
 }