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


/***************************************************************************
 *
 *                                LOCAL RENDER
 *                      Used to view modules locally
 *
 ***************************************************************************/*blindPanel();   //.. Base panel from wich all other panels are derived from
*trailPanel();   //.. Blind panel used top create the trails for front- and back panel trails in the middle section and bottomplate
*frontPanel();   //.. Front panel for LED display, indicator LED's and light sensor
*backPanel();   //.. Back panel for DC power and FTDI connector for program update

//----
*ledFrame();

/** USE ONLY AS REFERENCE **/
*translate([0,0,8.5])
  ledDisplay();     
 /***************************************************************************
 *
 *                                MODULES
 *
 ***************************************************************************/
/************************************************************************************************************
 **  Module:      blindPanel
 **  Parameters : None
 **  Description: Basic panel. All other panels are derived from this panel
 **              
 ************************************************************************************************************/
module blindPanel() {
  difference() {
    union() {
      cube([FRONT_PANEL_WIDTH, FRONT_PANEL_DEPTH, FRONT_PANEL_HEIGHT],center=true);
    }
  }
}

/************************************************************************************************************
 **  Module:      trailPanel
 **  Parameters : None
 **  Description: Basic panel. All other panels are derived from this panel
 **              
 ************************************************************************************************************/
module trailPanel() {
  
  _trail_width_offset = 2.5;
  _trail_depth_offset = 5;
  _trail_height_offset = 1;

  difference() {
    union() {
      translate([0,-2.5,0])
        cube([FRONT_PANEL_WIDTH + _trail_width_offset,
              FRONT_PANEL_DEPTH + _trail_depth_offset,
              FRONT_PANEL_HEIGHT + _trail_height_offset],
              center=true);
    }
  }
}


/************************************************************************************************************
 **  Module:      frontPanel
 **  Parameters : None
 **  Description: Front panel for LED display, indicator LED's and light sensor
 **              
 ************************************************************************************************************/
module frontPanel() {
  _led_frame_width  = LED_DISPLAY_WIDTH + 4;
  _led_frame_depth  = LED_DISPLAY_DEPTH + 4;
  _led_frame_height = 4;
  _led_display_offset = 1;
  _led_display_edge = 2; //.. A value of 2 will give a 1 mm edge on the oppsite sides
  
  difference() {
    union() {
      blindPanel();
      
      /**  add object to be the LED display frame **/
      translate([0,0,FRONT_PANEL_HEIGHT])
        cube([_led_frame_width,
              _led_frame_depth,
              _led_frame_height],
              center=true);

      /** Add the LED information bar on the backside of the front panel  **/
      translate([(-LED_DISPLAY_WIDTH / 2)-((FRONT_PANEL_WIDTH-LED_DISPLAY_WIDTH) / 2)/2,0,3.4])
        rotate([0, 0, 90])       
         cube([FRONT_PANEL_DEPTH-10, 8, 5],center=true);                      
    }  //.. end of union

    /** create a hole in the panel width that is 1 mm narrower on each side and let it go thru the panel  **/
    translate([0,0,-0.1])
      cube([LED_DISPLAY_WIDTH - _led_display_edge,
            LED_DISPLAY_DEPTH - _led_display_edge,
            FRONT_PANEL_HEIGHT],
            center=true);

    /**  create a hole that is 1 mm wider than the LED display.  **/
    translate([0,0,FRONT_PANEL_HEIGHT+1])  
      cube([LED_DISPLAY_WIDTH + 0,
              LED_DISPLAY_DEPTH + 0,
              FRONT_PANEL_HEIGHT + 5],
              center=true);

    /** add a hole for the photo resistor **/
    translate([(LED_DISPLAY_WIDTH / 2)+((FRONT_PANEL_WIDTH-LED_DISPLAY_WIDTH) / 2)/2,0,0])
      cylinder(d=5, h=FRONT_PANEL_HEIGHT+0.1,center=true);

    /** add a hole sink for the photo resistor **/
    translate([(LED_DISPLAY_WIDTH / 2)+((FRONT_PANEL_WIDTH-LED_DISPLAY_WIDTH) / 2)/2,0,1])
      cylinder(d=10, h=FRONT_PANEL_HEIGHT,center=true);      

    /** Add LED holes in the led bar  **/
    for (a = [0 : 1 : 4]) {
      translate([(-LED_DISPLAY_WIDTH / 2)-((FRONT_PANEL_WIDTH-LED_DISPLAY_WIDTH) / 2)/2, -2.54*3*2.5 + a * (7 + 2.54),3])
        cylinder(d=5.4, h=10,center=true);
    }
  }
}

/************************************************************************************************************
 **  Module:      backPanel
 **  Parameters : None
 **  Description: Back panel for DC power connection and FTDI.
 **              
 ************************************************************************************************************/
module backPanel() {
  difference() {
    union() {
      blindPanel();
    }
  }
}


/************************************************************************************************************
 **  Module:      ledFrame
 **  Parameters : None
 **  Description: Creates a frame for the LED display.
 **              
 ************************************************************************************************************/
module ledFrame() {
  _led_frame_width  = LED_DISPLAY_WIDTH + 3;
  _led_frame_depth  = LED_DISPLAY_DEPTH + 4;
  _led_frame_height = 4;
  _led_display_offset = 1;
  difference() {
    union() {
      cube([_led_frame_width,
            _led_frame_depth,
            _led_frame_height],
            center=true);
    }
    cube([LED_DISPLAY_WIDTH + _led_display_offset,
          LED_DISPLAY_DEPTH + _led_display_offset,
          LED_DISPLAY_HEIGHT],
          center=true);
  }
}

//*********************************************************************************************************
//*********************************************************************************************************
//*********************************************************************************************************
module ledDisplay() {
  difference() {
    union() {
      cube([LED_DISPLAY_WIDTH, LED_DISPLAY_DEPTH, LED_DISPLAY_HEIGHT],center=true);
    }
  }
}