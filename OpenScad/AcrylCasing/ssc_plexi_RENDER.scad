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
use <ssc_plexi_DETAIL_PARTS.scad>;

/***************************************************************************
 *
 *                                GLOBAL RENDER
 *
 ***************************************************************************/
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
       *translate([0,-BOX_DEPTH/2 + FRONT_MATERIAL_THICKNESS/2,BOX_HEIGHT/2])
        rotate([-90,180,0])
          frontPanel();

       translate([0,-BOX_DEPTH/2 + FRONT_MATERIAL_THICKNESS/2,BOX_HEIGHT/2])
        rotate([-90,180,0])
          frontPanelExt();

       /** back panel desktop**/
       //translate([0,BACK_PANEL_DEPTH/2,BACK_PANEL_DEPTH/2])
       *translate([0,BACK_PANEL_DEPTH/2+3,BACK_PANEL_DEPTH/2])
        rotate([90,0,0])
          backSecionDesktop();

       /** Corner front attachment modules **/
       /** upper left **/
       translate([78.5, -36.5, 71.5,])
         rotate([-90, 90, 0])
           cornerPanelConnectorFront();

       /** lower left **/
       translate([78.5, -33.5, 3.5])
         rotate([90, -90, 0])
           cornerPanelConnectorFront();           

       /** upper right **/
       translate([-78.5, -33.5, 71.5,])
         rotate([90, 90, 0])
           cornerPanelConnectorFront();

       /** lower right **/
       translate([-78.5, -33.5, 3.5])
         rotate([-90, -90, 0])
           cornerPanelConnectorFront();                      

       /** Rear front attachment modules **/
       /** upper left **/
       translate([78.5, 36.5, 71.5,])
         rotate([-90, 90, 0])
           cornerPanelConnectorRear();

       /** lower left **/
       translate([78.5, 38.5, 3.5])
         rotate([90, -90, 0])
           cornerPanelConnectorRear();           

       /** upper right **/
       translate([-78.5, 38.5, 71.5,])
         rotate([90, 90, 0])
           cornerPanelConnectorRear();

       /** lower right **/
       translate([-78.5, 36.5, 3.5])
         rotate([-90, -90, 0])
           cornerPanelConnectorRear();           

       /** LDR Adaptor **/
        translate([-71.2, -42,44.5])
         rotate([90, 0, 180])
          ldrPanelAdaptor();

     }
   }
 }

