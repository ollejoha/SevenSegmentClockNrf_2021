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
*blindPanel();     //.. Base panel from wich all other panels are derived from
*trailPanel();     //.. Blind panel used top create the trails for front- and back panel trails in the middle section and bottomplate
translate([0,-BOTTOM_PANEL_DEPTH/2+FRONT_PANEL_HEIGHT/2,FRONT_PANEL_DEPTH/2])
  rotate([-90,180,0])
  frontPanel();      //.. Front panel for LED display, indicator LED's and light sensor
*backPanel();      //.. Back panel for DC power and FTDI connector for program update
blindBottomPanel(); //.. This is the base bottom panel
*bottonPanelTop();  //.. Bottom panel there are 2 versions, one for table top placement nd one for wall mounting
*bottonPanelWall();  //.. Bottom panel there are 2 versions, one for table top placement nd one for wall mounting

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

  _led_trail_bar_width = 110;
  _led_trail_bar_depth =  11;
  _led_trail_bar_height = 3;

  _neopixel_led_width = 118;
  _neopixel_led_depth =   5.2;
  _neopixel_led_height =  1.6;
  
  difference() {
    union() {
      blindPanel();
     }  //.. end of union

    /** create a hole in the panel width that is 1 mm narrower on each side and let it go thru the panel  **/
    translate([0,0,-0.1])
      cube([LED_DISPLAY_WIDTH - _led_display_edge,
            LED_DISPLAY_DEPTH - _led_display_edge,
            FRONT_PANEL_HEIGHT],
            center=true);

    /**  create a hole that is 0.5 mm wider than the LED display.  **/
    translate([0,0,FRONT_PANEL_HEIGHT-5])  
      cube([LED_DISPLAY_WIDTH + 0.25,
              LED_DISPLAY_DEPTH + 0.25,
              FRONT_PANEL_HEIGHT],
              center=true);

    /** add a hole for the photo resistor **/
    translate([(LED_DISPLAY_WIDTH / 2)+((FRONT_PANEL_WIDTH-LED_DISPLAY_WIDTH) / 2)/2,0,0])
      cylinder(d=5, h=FRONT_PANEL_HEIGHT+0.1,center=true);

    /** add a hole sink for the photo resistor **/
    translate([(LED_DISPLAY_WIDTH / 2)+((FRONT_PANEL_WIDTH-LED_DISPLAY_WIDTH) / 2)/2,0,1])
      cylinder(d=10, h=FRONT_PANEL_HEIGHT,center=true);      

    /** Add a sink trail for the uv led bar **/
    translate([0,-30,2]) 
      cube([_led_trail_bar_width, _led_trail_bar_depth, _led_trail_bar_height],center=true);

    /** Add a sink KED for the uv neo pixel LEDS **/
    translate([0,-32,-0.2]) 
      cube([_neopixel_led_width, _neopixel_led_depth, _neopixel_led_height],center=true);
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
 **  Module:      blindBottomPanel
 **  Parameters : None
 **  Description: Back panel for DC power connection and FTDI.
 **              
 ************************************************************************************************************/
 module blindBottomPanel() {
   _front_panel_trail_depth = 6.05;
   _back_panel_trail_depth  = 4.05;
   _panel_trail_sink  = BOTTOM_PANEL_HEIGHT / 2;

   difference() {
     union() {
       cube([BOTTOM_PANEL_WIDTH, BOTTOM_PANEL_DEPTH, BOTTOM_PANEL_HEIGHT],center=true);
     }
     /** add front panel trail **/
     translate([0,-BOTTOM_PANEL_DEPTH/2 + _front_panel_trail_depth/2, _panel_trail_sink/2])
       rotate([0,0,0])
         cube([BOTTOM_PANEL_WIDTH, _front_panel_trail_depth, _panel_trail_sink+0.1],center=true);

      /** add front panel trail **/
     translate([0,BOTTOM_PANEL_DEPTH/2 - _back_panel_trail_depth/2, _panel_trail_sink/2])
       rotate([0,0,0])
         cube([BOTTOM_PANEL_WIDTH, _back_panel_trail_depth, _panel_trail_sink+0.1],center=true);      
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