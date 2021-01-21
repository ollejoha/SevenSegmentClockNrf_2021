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
use <ssc_FRONT_PANEL.scad>;

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
 size_reduction_thru_all = 15;
  size_reduction = 5;
  difference() {
    union() {
      cube([CLOCK_BOX_WIDTH, CLOCK_BOX_DEPTH,CLOCK_BOX_HEIGHT],center=true);
    }
    //** create a hole thru the casing block  **/
    translate([0, size_reduction, 0])
      cube([CLOCK_BOX_WIDTH - size_reduction_thru_all, CLOCK_BOX_DEPTH - size_reduction_thru_all/2, CLOCK_BOX_INSIDE_HEIGHT + size_reduction / 2],center=true);

    translate([0, 3, 0])
      cube([CLOCK_BOX_WIDTH - size_reduction, CLOCK_BOX_DEPTH, CLOCK_BOX_INSIDE_HEIGHT - size_reduction-10],center=true);
      
    translate([0, 2.1,-33.5 ])
      blindPlate();

    translate([0, 2.1, 33.5 ])
      blindPlate();      
  }
}

module blindPlate() {
  difference() {
    union() {
      cube([CLOCK_BOX_INSIDE_WIDTH, CLOCK_BOX_INSIDE_DEPTH+2,FRONT_PANEL_HEIGHT+1],center=true);
    }
  }
}