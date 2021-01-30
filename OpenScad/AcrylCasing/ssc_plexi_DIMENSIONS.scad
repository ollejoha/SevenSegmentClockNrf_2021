/** INCLUDE FILES **/



/***************************************************************************
 *
 *                            GLOBAL DIMENSION PARAMETERS
 *
 ***************************************************************************/

 /** FRONT PANEL SECTION  **/
 FRONT_PANEL_WIDTH  = 160;
 FRONT_PANEL_DEPTH  =  65; 
 FRONT_PANEL_HEIGHT =   2.5;

 /**  LED DISPLAY DIMENSIONS  **/
 LED_DISPLAY_WIDTH  =  121;
 LED_DISPLAY_HEIGHT =   10;  //** LED Display height without backpack pcb
 LED_DISPLAY_DEPTH  =   41;

 /**  LED FRAME DIMENSIONS  **/
 LED_DISPLAY_FRAME_WIDTH  = LED_DISPLAY_WIDTH + 3;
 LED_DISPLAY_FRAME_HEIGHT = 4;  //LED_DISPLAY_HEIGHT;
 LED_DISPLAY_FRAME_DEPTH  = LED_DISPLAY_DEPTH + 3;

  /**  CLOCK BOX OUTSIDE DIMENSIONS  **/
 BOX_WIDTH          = FRONT_PANEL_WIDTH + 5;  //.. Add 5 mm to get 2.5 mm thick walls, Left/Right
 BOX_DEPTH          = FRONT_PANEL_DEPTH + 5;  //.. Add 5 mm to get 2.5 mm thisc walls, Top/Bootom
 BOX_HEIGHT         = 65;
 BOX_WALL_THICKNESS =  3;

 /**  CLOCK BOX INSIDE DIMENSIONS  **/
//  CLOCK_BOX_INSIDE_WIDTH = CLOCK_BOX_WIDTH - CLOCK_BOX_WALL_THICKNESS * 2;
//  CLOCK_BOX_INSIDE_DEPTH = CLOCK_BOX_DEPTH - CLOCK_BOX_WALL_THICKNESS * 2;
//  CLOCK_BOX_INSIDE_HEIGHT = CLOCK_BOX_HEIGHT;