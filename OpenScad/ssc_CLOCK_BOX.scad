/*////////////////////////////////////////////////////////////////////////////
//////////////////////// Unit Information  ///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
date stated   : 2021-01-21
date finished : 2021-01-21
modeler       : Olle Johansson
application   : SevenSegmentClock (ClockNet)
module        : TEST_PIPE
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
 ***************************************************************************/
mainClockBox();

 /***************************************************************************
 *
 *                                MODULES
 *
 ***************************************************************************/
/** main box module  **/
 module mainClockBox() {
   difference() {
     union() {
       /** this is the main box block  **/
       cube([CLOCK_BOX_WIDTH, CLOCK_BOX_DEPTH,CLOCK_BOX_HEIGHT], center=true);
     }
     /**  inner box slot   **/
     translate([0,0,3])
       cube([CLOCK_BOX_INSIDE_WIDTH, CLOCK_BOX_INSIDE_DEPTH,CLOCK_BOX_INSIDE_HEIGHT],center=true);
    /**  led display window  **/
    translate([0,0, -CLOCK_BOX_HEIGHT/2 + CLOCK_BOX_WALL_THICKNESS / 2])
      ledDisplayWindow(LED_DISPLAY_WIDTH, LED_DISPLAY_DEPTH, CLOCK_BOX_WALL_THICKNESS + 0.1);

    /**  mounting hole for photoresister  **/
    translate([CLOCK_BOX_INSIDE_WIDTH / 2 - 8,0, -CLOCK_BOX_HEIGHT/2 + CLOCK_BOX_WALL_THICKNESS / 2])
      photoResistor(CLOCK_BOX_WALL_THICKNESS);

    /** indicator LED  **/
    translate([-CLOCK_BOX_INSIDE_WIDTH / 2 + 8 ,  6, -CLOCK_BOX_HEIGHT/2 + CLOCK_BOX_WALL_THICKNESS / 2])
    indicatorLED(CLOCK_BOX_WALL_THICKNESS);      

    translate([-CLOCK_BOX_INSIDE_WIDTH / 2 + 8 , -6, -CLOCK_BOX_HEIGHT/2 + CLOCK_BOX_WALL_THICKNESS / 2])
    indicatorLED(CLOCK_BOX_WALL_THICKNESS);          
   }
 }

/**  LED DISPLAY WINDOW  **/
 module ledDisplayWindow(_width, _depth, _height) {
   difference() {
     union() {
       cube([_width - 2, _depth - 2, _height],center=true);
     }
   }
 }

/**  PHOTO TRANSISTOR  **/
 module photoResistor(_wall) {
   _diameter1 = 4.5;
   _diameter2 = 6;

   difference() {
     union() {
       cylinder(d1=_diameter1, d2=_diameter2, h=_wall + 0.1, center=true);
     }
   }
 }

 /** LED MOUNTING HOLE  **/
 module indicatorLED(_wall) {
   _led_diameter        = 6.4;
   _led_pocket_diameter = 10;
   difference() {
     union() {
       cylinder(d=_led_diameter, h=_wall + 0.1, center=true);
       translate([0,0, _wall/2 - 0.4])
       cylinder(d=_led_pocket_diameter, h=1, center=true);
     }
   }
 }