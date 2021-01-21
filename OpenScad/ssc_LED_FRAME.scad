////////////////////////////////////////////////////////////////////////
//////////////////////// Unit Information  ///////////////////////////////////
/*//////////////////////////////////////////////////////////////////////
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
ledFrame();

 /***************************************************************************
 *
 *                                MODULES
 *
 ***************************************************************************/
 module ledFrame() {
   difference() {
     union() {
       cube([LED_DISPLAY_FRAME_WIDTH, LED_DISPLAY_FRAME_DEPTH, LED_DISPLAY_FRAME_HEIGHT], center=true);
     }
     cube([LED_DISPLAY_WIDTH, LED_DISPLAY_DEPTH, LED_DISPLAY_HEIGHT+0.1],center=true);
   }
 }