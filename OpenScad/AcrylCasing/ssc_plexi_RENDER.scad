////////////////////////////////////////////////////////////////////////
//////////////////////// Unit Information  ///////////////////////////////////
/*//////////////////////////////////////////////////////////////////////
date stated   : 2021-01-30
date finished : 2021-01-30
modeler       : Olle Johansson
application   : SevenSegment RENDER File
module        : RENDER
version       : 0.1 beta
copyright     : Pipe Dreams / Forrest Floor
subject       : Seven Segment Clock

version history
date            description
2021-01-30	    Start of design

*/
$fn = 50;

/** INCLUDE FILES **/
include <ssc_plexi_DIMENSIONS.scad>;
use <ssc_plexi_CLOCK_BOX.scad>;
use <ssc_plexi_PANELS.scad>;

/***************************************************************************
 *
 *                                GLOBAL RENDER
 *
 ***************************************************************************/
*mainClockCasing();


 /***************************************************************************
 *
 *                             HIGH LEVEL MODULES
 *
 ***************************************************************************/
module mainClockCasing() {
  difference() {
    union() {
      mainBoxBlock();
      translate([0,0,-30])
        frontPanel();

      translate([0,0,30])
        backPanel();        

    }
  }
}

module fillOut() {
  union() {
    cube([40, 6, 1.2],center=true);
  }
}