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
*ldrPanelAdaptor();
*cornerPanelConnectorFront();
*cornerPanelConnectorRear();
connectorMatrix();
*attachDisplayHookLeft();
*attachDisplayHookRight();
*clockStand();

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
   adaptor_u_diameter          = 10.05;
   adaptor_height              = 7;

   adaptor_cable_hole_diameter = 4;

   ldr_fixture_diameter = 5.5;
   ldr_fixture_height    = 2.3;

   adaptor_fixing_ring_diameter = 13;
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

      translate([0,-7.7,5])
        cube([10,5,5],center=true);


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

  /************************************************************************************************************
 **  Module:      attachDisplayHookLeft
 **  Parameters : None
 **  Description: Detail for attaching the front and back panels to the middle section of the box.
 **               This detail is glued to the inner cornar at the back and front panels.
 **               The front panel is screwed from the insida of the box.
 **              
 ************************************************************************************************************/
  module attachDisplayHookLeft() {

    _base_width  = 35;
    _base_depth  =  7;
    _base_height =  3;

    _wall_width = _base_width;
    _wall_depth = 1.5;
    _wall_height = 9;

    _hook_width = _base_width;
    _hook_depth = 5;
    _hook_height = 1.5;

    _m3_diameter = 3.3;
    _m3_length   = 4;

    _slot_width = 13;
    _slot_depth  =  10;
    _slot_height = _base_height;

    difference() {
      union() {

        *color("green") {
          translate([0, -5,3])
            cube([26, 6, 6],center=true);
        }  
        /** base segment **/
        cube([_base_width, _base_depth, _base_height],center=true);
        
        /** wall segment **/
        translate([0, -_base_depth/2 + _wall_depth/2, _wall_height/2 - _base_height/2])
          cube([_wall_width, _wall_depth, _wall_height],center=true);

        /** hook segment **/
        translate([0, -_base_depth/2 + _wall_depth/2 - _hook_depth/2 + _wall_depth/2, _wall_height - _hook_height - _hook_height/2])
          cube([_hook_width, _hook_depth, _hook_height],center=true);        
        
        translate([0, -6, 6])
          rotate([0,90,0])
            cylinder(d=1, h =26, center=true);
      }
      translate([10, 0,-2])
        hull() {
          cylinder(d=_m3_diameter, h=_m3_length);
          translate([0, 3, 0])
            cylinder(d=_m3_diameter, h=_m3_length);
        }

      translate([-10, 0 ,-2])
        hull() {
          cylinder(d=_m3_diameter, h=_m3_length);
          translate([0, 3, 0])
            cylinder(d=_m3_diameter, h=_m3_length);
        }

      translate([0, 1.1, 0])
        cube([_slot_width, _slot_depth, _slot_height + 0.1],center=true);        
    }
  }

  /************************************************************************************************************
 **  Module:      attachDisplayHookRight
 **  Parameters : None
 **  Description: Detail for attaching the front and back panels to the middle section of the box.
 **               This detail is glued to the inner cornar at the back and front panels.
 **               The front panel is screwed from the insida of the box.
 **              
 ************************************************************************************************************/
  module attachDisplayHookRight() {

    _base_width  = 35;
    _base_depth  =  7+5;
    _base_height =  3;

    _wall_width = _base_width;
    _wall_depth = 1.5;
    _wall_height = 9;

    _hook_width = _base_width;
    _hook_depth = 4.5;
    _hook_height = 1.5;

    _m3_diameter = 3.3;
    _m3_length   = 4;

    _slot_width = 13;
    _slot_depth  =  10;
    _slot_height = _base_height;

    difference() {
      union() {

        *color("green") {
          translate([0, -5,3])
            cube([26, 6, 6],center=true);
        }  
        /** base segment **/
        cube([_base_width, _base_depth, _base_height],center=true);
        
        /** wall segment **/
        translate([0, -_base_depth/2 + _wall_depth/2, _wall_height/2 - _base_height/2])
          cube([_wall_width, _wall_depth, _wall_height],center=true);

        /** hook segment **/
        translate([0, -_base_depth/2 + _wall_depth/2 - _hook_depth/2 + _wall_depth/2, _wall_height - _hook_height - _hook_height/2])
          cube([_hook_width, _hook_depth, _hook_height],center=true);        
        
        translate([0, -6, 6])
          rotate([0,90,0])
            cylinder(d=1, h =26, center=true);
      }
      translate([10, 0,-2])
        hull() {
          cylinder(d=_m3_diameter, h=_m3_length);
          translate([0, 3+5, 0])
            cylinder(d=_m3_diameter, h=_m3_length);
        }

      translate([-10, 0 ,-2])
        hull() {
          cylinder(d=_m3_diameter, h=_m3_length);
          translate([0, 3+5, 0])
            cylinder(d=_m3_diameter, h=_m3_length);
        }

      translate([0, 1.1, 0])
        cube([_slot_width, _slot_depth, _slot_height + 0.1],center=true);        

      *translate([0, 7,-2])
        cylinder(d=_m13_diameter, h=_m13_length);        
    }
  }


  /************************************************************************************************************
 **  Module:      clockStand();
 **  Parameters : None
 **  Description: Temporary clock stand during development
 ************************************************************************************************************/
 module clockStand() {

   _stand_width = 50;
   _stand_depth = 6;
   _stand_height =9;

   _bar_width = 20;
   _bar_depth = 4;
   _bar_height = 4;

   _clock_panel_width = 6.5;
   _clock_panel_depth =_stand_depth;
   _clock_panel_height = _stand_height - 2;

   difference() {
     union() {
       cube([_stand_width, _stand_depth, _stand_height],center=true);
       translate([_bar_width + _stand_depth/2, 0, -_stand_height/2 + _bar_height/2])
         cube([_bar_depth, _bar_width, _bar_height],center = true);
     }
     translate([-_stand_width/2 + _clock_panel_depth,0,_stand_height/2 - _clock_panel_height/2 + 0.1])
       cube([_clock_panel_depth, _clock_panel_width, _clock_panel_height], center= true);
    
    translate([12,0,4])
      cube([_stand_width+0.1, _stand_depth+0.1, _stand_height+0.1],center=true);
    
   }
 }