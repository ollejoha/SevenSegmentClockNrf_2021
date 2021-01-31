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
 *
 ***************************************************************************/
module mainClockCasing() {
  difference() {
    union() {
      /** PLACE THE BOTTOM PANEL **/
      bottonPanelDeskTop();      //.. Front panel for LED display, indicator LED's and light sensor      

      /** PLACE THE TOP PANEL (same as bottom panel**/
      translate([0,0,FRONT_PANEL_DEPTH])
          rotate([0, 180, 0])
            bottonPanelDeskTop();      //.. Front panel for LED display, indicator LED's and light sensor            
      
      /** PLACE THE FRONT PANEL **/
      translate([0,-BOTTOM_PANEL_DEPTH/2+FRONT_PANEL_HEIGHT/2-5,FRONT_PANEL_DEPTH/2])
        rotate([-90,180,0])
          frontPanel();      //.. Front panel for LED display, indicator LED's and light sensor

      /** PLACE THE LEFT SIDE PANEL**/
      translate([FRONT_PANEL_WIDTH/2+SIDE_PANEL_HEIGHT/2,0,FRONT_PANEL_DEPTH/2])
        rotate([90,0,90])
          sidePanel();

      /** PLACE THE RIGHT SIDE PANEL**/
      translate([-FRONT_PANEL_WIDTH/2-SIDE_PANEL_HEIGHT/2,0,FRONT_PANEL_DEPTH/2])
        rotate([-90,0,90])
          sidePanel();
          
    }
  }
}

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
       translate([0,-BOX_DEPTH/2 + FRONT_MATERIAL_THICKNESS/2-7,BOX_HEIGHT/2])
        rotate([-90,180,0])
          frontPanel();
     }
   }
 }

