/*********************************************************************************************************************
 *     Processor: Atmega 328P / 16 MHz
 *     BOD level: 2.7 v
 * Configuration: Standard
 * 
 * 
 *        Program: Soil Temperature & Humidity Sensor
 *         Module: soilTemperature
 *  Creation date: 2020-12-11
 *         Author: Olle Johansson
 * ********************************************************************************************************************
  * Revision history
 +------------+------------+------------------------------------------------------------------------------------------+
 | Date       | SW version | HW version | Description                                                                 |
 +------------+------------+------------+-----------------------------------------------------------------------------+
 | 2021-01-17 | b-2.0.0    | v1.1       | First code for sevenSegmentClockNrf V2                                      |
 +------------+------------+------------+-----------------------------------------------------------------------------+
 | 2021-01-17 | b-2.0.0    | v1.1       | Addition:                                                                   |
 |            |            |            | Added function for automatic LED brightness                                 |
 +------------+------------+------------+-----------------------------------------------------------------------------+
 | 2021-01-30 | b-2.1.0    | v1.1       | Changed temperature display to show one decimal. Consequence is that the    |
 |            |            |            | prefix for Celsius 'c' cannot be shown due to limitations in the LED Display|
 +------------+------------+------------+-----------------------------------------------------------------------------+
 | 2021-01-31 | b-2.1.1    | v1.1       | Cleaned code in the recieve function to minimze the time it takes to execute|
 |            |            |            | Corrected a type in the send function for air pressure that flooded the     |
 |            |            |            | radio communcation. Pressure and UV index shall now be working. UV index    |
 |            |            |            | needs more testing when thera are sunligt to verify that the NeoPixel stick |
 |            |            |            | is working as expected. Also added a simple test routine for the NeoPixel   |
 |            |            |            | stick that lits up and turn off the stick in seuence at startup.            |
 |            |            |            | Eventually this routine will be moved to a more sutible location            |
 +------------+------------+------------+-----------------------------------------------------------------------------+
 | 2021-02-03 |b-2.1.2     |v1.1        | - Added function to show current programversion on the display              |
 |            |            |            | - Updated the function for uv-level on the neopixel stick so that it is     |
 |            |            |            |   reset end updated when the uv-level deceases                              |
 +------------+------------+------------+-----------------------------------------------------------------------------+
 | 2021-02-15 |b-2.1.3     |v1.1        | - Updated funtion for writing the outdoor temperature to the display so that|
 |            |            |            |   that there is no leading zero when temperature is betewwn 0.0 - 9.9       |
 |            |            |            |    degrees C.                                                               |
 +------------+------------+------------+-----------------------------------------------------------------------------+
 -----  NOTE  -----
 Update the constants that comes direct after thos comment section when the program 
 is updated so that the current program version is shown on the display
 

 *  Radio conrolled 7-segment LED state with RTC
 * The state has 1 internal temperature sensor (DS18B20) and a connector to display external temperature sensors
 * (DS18b20). Outdoor temperature is received from an external temperature sensor that sends temperature and
 * humidity to the state by node to node communication. 
 * 
 * LED brightness are adjusted by a SI2591 Light sensor. It is possible to use an older light sensor, DS2561. 
 * It is also possible to adjust LED brighness by a photoresistor.
 * NOTE TO ABOVE: TLS Sensors has been omitted initially. Standard for LED brigtness will use photoresistor
 * 
 * Message transport implemnented as: Node 27 -> Node 95 (7) ->96/97/98/99 where
 * 95 = PATIO_state
 * 96 = BEDROOM_state
 * 97 = LIVINGROOM_state
 * 98 = OFFICE_state
 * 99 = KITCHEN_state
 * 
 * Node 27, SensbenderMicro acts as the temperature and humidity sensor. Data for temperature and humidity is sent to
 * NodeId 1, wich acts as a relay node for other LED states that shall get information from Node 27.
 * The reason why we use a relay node is to minimize the battery power use in node 27. The LED states are powered
 * from AC.outlet or other types of fixed power supply,
 * 
 * LED MATRIX information
 * There's a few ways you can draw to the display. The easiest is to just call print - just like you do with Serial
 * print(variable,HEX) - this will print a hexidecimal number, from 0000 up to FFFF
 * print(variable,DEC) or print(variable) - this will print a decimal integer, from 0000 up to 9999
 * If you need more control, you can call writeDigitNum(location, number) - this will write the number (0-9) to a
 * single location. Location #0 is all the way to the left, location #2 is the colon dots so you probably want to
 * skip it, location #4 is all the way to the right.
 * To control the colon and decimal points, use the writeDigitRaw(location, bitmap) function.
 * 
 * (Note that both dots of the center colon are wired together internal to the display, so it is not possible to
 * address them separately.)  Specify 2 for the location and the bits are mapped as follows:
 * 
 * 0x02 - center colon (both dots)
 * 0x04 - left colon - lower dot
 * 0x08 - left colon - upper dot
 * 0x10 - decimal point
 * 
 * If you want a decimal point, call writeDigitNum(location, number, true) which will paint the decimal point.
 * To draw the colon, use drawColon(true or false)
 * 
 * If you want full control of the segments in all digits, you can call writeDigitRaw(location,bitmask) to draw a raw
 * 8-bit mask (as stored in a uint8_t) to anylocation.
 * 
 * All the drawing routines only change the display memory kept by the Arduino. Don't forget to call writeDisplay()
 * after drawing to 'save' the memory out to the matrix via I2C.
 * 
 * There are also a few small routines that are special to the backpack:
 * 
 * setBrightness(brighness)- will let you change the overall brightness of the entire display. 0 is least bright, 
 * 15 is brightest and is what is initialized by the display when you start blinkRate(rate) - You can blink the
 * entire display. 0 is no blinking. 1, 2 or 3 is for display blinking.
 * 
 * ------< HISTORY >-------
 * 2021-01-12  Rewritten for optimization
 * ****************************************************************************************************************/
#define PROGRAM_VERSION 2
#define UPDATE_VERSION  1
#define PATCH_VERSION   3
// TODO: Add Function to show data if high box temperature, ans send warning to controller
// TODO: Add Function to visualise UV Index outside the LED display. In progress
// TODO: Add function to indicate if the measured value (except for UVI) is rising/falling 
// TODO: Implement function to show air preassure. Implemented. In test phase.




/***************************************************************************************
 * 
 * Uncomment the line below if sensor shall be connected to the Development plattform
 * 
 * ***********************************************************************************/
#define DEVELOPMENT_PLATFORM       //.. Uncomment to use development platform, radio channel 83

/***************************************************************************************
 * 
 * Uncomment the line if sensor shall be a reapeater node
 * 
 * ***********************************************************************************/
#define MY_REPEATER_FEATURE     //.. Activate node as repeter to extend networking range

/***************************************************************************************
 * 
 * Uncomment the line to select target node
 * 
 * ***********************************************************************************/
//#define LED_state_ID_1           //..  PATIO_state              NodeId     = 95
//#define LED_state_ID_2           //..  LIVINGROOM_state         Livingroom = 96 
//#define LED_state_ID_3           //..  BEDROOM_state            Bedroom    = 97
#define LED_state_ID_4           //..  OFFICE_state             Office     = 98
//#define LED_state_ID_5           //..  KITCHEN_state            Kitchen    = 99

#define CLOCK_NET_DEST_NODES    4  //.. Set the number of destination nodes active in CLockNetNode 
#define CLOCK_NET_DEST_OFFSET  96  //.. Start offset for the first destination  nodes
                                   //.. This offset value has to be changed if other values are set for the clockNet.
                                   //.. Main node NodeId 1 and its child nodes must be in a consequtive serie.

/***************************************************************************************
 * 
 * DEBUG SWITCHES
 * 
 * ***********************************************************************************/
//#define MY_DEBUG             //.. MySensors debug information
//#define APP_DEBUG            //.. Common application debug information
//#define SM_DEBUG             //.. State machine debug information
//#define RTC_DEBUG            //.. Debug information for RTC
//#define DS18B20_DEBUG        //.. Temperature sensor debug information
//#define RECIEVE_MSG_DEBUG    //.. Debug information for receiving messages
//#define RELAY_MSG_DEBUG      //.. Debug information for relaying messages

#ifdef LED_state_ID_1          //.. Patio state
  #ifdef DEVELOPMENT_PLATFORM
    #define state_ID        1   
    #define MY_NODE_ID     95
    #define SN "7-SefClkNrf-ClkId-1"
  #else
    #define state_ID        1
    #define MY_NODE_ID     95
    #define SN "7-SefClkNrf-ClkId-1"
  #endif
#endif

#ifdef LED_state_ID_2          //.. Bedroom state
  #ifdef DEVELOPMENT_PLATFORM
    #define state_ID        2   
    #define MY_NODE_ID     96
    #define SN "7-SefClkNrf-ClkId-2"
  #else
    #define state_ID        2
    #define MY_NODE_ID     96
    #define SN "7-SefClkNrf-ClkId-2"
  #endif
#endif

#ifdef LED_state_ID_3          //.. Livingroom state
  #ifdef DEVELOPMENT_PLATFORM
    #define state_ID        3   
    #define MY_NODE_ID     97
    #define SN "7-SefClkNrf-ClkId-3"
  #else
    #define state_ID        3
    #define MY_NODE_ID     97
    #define SN "7-SefClkNrf-ClkId-3"
  #endif
#endif

#ifdef LED_state_ID_4          //.. Office state
  #ifdef DEVELOPMENT_PLATFORM
    #define state_ID        4   
    #define MY_NODE_ID     98
    #define SN "7-SefClkNrf-ClkId-4"
  #else
    #define state_ID        4
    #define MY_NODE_ID     98
    #define SN "7-SefClkNrf-ClkId-4"
  #endif
#endif

#ifdef LED_state_ID_5          //.. Kitchen state
  #ifdef DEVELOPMENT_PLATFORM
    #define state_ID        5   
    #define MY_NODE_ID     99
    #define SN "7-SefClkNrf-ClkId-5"
  #else
    #define state_ID        5
    #define MY_NODE_ID     99
    #define SN "7-SefClkNrf-ClkId-5"
  #endif
#endif




/****************** APPLICATION DEFINES ******************/
#define CHILD_ID_BOX_TEMP    1     //.. Internal temperature sensor
#define CHILD_ID_INDOOR_TEMP 2     //.. Indoor external temperature sensor

#ifdef LED_state_ID_1              //.. Patio state
  #define CHILD_RELAY_ID_MSG  50   //.. ID for relaying messages to other state nodes
#endif

#define LED_ADDRESS 0x70           //.. Address for 7-segment display

/**  SET TEMPERATURE RESOLUTION AND CONVERSION TIME  **/
/** It is not recomended to use higher resolution than 9 because of timing issues  **/
#define TEMPERATURE_PRECISION 9             //.. Resolution: 0.5000 C, conversion time:  93.75 ms  (max) This is the
                                            //.. preffered resulotion because it has the shortest conversion time.
//#define TEMPERATURE_PRECISION 10            //.. Resolution: 0.2500 C, conversion time: 187.50 ms  (max) 
//#define TEMPERATURE_PRECISION 11            //.. Resolution: 0.1250 C, conversion time: 375.00 ms  (max) 
//#define TEMPERATURE_PRECISION 12            //.. Resolution: 0.0625 C, conversion time: 750.00 ms  (max) 

/********************* PIN DEFINES **********************/
#define LIGHT_SENSOR_ANALOG_PIN  A0  //.. Used for automatic LED brightness control
                                     //..    +-------- +5V
                                     //..    |
                                     //..   +-+
                                     //..   | | <-  GP0 (A0) (LDR 18K - 50K)
                                     //..   +-+
                                     //..    |
                                     //..   +-+
                                     //..   | |  10K  (R1) (Initially 100K)
                                     //..   +-+
                                     //..    |
                                     //..    +-------- Gnd
                                     //..
                                     //.. Brightness reading 200 - 1000 map to 0 - 15

#define ONE_WIRE_BUS              7  //.. Used for temperature sensors DS18b20

/****************** LED MATRIX DEFINES ******************/
#define INSIDE_DOT          4        //.. Dot to indicate inside temperature on LED display
#define OUTSIDE_DOT         8        //.. Dot to indicate outside temperature on LED display
/****************** LED MATRIX OPTIONS ******************/
//#define CELSIUS_PREFIX     0x58      //.. Celsius prefix - 'c'  //.. Turned off 2021-01-24 for Decimal-temperatures branch
//#define CELSIUS_PREFIX     0x39      //.. Celsius prefix - 'C'
#define HUMIDITY_PREFIX    0x74      //.. Humidity prefix 'h'
//#define HUMIDITY_PREFIX    0x76      //.. Humidity prefix 'H'
#define UVI_PREFIX          0x1C      //.. UV prefix 'u'
//#define UVI_PREFIX          0x3E      //.. UV prefix 'U'
#define DECI_POINT         0x10      //.. LED decimal point
#define MINUS_SIGN         0x40      //.. Minus sign
#define PROG_INDICATOR     0x73      //.. Prefix for program version displayed at startup. Prefix = 'P'
#define CENTER_COLON       0x02      //.. Print center coloun i column 2
/****************** THRESHOLD DEFINES *******************/
#define LUX_RATE       10000UL
#define BLINK_RATE      1000

/******************** TIMING DEFINES ********************/
#define INDOOR_TEMPERATURE_FREQUENCE  60000UL
#define REQUEST_TIME_ON_STARTUP       1000UL * 10UL
#define REQUEST_TIME_PERIODICALLY     1000UL * 60UL * 60UL
#define CLOCK_NET_RELAY_SEND          1000UL * 60UL * 2UL    // UNDONE: Remove??? Not used anywhere.

/******************** SELECTION AREA ********************/
#ifdef DEVELOPMENT_PLATFORM
  #define MY_RF24_CHANNEL 83    //.. Radio channel 83 is used for the development platform
  #define SW "DEV 2.0.2"
#else
  #define SW "2.0.2"
#endif

/***************************************************************************************
 * 
 * SELECT TYPE OF RADIO
 * 
 * ***********************************************************************************/
#define MY_RADIO_NRF24         //.. Activate radio module nRF24L01

/**************** INCLUDE HEADER AREA *****************/
#include <MySensors.h>
#include <Wire.h>
#include <OneWire.h>
#include <Time.h>
#include <TimeLib.h>
#include <DS1307RTC.h>
#include <DallasTemperature.h>
#include <Adafruit_GFX.h>
#include <Adafruit_LEDBackpack.h>
#include <Adafruit_NeoPixel.h>


/******************** CONSTRUCT MESSAGES ********************/
MyMessage msgBoxTemp(CHILD_ID_BOX_TEMP, V_TEMP);
MyMessage msgIndoorTemp(CHILD_ID_INDOOR_TEMP, V_TEMP);

#ifdef LED_state_ID_1
  MyMessage msgRelayTemp(CHILD_RELAY_ID_MSG, V_TEMP);
  MyMessage msgRelayHum(CHILD_RELAY_ID_MSG, V_HUM);
  MyMessage msgRelayUvi(CHILD_RELAY_ID_MSG, V_UV);
  MyMessage msgRelayAirPres(CHILD_RELAY_ID_MSG, V_PRESSURE);
#endif

/*************** VARIABLE, CONSTANTS & OBJECTS **************/
typedef enum {
               STATE_LED_DISPLAY_SETUP,
               STATE_INDOOR_TEMP,
               STATE_OUTDOOR_TEMP,
               STATE_OUTDOOR_HUM,
               STATE_OUTDOOR_UVI,
               STATE_OUTDOOR_PRESSURE,
               STATE_CLOCK_UPDATE
} msm_t;

msm_t state = STATE_LED_DISPLAY_SETUP;



//.. Setup a oneWire instance to communicate with any OneWire devices
OneWire oneWire(ONE_WIRE_BUS);

//.. Pass the oneWire reference to Dallas Temperature
DallasTemperature sensors(&oneWire);

DeviceAddress inboxTemperature, indoorTemperature;

tmElements_t tm;
bool          once                  = false;
bool          bBlinkColon           = false;
bool          bTimeReceived         = false;
bool          bBelowZero            = false;
bool          bRelayTempMsg         = false;
bool          bRelayHumMsg          = false;
bool          bRelayUviMsg          = false;
bool          bRelayAirPresMsg      = false;
uint16_t      ledBrightness         = 15;
uint8_t       nodeDestTempCnt       = 0;
uint8_t       nodeDestHumCnt        = 0;
uint8_t       nodeDestUviCnt        = 0;
uint8_t       nodeDestAirPresCnt    = 0;
float         outdoorTemperature    = 99.0;
int           outdoorHumidity       =  0;
float         outdoorUvIndex        =  0.0;
float         airPressure           =  0.0;
unsigned long lastRequest           = 0;
unsigned long lastBlink             = millis();
unsigned long lastBoxTemperature    = millis();
unsigned long lastIndoorTemperature = millis();
unsigned long lastClockUpdate       = millis();
unsigned long lastBrightnessTime    = millis();
float lastTemperatureBox;
float lastTemperatureIndoor;
time_t local;

/** neopixel dfinitions **/
int pin         = 5;    //.. Data pin for neopixel stick
int numPixels   = 16;   //.. Number of pixels in neopixel stick
int pixelFormat = NEO_GRB + NEO_KHZ800;

/** define color scheme for UV-Index **/
uint8_t uvArrayDim [16] [3] ={ {  0, 255,   0},  // Green
                               {  0, 255,   0},  // Green  
                               {255, 225,   0},  // Yellow
                               {255, 225,   0},  // Yellow
                               {255, 225,   0},  // Yellow
                               {226, 115,   0},  // Orange
                               {226, 115,   0},  // Orange
                               {200,   0,   0},  // Red
                               {255,   0,   0},  // Red
                               {255,   0,   0},  // Red
                               {255,   0, 255},  // Magenta
                               {255,   0, 255},  // Magenta
                               {255,   0, 255},  // Magenta
                               {255,   0, 255},  // Magenta
                               {255,   0, 255},  // Magenta
                               {255,   0, 255}}; // Magenta

/** Create a pointer obkect for neopixel stick **/
Adafruit_NeoPixel *pixels;


/**  Create a matrix object for the 7-segment display  **/
Adafruit_7segment ledMatrix         = Adafruit_7segment();
int8_t digits[]                     = {0,0,2,3};
static bool drawDots                = false;

/**************************************************************
 *   Function: receiveTime
 * Parameters: Unsigned long
 *    Returns: nothing
 *************************************************************/
void receiveTime(unsigned long controllerTime) {
  time_t newTime = controllerTime;
  Serial.print(F("Time value received: "));
  Serial.println(controllerTime);
  
  RTC.set(controllerTime);  /** Set the RTC to the time from controller **/
  time_t local = now();
  #ifdef APP_DEBUG
    printDateTime(local);
  #endif
  bTimeReceived = true;
  ledMatrix.blinkRate(0);
}

/**************************************************************
 *   Function: printVersionInfo
 * Parameters: int, int, int
 *    Returns: nothing
 *************************************************************/
void printVersionInfo() {
  ledMatrix.clear();
  ledMatrix.writeDigitRaw(0, PROG_INDICATOR);
  ledMatrix.writeDigitNum(1, PROGRAM_VERSION);
  // ledMatrix.drawColon(true);
  ledMatrix.writeDigitNum(3, UPDATE_VERSION);
  ledMatrix.writeDigitRaw(2, CENTER_COLON + DECI_POINT);
  ledMatrix.writeDigitNum(4, PATCH_VERSION);
  ledMatrix.writeDisplay();
  delay(10000);
}
/**************************************************************
 *   Function: setup
 * Parameters: none
 *    Returns: nothing
 *************************************************************/
void setup() {
  ledMatrix.begin(LED_ADDRESS);
  printVersionInfo();
  showstateId();  //.. Show stateId and NodeId on the dislpay
  delay(200);
  ledMatrix.blinkRate(2);    //.. Blink rate 2 indicates RTC in node has not synced with controller yet.
  setSyncProvider(RTC.get);  //.. Call the RTC to sync with local Time object.
  #ifdef RTC_DEBUG
    rtcStatus();              //.. Verify status of local RTC chip and print status.
  #endif
  local = now();
  #ifdef APP_DEBUG
    Serial.print(F("RTC sync..."));
    if (timeStatus() != timeSet)
      Serial.println(F(" Unable to sync with RTC"));
    else
      Serial.println(F("RTC has set the system time"));
  
    /** Request latest time from controller at startup  **/
    Serial.println(F("Request time from controller on startup..."));
  #endif

/** Create a new NeoPixel object dynamically with these values **/
pixels = new Adafruit_NeoPixel(numPixels, pin, pixelFormat);

pixels->begin();  //.. Initialize NeoPixel strip object
pixels->show();

/** Simple test procedure for the NeoPixel stick. Just to se that it is working **/
pixels->setBrightness(10);
  for (int i = 0; i < numPixels; i++) {
    uint32_t color = pixels->Color(uvArrayDim[i][0], uvArrayDim[i][1], uvArrayDim[i][2]);
    pixels->setPixelColor(i, color);
    pixels->show();
    delay(200);
  }

   for (int j = 0; j < numPixels; j++) {
     pixels->clear();
      for (int i = numPixels-j; i > 0; i--) {
        uint32_t color = pixels->Color(uvArrayDim[i-1][0], uvArrayDim[i-1][1], uvArrayDim[i-1][2]);
        pixels->setPixelColor(i-1, color);
        pixels->show();
      }
      delay(200);
   }
   delay(200);
   pixels->clear();
   pixels->show();
/** End of test routine for the NeoPixel stick **/
  
  requestTime();
}  //-- End of setup


/**************************************************************
 *   Function: presentation
 * Parameters: none
 *    Returns: nothing
 *************************************************************/
void presentation() {
  sendSketchInfo(SN, SW);
  present(CHILD_ID_BOX_TEMP, S_TEMP);
  present(CHILD_ID_INDOOR_TEMP, S_TEMP);
}  //-- End of presentation

/**************************************************************
 *   Function: receive
 * Parameters: none
 *    Returns: nothing
 *************************************************************/
void receive(const MyMessage &message) {
  if (message.isAck()) {
    Serial.println(F("GW Ack"));
  }

  switch (message.sender) {
    #ifdef LED_state_ID_1
      case 27:  //.. Pergola sensor

        if (message.type == V_TEMP) {           //.. Get temperature from Pegola sensor
          bRelayTempMsg = true;
          //bBelowZero = (message.getFloat() < 0.0) ? true : false;
          outdoorTemperature = message.getFloat();
          //bBelowZero = outdoorTemperature < 0.0 ? true : false;
          #ifdef RECIEVE_MSG_DEBUG
            Serial.print(F("Received outdoor temp: "));
            Serial.println(outdoorTemperature);
            Serial.print(F("New pergola temperature received: "));
            Serial.println(message.getFloat());
          #endif
        }
  
        if (message.type == V_HUM) {           //.. Get humidity from Pegola sensor
          bRelayHumMsg = true;
          outdoorHumidity = static_cast<int>(round(message.getFloat()));
          #ifdef RECIEVE_MSG_DEBUG
            Serial.print(F("New pergola humidity received: "));
            Serial.println(message.getFloat());
          #endif
        }
        //Serial.print(F("H:"));Serial.print(bRelayTempMsg);Serial.print(bRelayHumMsg);Serial.print(bRelayUviMsg);Serial.println(bRelayAirPresMsg);
        break;

        case 31:  //.. Weater station
          if (message.type == V_PRESSURE) {    //.. Get air preassure from weather station
            bRelayAirPresMsg = true;
            airPressure = message.getFloat();
            #ifdef RECIEVE_MSG_DEBUG
              Serial.print(F("New air pressure: "));
              Serial.println(airPressure);
            #endif
          }

          if (message.type == V_UV) {          //.. Get UV-Index from weather station
            //if (tm.Hour < 14) {
              bRelayUviMsg = true;
              outdoorUvIndex = message.getFloat();
              #ifdef RECIEVE_MSG_DEBUG
                Serial.print(F("New UV level received from garden: "));
                Serial.println(outdoorUvIndex);
              #endif
            //}
          }          
          break;

        case 5:   //..  Frontyard UV & Light sensor
          if (message.type == V_LEVEL) {
            //.. not implemented in clock node. Message is sent from Frontyard
          }

          if (message.type == V_UV) {
           // if (tm.Hour >= 14) {
              bRelayUviMsg = true;
              outdoorUvIndex = message.getFloat();
              #ifdef RECIEVE_MSG_DEBUG
                Serial.print(F("New UV level received from frontyard: "));
                Serial.println(outdoorUvIndex);
              #endif
           // }
          }
          break;

    #else
      case 95:  //.. Patio node. Relay node
        switch (message.type) {
          case V_TEMP:
            //bBelowZero = (message.getFloat() < 0.0) ? true : false;
            outdoorTemperature = message.getFloat();
            bBelowZero = outdoorTemperature < 0.0 ? true : false;
            #ifdef RECIEVE_MSG_DEBUG
              Serial.print(F("New Pergola temperature received from NodeId 1: "));
              Serial.println(message.getFloat());
            #endif          
            break;
  
          case V_HUM:
            outdoorHumidity = static_cast<int>(round(message.getFloat()));
            #ifdef RECIEVE_MSG_DEBUG
              Serial.print(F("New Pergola humidity received from NodeId 1: "));
              Serial.println(message.getFloat());
            #endif            
            break;
  
          case V_UV:
            outdoorUvIndex = message.getFloat();
            #ifdef RECIEVE_MSG_DEBUG
              Serial.print(F("New UV level received from NodeId 1: "));
              Serial.println(outdoorUvIndex);
            #endif            
          break;  

          case V_PRESSURE:
            airPressure = message.getFloat();
            #ifdef RECIEVE_MSG_DEBUG
              Serial.print(F("New air pressure: "));
              Serial.print(airPressure);
            #endif
            break;
       }    
    #endif
  }
}
/**************************************************************
 *   Function: loop
 * Parameters: none
 *    Returns: nothing
 *************************************************************/
void loop() {
  /** Get current time and convert to local time according to defined timezone **/
  time_t local = now();

  /** Set currentTime for current iteration **/
  unsigned long now = millis();
  unsigned long currentTime = millis();

  /** SET LED BRIGHTNESS DEPENDING ON ENVIRONMENT LIGHT **/
  if (currentTime - lastBrightnessTime > 5000) {
    lastBrightnessTime = millis();
    uint16_t envLightLevel = analogRead(LIGHT_SENSOR_ANALOG_PIN);

    if (envLightLevel < 200) envLightLevel = 200;          // TEST --- 360) envLightLevel = 360;
    if (envLightLevel > 1000) envLightLevel = 1000;        // TEST --- 860) envLightLevel = 860;
    ledBrightness = map(envLightLevel, 200, 1000, 0, 15);  // TEST --- map(envLightLevel, 360, 860, 0, 15);
    ledMatrix.setBrightness(ledBrightness);
    ledMatrix.setBrightness(10);  //  // HACK: Set fixed brightness of display temporarily
    ledMatrix.writeDisplay();
    // TEMPORARY DEBUG CODE
    // Serial.print(F("LED Brightness: "));
    // Serial.print(ledBrightness);
    // Serial.print(F(" "));
    // Serial.println(envLightLevel);    
  }

  /**  If no time has been received yet, request it every 10 seconds from controller  **/
  /**  when time has been received request update every hour  **/
  if ((!bTimeReceived && (currentTime - lastRequest) > REQUEST_TIME_ON_STARTUP) ||
     (bTimeReceived && (currentTime - lastRequest) > REQUEST_TIME_PERIODICALLY)) {
       /** Request time from controller  */
      #ifdef APP_DEBUG
        Serial.println(F("Requesting time..."));
      #endif
       requestTime();
       ledMatrix.blinkRate(0);
       lastRequest = currentTime;
     }

  ledMatrix.writeDisplay();

  /**  STATE MACHINE  **/
  switch (state) {
    /** STATE_INDOOR_TEMP **/
    case STATE_INDOOR_TEMP:
      if (!once) {
      printIndoorTemperature(indoorTemperature, INSIDE_DOT);
      once = true;
      }
    
      if (once && (second(local) == 17) || (second(local) == 47)) {
        once = false;
        state = STATE_OUTDOOR_TEMP;
      }
      break;
    
    /** STATE_OUTDOOR_TEMP **/
    case STATE_OUTDOOR_TEMP:
      if (!once) {
        printOutdoorTemperature(outdoorTemperature, OUTSIDE_DOT);
        once = true;
      }
    
      if (once && (second(local) == 19) || (second(local) == 49)) {
        once = false;
        state = STATE_OUTDOOR_HUM;
      }
      break;

    /** STATE_OUTDOOR_HUM **/
    case STATE_OUTDOOR_HUM:
      if (!once) {
        printOutdoorHumidity(outdoorHumidity, OUTSIDE_DOT);
        once = true;
      }

      if (once && (second(local) == 21) || (second(local) == 51)) {
        once = false;
        state = STATE_OUTDOOR_UVI;
      }
      break;

    /** STATE_OTDOOR_UVI **/
    case STATE_OUTDOOR_UVI:
      if (!once) {
        printOutdoorUvIndex(outdoorUvIndex, OUTSIDE_DOT);
        once = true;
      }

      if (once && (second(local) == 23) || (second(local) == 53)) {
        once = false;
        state = STATE_OUTDOOR_PRESSURE;
      }
      break;

    /** STATE_OTDOOR_PRESSURE **/
    case STATE_OUTDOOR_PRESSURE:
      if (!once) {
        printOutdoorPressure(airPressure, OUTSIDE_DOT);
        once = true;
      }

      if (once && (second(local) == 25) || (second(local) == 55)) {
        once = false;
        state = STATE_CLOCK_UPDATE;
      }
      break;


    /** STATE_CLOCK_UPDATE **/
    case STATE_CLOCK_UPDATE:
      if (((second(local) >= 15 ) && (second(local) < 17)) || ((second(local) >= 45) && (second(local) < 47))) {
        state = STATE_INDOOR_TEMP;
      }
    // NOTE IT IS OK TO REMOVE THE COMMENTED CODE BELOW, IT IS NOT USED. IT WILL BE REMOVED WITH THE NEXT COMPILE ACTION **/
    // NOTE The block below has been restricted to NodeID 1 because of a timing problem witch led to that the display only update once a minute. This may be fixed.
    // NOTE it shall be investigated if theis code block can be completely removed
    // #ifdef LED_state_ID_1
    //   if (((second(local) >= 17 ) && (second(local) < 19)) || ((second(local) >= 47) && (second(local) < 49))) {
    //     state = STATE_OUTDOOR_TEMP;
    //     Serial.println(F("1 - If we see this, the code below can not be removed!!!"));
    //     }

    //   if (((second(local) >= 19 ) && (second(local) < 21)) || ((second(local) >= 49) && (second(local) < 51))) {
    //     state = STATE_OUTDOOR_HUM;
    //     Serial.println(F("2 - If we see this, the code below can not be removed!!!"));        
    //     }

    //   if (((second(local) >= 21 ) && (second(local) < 23)) || ((second(local) >= 51) && (second(local) < 53))) {
    //     state = STATE_OUTDOOR_PRESSURE;
    //     Serial.println(F("3 - If we see this, the code below can not be removed!!!"));        
    //     }        

    //   if (((second(local) >= 23 ) && (second(local) < 25)) || ((second(local) >= 53) && (second(local) < 55))) {
    //     state = STATE_CLOCK_UPDATE;
    //     Serial.println(F("4 - If we see this, the code below can not be removed!!!"));        
    //     }                
    //   #endif
    
      if (millis() - lastClockUpdate > 1000) {
        printCurrentTime(local);
        lastClockUpdate = millis();
      }
      break;
      
      /** STATE_LED_DISPLAY_SETUP **/
      case STATE_LED_DISPLAY_SETUP:
        ledMatrix.clear();
        /** Setup temperature sensors  **/
        temperatureSensorSetup();
        testDisplay();
        state = STATE_CLOCK_UPDATE;
      break;
  }

  /** SEND LOCAL CLOCK DATA TO CONTROLLER **/
  if (millis() - lastBoxTemperature > INDOOR_TEMPERATURE_FREQUENCE) {
    lastBoxTemperature = millis();

  /** READ LOCAL TEMPERATURE SENSORS TO SEND TO CONTROLLER **/
  sensors.requestTemperatures();
  float temperatureBox    = sensors.getTempCByIndex(0);
  float temperatureIndoor = sensors.getTempCByIndex(1);

  /** Query conversion time and wait until conversion completed  **/
  int16_t conversionTime = sensors.millisToWaitForConversion(sensors.getResolution());
  wait(conversionTime);

    if (temperatureBox != lastTemperatureBox) {
      lastTemperatureBox = temperatureBox;
      send(msgBoxTemp.set(temperatureBox, 1));
      send(msgIndoorTemp.set(temperatureIndoor, 1));
    }
  }

  /** RELAY DATA FROM SOURCE NODE (27 - PERGOLA) TO CLOCKS IN ClockNet **/
  #ifdef LED_state_ID_1
    if ((bRelayTempMsg) || (bRelayHumMsg) || (bRelayUviMsg) || (bRelayAirPresMsg)) {
      msgRelayToClockNodes();
    }
    #endif
}  //.. End of loop()

/**************************************************************
 *   Function: printDateTime
 * Parameters: time_t utc
 *    Returns: nothing
 *************************************************************/
#ifdef APP_DEBUG
void printDateTime(time_t utc) {
  printDate(utc);
  Serial.print(' ');
  printTime(utc);
  Serial.println();
}
#endif

/**************************************************************
 *   Function: printTime
 * Parameters: time_t utc
 *    Returns: nothing
 *************************************************************/
#ifdef APP_DEBUG
void printTime(time_t utc)
{
  printI00(hour(utc), ':');
  printI00(minute(utc), ':');
  printI00(second(utc), ' ');
}
#endif

/**************************************************************
 *   Function: printDate
 * Parameters: time_t utc
 *    Returns: nothing
 *************************************************************/
#ifdef APP_DEBUG
void printDate(time_t utc)
{
  Serial.print(year(utc));
  Serial.print('-');
  Serial.print(month(utc));
  Serial.print('-');
  printI00(day(utc), 0);
}
#endif

/**************************************************************
 *    Function: printI00
 *  Parameters: int val, char delim
 *     Returns: nothing
 * Description:  Print an integer in '00' format (with leading zero),
 *               followed by a delimiter character to Serial.
 *               Input value assumed to be between 0 and 99.
 *************************************************************/
#ifdef APP_DEBUG
void printI00(int val, char delim)
{
  if (val < 10) Serial.print('0');
    Serial.print(val);
    if (delim > 0) Serial.print(delim);
      return;
}  //.. End of printI00
#endif

/**************************************************************
 *   Function: print2digits
 * Parameters: int number
 *    Returns: nothing
 *************************************************************/
#if defined(APP_DEBUG) || defined(RTC_DEBUG)
void print2digits(int number) {
  if (number >= 0 && number < 10) {
    Serial.write('0');
  }
  Serial.print(number);
}	 //.. End of print2digits
#endif

/**************************************************************
 *   Function: showstateId()
 * Parameters: none
 *    Returns: nothing
 *************************************************************/
void showstateId() {
  int8_t digit0 = (MY_NODE_ID % 100) / 10;
  int8_t digit1 = MY_NODE_ID % 10;

  ledMatrix.clear();
  ledMatrix.writeDigitNum(0, digit0);
  ledMatrix.writeDigitNum(1, digit1);
  ledMatrix.drawColon(true);
  ledMatrix.writeDigitNum(4, state_ID);
  ledMatrix.writeDisplay();
  delay(3000);
}  //.. End of showstateId

/**************************************************************
 *   Function: rtcStatus()
 * Parameters: none
 *    Returns: nothing
 *************************************************************/
#ifdef RTC_DEBUG
void rtcStatus() {
  if (RTC.read(tm)) {
    Serial.print("Ok, Time = ");
    print2digits(tm.Hour);
    Serial.write(':');
    print2digits(tm.Minute);
    Serial.write(':');
    print2digits(tm.Second);
    Serial.print(", Date (D/M/Y) = ");
    Serial.print(tm.Day);
    Serial.write('/');
    Serial.print(tm.Month);
    Serial.write('/');
    Serial.print(tmYearToCalendar(tm.Year));
    Serial.println();
  } else {
    if (RTC.chipPresent()) {
      Serial.println("The DS1307 is stopped.  Please run the SetTime");
      Serial.println("example to initialize the time and begin running.");
      Serial.println();
    } else {
      Serial.println("DS1307 read error!  Please check the circuitry.");
      Serial.println();
    }
	}
}  //..  End of rtcStatus
#endif

/**************************************************************
 *   Function: temperatureSensorSetup()
 * Parameters: none
 *    Returns: nothing
 *************************************************************/
void temperatureSensorSetup() {
  #ifdef DS18B20_DEBUG
    Serial.println(F("Dallas Temperature sensor search.."));
  #endif
  sensors.begin();

  /**  Locate devices on the bus  **/
  #ifdef DS18B20_DEBUG
    Serial.print(F("Locating temperature devices..."));
    Serial.print(F("Found "));
    Serial.print(sensors.getDeviceCount(), DEC);
    Serial.println(F(" devices."));
  
    /** Report parasite power requirements  **/
    Serial.print(F("Parasite power is "));
    if (sensors.isParasitePowerMode())
      Serial.println(F("ON"));
    else
      Serial.println(F("OFF"));
  #endif

  if (!sensors.getAddress(inboxTemperature, 0)) Serial.println(F("Unable to find address for Device 0"));
  if (!sensors.getAddress(indoorTemperature, 1)) Serial.println(F("Unable to find address for Device 1"));

  /** Show the addresses we found on the bus  **/
  #ifdef DS18B20_DEBUG
    Serial.print(F("Device 0 Address: "));
    printAddress(inboxTemperature);
    Serial.println();
  
    Serial.print(F("Device 1 Address: "));
    printAddress(indoorTemperature);
    Serial.println();
  #endif
  ledMatrix.print(sensors.getDeviceCount(), DEC);
  ledMatrix.writeDisplay();
  delay(2000);
  ledMatrix.clear();
}  //..  End of temperatureSensorsSetup

/**************************************************************
 *   Function: printAddress
 * Parameters: none
 *    Returns: nothing
 *************************************************************/
#ifdef DS18B20_DEBUG
  void printAddress(DeviceAddress deviceAddress)
  {
    for (uint8_t i = 0; i < 8; i++)
    {
      // zero pad the address if necessary
      if (deviceAddress[i] < 16) Serial.print("0");
      Serial.print(deviceAddress[i], HEX);
    }
  }		//..* End of printAddress
#endif

/**************************************************************
 *   Function: testDisplay
 * Parameters: none
 *    Returns: nothing
 *************************************************************/
void testDisplay() {
  
    ledMatrix.writeDigitRaw(2, 0x1E);
    ledMatrix.writeDisplay();
    delay(300);   
    ledMatrix.writeDigitRaw(0, 0xFF);
    ledMatrix.writeDisplay();
    delay(300);   
    ledMatrix.writeDigitRaw(1, 0xFF);
    ledMatrix.writeDisplay();
    delay(300);   
    ledMatrix.writeDigitRaw(3, 0xFF);
    ledMatrix.writeDisplay();
    delay(300);   
    ledMatrix.writeDigitRaw(4, 0xFF);
    ledMatrix.writeDisplay();

    for (int i=15; i >= 0; i--) {
      ledMatrix.setBrightness(i);
      delay(75);
    }

    for (int i=0; i < 15; i++) {
      ledMatrix.setBrightness(i);
      delay(65);
    }    

    delay(1000);
    ledMatrix.writeDigitRaw(2, 0x0);
    ledMatrix.writeDigitRaw(0, 0x0);
    ledMatrix.writeDigitRaw(1, 0x0);
    ledMatrix.writeDigitRaw(3, 0x0);
    ledMatrix.writeDigitRaw(4, 0x0);
    ledMatrix.writeDigitNum(2, 0x00);
    ledMatrix.writeDisplay();
    ledMatrix.clear();
}  //..  End of testDisplay

/**************************************************************
 *   Function: printCurrentTime(time_t)
 * Parameters: time_t local
 *    Returns: nothing
 *************************************************************/
void printCurrentTime(time_t utc) {
  int8_t digit0 = (hour(utc) % 100) / 10;          //.. Extract the first digit from the hour
  int8_t digit1 = hour(utc) % 10;                  //.. Extract the second digit from the hour
    //.. Extract the first digit from the minute
  int8_t digit2 = (minute(utc) % 100) / 10;        //.. Extract the first digit from the minute
  int8_t digit3 = minute(utc) % 10;                //.. Extract the second digit from the minute

  /**  Print to the 7-segment display  **/
  ledMatrix.writeDigitNum(0, digit0, drawDots);    //.. Hour tenths
  ledMatrix.writeDigitNum(1, digit1, drawDots);    //.. Hour ones
  bBlinkColon = !bBlinkColon;
  ledMatrix.drawColon(bBlinkColon);
  ledMatrix.writeDigitNum(3, digit2, drawDots);    //.. Minute tenths
  ledMatrix.writeDigitNum(4, digit3, drawDots);    //.. Minute ones
  ledMatrix.writeDisplay();                        //.. Save and shopw the value on the display
}  //.. End of printCurrentTime

/**************************************************************
 *   Function: printIndoorTemp()
 * Parameters: DeviceAddress address, int dotpos
 *    Returns: nothing
 *************************************************************/
void printIndoorTemperature(DeviceAddress address, int dotpos) {
  int8_t digit1;
  int8_t digit2;
  int8_t digit3;
  float c = sensors.getTempC(address);
  
  int _c = static_cast<int>((c * 10.));
  
  ledMatrix.clear();
  if (abs(_c) > 99 ) {
    digit1 = (_c / 100) % 10;
    ledMatrix.writeDigitNum(1, digit1);
  }
    digit2 = (_c / 10 ) % 10;
    ledMatrix.writeDigitNum(3, digit2);

     digit3 = _c % 10;
     ledMatrix.writeDigitNum(4, digit3);

  ledMatrix.writeDigitRaw(2,dotpos + DECI_POINT);
  #ifdef CELSIUS_PREFIX
    ledMatrix.writeDigitRaw(0, CELSIUS_PREFIX);     //.. Print 'c/C' before temperature
  #endif
  ledMatrix.writeDisplay();
}  //.. End of printIndoorTemperature

/**************************************************************
 *   Function: printOutdoorTemperature()
 * Parameters: int temp, int dotpos, bool zero
 *    Returns: nothing
 *************************************************************/
void printOutdoorTemperature(float temp, int dotpos) {
  int8_t digit1;
  int8_t digit2;
  int8_t digit3;

   /** Check if temperature is below 0.0 degrees C **/
   bBelowZero = temp < 0.0 ? true : false;

  /** Convert float temeparature to an integer value raised with a factor the to get 1 decimal in the integer value **/
  int _temp = static_cast<int>(round((temp * 10.0)));  // Multiply the float value to get rid of the decimal
  /** if it is a negative number, convert it to positive by multiplying with -1  **/
  if (_temp < 0) _temp *= -1;

  #ifdef RECIEVE_MSG_DEBUG
    Serial.print(F("Outdoor Temperature: "));
    bBelowZero ? Serial.print("") : Serial.print(" ");
    Serial.print(temp);
    Serial.println(F(" C"));
  #endif

  ledMatrix.clear();

  if ((temp > 9.9) || (temp < -9.9)) {   // FIXME: Original code: if temp < 10.0 || 
    digit1 = (_temp / 100) % 10;
    ledMatrix.writeDigitNum(1, digit1);
  }

  digit2 = (_temp / 10 ) % 10;
  ledMatrix.writeDigitNum(3, digit2);

  digit3 = _temp % 10;
  ledMatrix.writeDigitNum(4, digit3);

  #ifdef CELSIUS_PREFIX
    ledMatrix.writeDigitRaw(0, CELSIUS_PREFIX);     //.. Print 'c'/'C' before temperature
  #endif
  if (bBelowZero) {
    if (temp > -10.0) {
      ledMatrix.writeDigitRaw(1, MINUS_SIGN);  //.. Show minus sign  (-) at digit 1 if temperature is below 0 degress C
    } else {
      ledMatrix.writeDigitRaw(0, MINUS_SIGN);  //.. Show minus (-) at digit 0  if temperature is below -10 degress C
    }
  }
  ledMatrix.writeDigitRaw(2, dotpos + DECI_POINT);
  ledMatrix.writeDisplay();
}  //.. End of printOutdoorTemperature

/**************************************************************
 *   Function: printOutdoorHumidity()
 * Parameters: int hum, int dotpos
 *    Returns: nothing
 *************************************************************/
void printOutdoorHumidity(int8_t hum, int dotpos) {
  bool highHumidity = false;   //.. Max humidity in display = 99 %RH. Humidity above are visualized by lighing the decimal dot
  #ifdef RECIEVE_MSG_DEBUG
    Serial.print(F("Outdoor Humidity: "));
    Serial.print(hum);
    Serial.println(F(" %Rh"));
  #endif
  
  if (hum > 99) {  //.. Limit humidity valy to 99 %Rh
    hum = 99;
    highHumidity = true;
  } else highHumidity = false;
  ledMatrix.clear();
  if (highHumidity) ledMatrix.writeDigitRaw(2, DECI_POINT);
  ledMatrix.print(hum);
  #ifdef HUMIDITY_PREFIX
    ledMatrix.writeDigitRaw(0, HUMIDITY_PREFIX);  //..  Print 'h'/'H' before humidity val
  #endif
  ledMatrix.writeDigitRaw(2, dotpos);
  ledMatrix.writeDisplay();
}  //..  End of printOutdoorHumidity()

/**************************************************************
 *   Function: printOutdoorUvLevel
 * Parameters: float uvi, bool zero
 *    Returns: nothing
 *************************************************************/
void printOutdoorUvIndex(float uvi, int dotpos) {
  int8_t digit1;
  int8_t digit2;
  int8_t digit3;
  int _uvi = static_cast<int>(round(uvi  * 10.));
  
  ledMatrix.clear();
  if (_uvi > 99) {
    digit1 = (_uvi / 100) % 10;
    ledMatrix.writeDigitNum(1, digit1);
  }
  digit2 = (_uvi / 10) % 10;
  ledMatrix.writeDigitNum(3, digit2);
  digit3 = _uvi % 10;
  ledMatrix.writeDigitNum(4, digit3);
  #ifdef UVI_PREFIX
    ledMatrix.writeDigitRaw(0, UVI_PREFIX);
  #endif
  ledMatrix.writeDigitRaw(2, dotpos + DECI_POINT);
  ledMatrix.writeDisplay();
  
  /** Display the current UV-Index value on NeoPixel stick **/
  int uvindex = static_cast<int>(round(uvi));   //.. transform the measured UV-Index to an integer between 0 - 16
  pixels->clear();                              //.. clear the UV-stick
  pixels->show();
  if (uvindex > 0)
  for (int i = 0; i <= uvindex-1; i++) {
    uint32_t color = pixels->Color(uvArrayDim[i][0], uvArrayDim[i][1], uvArrayDim[i][2]);
    pixels->setPixelColor(i, color);
    pixels->show();
  }
}

/**************************************************************
 *   Function: printOutdoorPressure
 * Parameters: int pressure, bool zero
 *    Returns: nothing
 *************************************************************/
  void printOutdoorPressure(float pressure, int dotpos) {
    #ifdef RECIEVE_MSG_DEBUG
      Serial.print(F("Outdoor air pressure: "));
      Serial.println(pressure);
  #endif
  int _pressure = static_cast<int>(round(pressure));

  ledMatrix.clear();
  ledMatrix.print(_pressure);
  ledMatrix.writeDigitRaw(2, dotpos);
  ledMatrix.writeDisplay();  
  }

/**************************************************************
 *   Function: msgRelayToClockNodes
 * Parameters: ---
 *    Returns: nothing
 *************************************************************/
#ifdef LED_state_ID_1
  void msgRelayToClockNodes() {
    if (bRelayTempMsg) {
      if (nodeDestTempCnt < CLOCK_NET_DEST_NODES) {
        msgRelayTemp.setDestination(CLOCK_NET_DEST_OFFSET + nodeDestTempCnt);
        send(msgRelayTemp.set(outdoorTemperature, 1));
        #ifdef RELAY_MSG_DEBUG
          Serial.print(F("Relay message temperature forwarded to node: "));
          Serial.println(CLOCK_NET_DEST_OFFSET + nodeDestTempCnt);
        #endif
        nodeDestTempCnt++;
      } else {
        nodeDestTempCnt = 0;
        bRelayTempMsg = false;
      }
    }
  
    if (bRelayHumMsg) {
      if (nodeDestHumCnt < CLOCK_NET_DEST_NODES) {
        msgRelayHum.setDestination(CLOCK_NET_DEST_OFFSET + nodeDestHumCnt);
        send(msgRelayHum.set(outdoorHumidity, 1));
        #ifdef RELAY_MSG_DEBUG
          Serial.print(F("Relay message humidity forwarded to node: "));
          Serial.println(CLOCK_NET_DEST_OFFSET + nodeDestHumCnt);
        #endif
        nodeDestHumCnt++;
      } else {
        nodeDestHumCnt = 0;
        bRelayHumMsg = false;
      }    
    }  
  
    if (bRelayUviMsg) {
      if (nodeDestUviCnt < CLOCK_NET_DEST_NODES) {
        msgRelayUvi.setDestination(CLOCK_NET_DEST_OFFSET + nodeDestUviCnt);
        send(msgRelayUvi.set(outdoorUvIndex, 1));
        #ifdef RELAY_MSG_DEBUG
          Serial.print(F("Relay message UV-index forwarded to node: "));
          Serial.println(CLOCK_NET_DEST_OFFSET + nodeDestUviCnt);
        #endif
        nodeDestUviCnt++;
      } else {
        nodeDestUviCnt = 0;
        bRelayUviMsg = false;
      }
    }

    if (bRelayAirPresMsg)  {
      if (nodeDestAirPresCnt < CLOCK_NET_DEST_NODES) {
        msgRelayAirPres.setDestination(CLOCK_NET_DEST_OFFSET + nodeDestAirPresCnt);
        send(msgRelayAirPres.set(airPressure, 1));
        #ifdef RELAY_MSG_DEBUG
          Serial.print(F("Relay message air pressure forwarded to node: "));
          Serial.println(CLOCK_NET_DEST_OFFSET + nodeDestAirPresCnt);
        #endif
        nodeDestAirPresCnt++;
      } else {
        nodeDestAirPresCnt = 0;
        bRelayAirPresMsg = false;
      }
    }      
  }
  #endif 

