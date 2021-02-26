/*////////////////////////////////////////////////////////////////////////////
//////////////////////// Unit Information  ///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
date stated   : 2021-02-26
date finished : 2021-02-26
modeler       : Olle Johansson
application   : SevenSegmentClock (ClockNet)
module        : Detail_Parts
version       : 0.1 beta
copyright     : Pipe Dreams / Forrest Floor
subject       : Seven Segment Clock
description   : Mounting jigg details for clockNet box

version history
date            description
2021-02-07	    Start of re-design
*/
$fn = 100;

include <ssc_plexi_DIMENSIONS.scad>;
use <ssc_plexi_PANELS.scad>;
use <ssc_plexi_RENDER.scad>;

JIGG_OUTER_WIDTH = BOX_WIDTH + 20;
JIGG_OUTER_HEIGHT = BOX_HEIGHT + 20;

/***************************************************************************
 *
 *                                LOCAL RENDER
 *                      Used to view modules locally
 *
 ***************************************************************************/
*box();
jigg();
  /***************************************************************************
 *
 *                                MODULES
 *
 ***************************************************************************/

/************************************************************************************************************
 **  Module:      jigg
 **  Parameters : None
 **  Description: Combination of connector items to simplify milling
 **              
 ************************************************************************************************************/
 module jigg() {
   difference() {
     union() {
       cube([JIGG_OUTER_WIDTH, JIGG_OUTER_HEIGHT, 4],center=true);
       
       translate([0,-70,0])
         cube([50,10,4]);
     }
     translate([0,5,0])
       cube([BOX_WIDTH+0.2, BOX_DEPTH, BOX_HEIGHT],center= true);
   }
 }