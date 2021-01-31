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
$fn = 5;

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
box();



 /***************************************************************************
 *
 *                             HIGH LEVEL MODULES
 *                              NEW MAIN MODULE
 *
 ***************************************************************************/
 module box() {
   difference() {
     union() {
       /** bootom section **/
       bottomSection();

       /** top section **/
       topSection();

       /** left side section **/
       leftSideSection();

       /** right side section **/
       rightSideSection();

       /** front panel **/
       translate([0,-BOX_DEPTH/2 + FRONT_MATERIAL_THICKNESS/2,BOX_HEIGHT/2])
        rotate([-90,180,0])
          frontPanel();

       /** back panel desktop**/
       //translate([0,BACK_PANEL_DEPTH/2,BACK_PANEL_DEPTH/2])
       translate([0,BACK_PANEL_DEPTH/2+3,BACK_PANEL_DEPTH/2])
        rotate([90,0,0])
          backSecionDesktop();
     }
   }
 }

