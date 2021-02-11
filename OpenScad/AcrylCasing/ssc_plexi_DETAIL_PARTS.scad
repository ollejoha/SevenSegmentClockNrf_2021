/*////////////////////////////////////////////////////////////////////////////
//////////////////////// Unit Information  ///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
date stated   : 2021-02-07
date finished : 2021-02-07
modeler       : Olle Johansson
application   : SevenSegmentClock (ClockNet)
module        : Detail_Parts
version       : 0.1 beta
copyright     : Pipe Dreams / Forrest Floor
subject       : Seven Segment Clock
description   : Additional detail parts for maounting the clock and its coponents

version history
date            description
2021-02-07	    Start of re-design
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
*frontPanelExt();
ldrPanelAdaptor();
*cornerPanelConnectorFront();
*cornerPanelConnectorRear();
*connectorMatrix();

 /***************************************************************************
 *
 *                                MODULES
 *
 ***************************************************************************/

/************************************************************************************************************
 **  Module:      connectorMatrix
 **  Parameters : None
 **  Description: Combination of connector items to simplify milling
 **              
 ************************************************************************************************************/
module connectorMatrix() {
  difference() {
    union() {
      for (a = [0:3]) {
        translate([a*12,0,-2])
        cornerPanelConnectorFront();
      }
      for (a = [0:3]) {
        translate([a*12,18,-2])
        cornerPanelConnectorRear();
      }      
    }
  }
}

/************************************************************************************************************
 **  Module:      ldrPanelAdaptor
 **  Parameters : None
 **  Description: Adaptor for mounting LDR resistor in front panel
 **              
 ************************************************************************************************************/
module ldrPanelAdaptor() {
   adaptor_u_diameter          = 8.3;
   adaptor_height              = 7;

   adaptor_cable_hole_diameter = 4;

   ldr_fixture_diameter = 5.5;
   ldr_fixture_height    = 2.3;

   adaptor_fixing_ring_diameter = 10;
   adaptor_fixing_ring_height    =  2;


   adaptor_i_diameter          = 5.1;


   adaptor_inner_ring_diameter = 10;
   adaptor_inner_ring_height   = 10;
   adaptor_ldr_ring_hight      =  2.1;

   difference() {
     union() {
      cylinder(d=adaptor_u_diameter, h=adaptor_height);
      cylinder(d=adaptor_u_diameter, h=adaptor_height);
      translate([0,0,adaptor_height - adaptor_fixing_ring_height])
        cylinder(d=adaptor_fixing_ring_diameter, adaptor_fixing_ring_height);
     }
     translate([0,0,-0.1])
       cylinder(d=adaptor_cable_hole_diameter, h=adaptor_height+2);

      translate([0, 0, 2])
        cylinder(d2=adaptor_cable_hole_diameter-1,d1=adaptor_cable_hole_diameter+2, h=7);

     translate([0,0,-0.1])       
       cylinder(d=ldr_fixture_diameter, h=ldr_fixture_height);


     *cylinder(d=adaptor_i_diameter, h=adaptor_inner_ring_height);
     *cylinder(d=adaptor_inner_ring_diameter, h=adaptor_height);
   }
 }


/************************************************************************************************************
 **  Module:      ldrResistor
 **  Parameters : None
 **  Description: LDR Resistor . used for reference to the LDR adaptor
 **              
 ************************************************************************************************************/
module ldrResistor() {
  ldrDiameter = 5.1;
  ldrHeight   = 1.95;
  difference() {
    union() {
      color("red") {
        cylinder(d=ldrDiameter, h=ldrHeight);
      }
    }
  }
 } 

/************************************************************************************************************
 **  Module:      cornerPanelConnectorFront
 **  Parameters : None
 **  Description: Detail for attaching the front and back panels to the middle section of the box.
 **               This detail is glued to the inner cornar at the back and front panels.
 **               The front panel is screwed from the insida of the box.
 **              
 ************************************************************************************************************/
module cornerPanelConnectorFront() {
   _angle_connector_width = 12;
   _angle_screw_hole_diam = 3;
   _angle_screw_height    = 3;
   difference() {
     union() {
       hull() {
         cylinder(d=_angle_screw_hole_diam, _angle_screw_height);
         
         translate([_angle_connector_width-5, 0, 0])  
           cylinder(d=_angle_screw_hole_diam, _angle_screw_height);

          translate([0,  _angle_connector_width, 0])  
            cylinder(d=_angle_screw_hole_diam, _angle_screw_height);
       }
     }
     translate([2.65, 2.6, 0])
       cylinder(d=_angle_screw_hole_diam, _angle_screw_height);
   }
  }

  /************************************************************************************************************
 **  Module:      cornerPanelConnectorRear
 **  Parameters : None
 **  Description: Detail for attaching the front and back panels to the middle section of the box.
 **               This detail is glued to the inner cornar at the back and front panels.
 **               The front panel is screwed from the insida of the box.
 **              
 ************************************************************************************************************/
module cornerPanelConnectorRear() {
   _angle_connector_width = 12;
   _angle_screw_hole_diam = 3;
   _angle_screw_height    = 3;
   difference() {
     union() {
       hull() {
         cylinder(d=_angle_screw_hole_diam, _angle_screw_height);
         
         translate([_angle_connector_width-5, 0, 0])  
           cylinder(d=_angle_screw_hole_diam, _angle_screw_height);

          translate([0,  _angle_connector_width, 0])  
            cylinder(d=_angle_screw_hole_diam, _angle_screw_height);
       }
     }
     translate([2.65, 2.6, 0])
       cylinder(d=_angle_screw_hole_diam-0.3, _angle_screw_height);
   }
  }