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
*bottonPanelDeskTop();  //.. Bottom panel there are 2 versions, one for table top placement nd one for wall mounting
*bottonPanelWall();  //.. Bottom panel there are 2 versions, one for table top placement nd one for wall mounting
sidePanel();

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

  _side_trail_width = FRONT_PANEL_DEPTH;
  _side_panel_trail_depth = 2;
  _side_panel_height = 2;

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

    /** Add a sink LED for the uv neo pixel LEDS **/
    translate([0,-32,-0.2]) 
      cube([_neopixel_led_width, _neopixel_led_depth, _neopixel_led_height],center=true);

   /** Add sink trail for side panel **/
  //  translate([-FRONT_PANEL_WIDTH/2+_side_panel_trail_depth/2,0,FRONT_PANEL_HEIGHT/2-_side_panel_height/2])
    //  rotate([0,0,90])
      // cube([_side_trail_width, _side_panel_trail_depth, _side_panel_height],center=true);
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
   _side_panel_trail_depth  = 4.05;
   _panel_trail_sink  = BOTTOM_PANEL_HEIGHT / 2;

   difference() {
     union() {
       #cube([BOTTOM_PANEL_WIDTH, BOTTOM_PANEL_DEPTH, BOTTOM_PANEL_HEIGHT],center=true);
     }
     /** add front panel trail **/
     translate([0,-BOTTOM_PANEL_DEPTH/2 + _front_panel_trail_depth/2, _panel_trail_sink/2])
       rotate([0,0,0])
         cube([BOTTOM_PANEL_WIDTH, _front_panel_trail_depth, _panel_trail_sink+0.1],center=true);

      /** add front panel trail **/
     translate([0,BOTTOM_PANEL_DEPTH/2 - _back_panel_trail_depth/2, _panel_trail_sink/2])
       rotate([0,0,0])
         cube([BOTTOM_PANEL_WIDTH, _back_panel_trail_depth, _panel_trail_sink+0.1],center=true);      

      /** add left side panel trail **/
     translate([-BOTTOM_PANEL_WIDTH/2+_side_panel_trail_depth/2, 0, _panel_trail_sink/2])
       rotate([0,0,90])
         cube([BOTTOM_PANEL_DEPTH, _side_panel_trail_depth, _panel_trail_sink+0.1],center=true);

      /** add right side panel trail **/
     translate([BOTTOM_PANEL_WIDTH/2-_side_panel_trail_depth/2, 0, _panel_trail_sink/2])
       rotate([0,0,90])
         cube([BOTTOM_PANEL_DEPTH, _side_panel_trail_depth, _panel_trail_sink+0.1],center=true); 
   }
 }


/************************************************************************************************************
 **  Module:      bottonPanelDeskTop
 **  Parameters : None
 **  Description: Back panel for DC power connection and FTDI.
 **              
 ************************************************************************************************************/
 module bottonPanelDeskTop() {
   difference() {
     union() {
       blindBottomPanel();
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

/************************************************************************************************************
 **  Module:      sidePanel
 **  Parameters : None
 **  Description: Creates the box seide panel.
 **              
 ************************************************************************************************************/
module sidePanel() {
  _front_panel_trail_depth = 6.05;
  _back_panel_trail_depth  = 4.05;
  _panel_trail_sink = SIDE_PANEL_HEIGHT/2;
  difference() {
    union() {
      cube([SIDE_PANEL_WIDTH, SIDE_PANEL_DEPTH, SIDE_PANEL_HEIGHT],center=true);  
    }
    translate([-SIDE_PANEL_WIDTH/2+_front_panel_trail_depth/2,0,-SIDE_PANEL_HEIGHT/2+_panel_trail_sink/2])
      rotate([0,0,90])
        cube([FRONT_PANEL_DEPTH, _front_panel_trail_depth,_panel_trail_sink],center=true);

    translate([SIDE_PANEL_WIDTH/2-_back_panel_trail_depth/2,0,-SIDE_PANEL_HEIGHT/2+_panel_trail_sink/2])
      rotate([0,0,90])
        cube([FRONT_PANEL_DEPTH, _back_panel_trail_depth,_panel_trail_sink],center=true);
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

  _led_trail_bar_width = 110;
  _led_trail_bar_depth =  11;
  _led_trail_bar_height = 3;    

  _neopixel_led_width = 118;
  _neopixel_led_depth =   5.2;
  _neopixel_led_height =  1.6;

   difference() {
     union() {
       blindFrontPanel();
     }
    /** create a hole in the panel width that is 1 mm narrower on each side and let it go thru the panel  **/
    translate([0,0,0])
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

    /** Add a sink LED for the uv neo pixel LEDS **/
    translate([0,-32,-0.2]) 
      cube([_neopixel_led_width, _neopixel_led_depth, _neopixel_led_height],center=true);

   }
 }