////////////////////////////////////////////////////////////////////////
//////////////////////// Unit Information  ///////////////////////////////////
/*//////////////////////////////////////////////////////////////////////
date stated   : 2021-01-21
date finished : 2021-01-21
modeler       : Olle Johansson
application   : SevenSegment RENDER File
module        : RENDER
version       : 0.1 beta
copyright     : Pipe Dreams / Forrest Floor
subject       : Seven Segment Clock

version history
date            description
2021-01-21	    Start of design

*/
$fn = $preview ? 10 : 64;

/** INCLUDE FILES **/
include <ssc_DIMENSIONS.scad>;
use <ssc_CLOCK_BOX.scad>;
use <ssc_PANELS.scad>;

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