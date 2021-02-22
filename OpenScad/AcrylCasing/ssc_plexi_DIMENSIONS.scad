/** INCLUDE FILES **/



/***************************************************************************
 *
 *                            GLOBAL DIMENSION PARAMETERS
 *
 ***************************************************************************/

 /** FRONT PANEL SECTION  **/
//    FRONT_PANEL_WIDTH  = 156;
//    FRONT_PANEL_DEPTH  =  85; 
FRONT_PANEL_HEIGHT =   6;  //.. Material thickness

 /** BOTTOM PANEL BLIND VERSION **/
//  BOTTOM_PANEL_WIDTH = 164;
//  BOTTOM_PANEL_DEPTH  =  70;
// BOTTOM_PANEL_HEIGHT =   4;  //.. Material thickness

 
 /** SIDE PANEL BLIND  **/
//  SIDE_PANEL_WIDTH  = BOTTOM_PANEL_DEPTH;
//  SIDE_PANEL_DEPTH  = FRONT_PANEL_DEPTH;
//  SIDE_PANEL_HEIGHT = 4;

 /**  LED DISPLAY DIMENSIONS  **/
LED_DISPLAY_WIDTH  =  121;
LED_DISPLAY_HEIGHT =   10;  //** LED Display height without backpack pcb
LED_DISPLAY_DEPTH  =   41;

LED_DISPLAY_WIDTH_3D  =  120;
LED_DISPLAY_HEIGHT_3D =   10;  //** LED Display height without backpack pcb
LED_DISPLAY_DEPTH_3D  =   41;

 /**  LED FRAME DIMENSIONS  **/
//  LED_DISPLAY_FRAME_WIDTH  = LED_DISPLAY_WIDTH + 3;
//  LED_DISPLAY_FRAME_HEIGHT = 4;  //LED_DISPLAY_HEIGHT;
//  LED_DISPLAY_FRAME_DEPTH  = LED_DISPLAY_DEPTH + 3;

  /**  CLOCK BOX OUTSIDE DIMENSIONS  **/
//  BOX_WIDTH          = FRONT_PANEL_WIDTH + 5;  //.. Add 5 mm to get 2.5 mm thick walls, Left/Right
//  BOX_DEPTH          = FRONT_PANEL_DEPTH + 5;  //.. Add 5 mm to get 2.5 mm thisc walls, Top/Bootom
//  BOX_HEIGHT         = 65;
//  BOX_WALL_THICKNESS =  3;

 /**  CLOCK BOX INSIDE DIMENSIONS  **/
//  CLOCK_BOX_INSIDE_WIDTH = CLOCK_BOX_WIDTH - CLOCK_BOX_WALL_THICKNESS * 2;
//  CLOCK_BOX_INSIDE_DEPTH = CLOCK_BOX_DEPTH - CLOCK_BOX_WALL_THICKNESS * 2;
//  CLOCK_BOX_INSIDE_HEIGHT = CLOCK_BOX_HEIGHT;

/************************************************************************/
/*                          NEW DEFINITIONS                             */
/************************************************************************/

BOX_WIDTH = 168;
BOX_DEPTH =  85;
BOX_HEIGHT = 75;
BOX_MATERIAL_THICKNESS = 4;
FRONT_MATERIAL_THICKNESS = 6;

FRONT_TRAIL_WIDTH = 6;
COMMON_TRAIL_WIDTH = 4;

FRONT_TRAIL_HEIGHT = BOX_MATERIAL_THICKNESS / 2;
COMMON_TRAIL_HEIGHT = BOX_MATERIAL_THICKNESS / 2;

FRONT_PANEL_WIDTH = BOX_WIDTH - 4.2 ;
FRONT_PANEL_DEPTH =  BOX_HEIGHT - 0.2;

BACK_PANEL_WIDTH =  BOX_WIDTH - 4.2 ;
BACK_PANEL_DEPTH =  BOX_HEIGHT - 0.2;
