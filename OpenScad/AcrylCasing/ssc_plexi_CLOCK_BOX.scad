/*////////////////////////////////////////////////////////////////////////////
//////////////////////// Unit Information  ///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
date stated   : 2021-01-30
date finished : 2021-01-30
modeler       : Olle Johansson
application   : SevenSegmentClock (ClockNet)
module        : CLOCK_BOX
version       : 0.1 beta
copyright     : Pipe Dreams / Forrest Floor
subject       : Seven Segment Clock
description   : LED Fram for attaching LED-Display in box.

version history
date            description
2021-01-21	    Start of re-design
*/
$fn = 100;

include <ssc_plexi_DIMENSIONS.scad>;
use <ssc_plexi_PANELS.scad>;


/***************************************************************************
 *
 *                                LOCAL RENDER
 *                      Used to view modules locally
 *
 ***************************************************************************/
// middleCase();

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
// module middleCase() {
//   difference() {
//     union() {
//       mainBoxBlock();

//     }
//   }
// }

/************************************************************************************************************
 **  Module:      mainBoxBlock
 **  Parameters : None
 **  Description: This is tha main, basic block constructing the middleCase
 **              
 ************************************************************************************************************/