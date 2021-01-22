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
use <ssc_PANELS.scad>;


/***************************************************************************
 *
 *                                LOCAL RENDER
 *                      Used to view modules locally
 *
 ***************************************************************************/
middleCase();

 /***************************************************************************
 *
 *                                MODULES
 *
 ***************************************************************************/


/************************************************************************************************************
 **  Module:      middleCase
 **  Parameters : None
 **  Description: Basic panel. All other panels are derived from this panel
 **              
 ************************************************************************************************************/
module middleCase() {
  difference() {
    union() {
      mainBoxBlock();

    }
  }
}

/************************************************************************************************************
 **  Module:      mainBoxBlock
 **  Parameters : None
 **  Description: This is tha main, basic block constructing the middleCase
 **              
 ************************************************************************************************************/
 module mainBoxBlock() {
   _wall_dimension = 2.5;
   _box_inside_width = BOX_WIDTH - 10;
   _box_inside_depth = BOX_DEPTH;

   _box_center_width  = BOX_WIDTH - _wall_dimension;
   _box_center_depth  = BOX_DEPTH;
   _box_center_height = BOX_HEIGHT - 11;
  
   difference() {
     union() {
       /**  create the main block  **/
       minkowski() {
       translate([0,2.5,0])
         cube([BOX_WIDTH, BOX_DEPTH, BOX_HEIGHT],center=true);

         sphere(1);
       }
     }
     /** cut out the middle section  **/
     translate([0,-5,0])
       cube([_box_inside_width, _box_inside_depth, BOX_HEIGHT+5.1],center=true);

     /**  cut out the inner section and leva edges for the panel trails  **/
     cube([_box_center_width, _box_center_depth, _box_center_height],center=true);

     /**  cut ot the front panel trails  **/
     translate([0,2.5,-30])
       trailPanel();

     /**  cut ot the back panel trails  **/
     translate([0,2.5,30])
       trailPanel();       

    *translate([70,0,0])
      cube([40,100,100],center=true);
   }
 }