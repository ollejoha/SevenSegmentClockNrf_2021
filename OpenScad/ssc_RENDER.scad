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
$fn = 50;

/** INCLUDE FILES **/
include <ssc_DIMENSIONS.scad>;
use <ssc_CLOCK_BOX.scad>;

/***************************************************************************
 *
 *                                GLOBAL RENDER
 *
 ***************************************************************************/
mainClockCasing();

 /***************************************************************************
 *
 *                             HIGH LEVEL MODULES
 *
 ***************************************************************************/
module mainClockCasing() {
  difference() {
    union() {
      /** main clock box mounting case  **/
      mainClockBox();

      /** display fixture frame  **/
      translate([0,0,-CLOCK_BOX_INSIDE_HEIGHT / 2 + CLOCK_BOX_WALL_THICKNESS]) 
        ledFrame();    
    }
  }
}