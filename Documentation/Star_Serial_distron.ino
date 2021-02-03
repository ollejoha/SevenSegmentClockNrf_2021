






void receive(const MyMessage &message) {
	if (message.isAck()) {
		Serial.pritln(F("GW Ack"))
	}
	switch (message.sender) {
	
    #if defined(LED_state_ID_1)
			case 27:  //.. Recieve data from Pergola node  
				if (message.type == V_TEMP) {
				
				}
			
				if (message.type == V_HUM) {
				
				}
				break;
	
			case 31:  //.. Recieve data from WeatherStation node
				if (message.type == V_PRESSURE) {
				
				}
			
				if (message.type == V_UV) {
				
				}
				break;
		
			case 5:  //.. Recieve data from Frontyard node
				if (message.type == V_LEVEL) {
				
				}
			
				if (messahe.type == V_UV) {
				
				}
				break;
			
	#elif defined(_LED_state_ID_2)
			case 95:  //.. Recieve data from ClockNodeId 1
	#elif defined(_LED_state_ID_3)
			case 96:  //.. Recieve data from ClockNodeId 2
	#elif defined(_LED_state_ID_4)		
			case 97;  //.. Recieve data from ClockNodeId 3
	#elif defined(_LED_state_ID_5)		
				switch (message.type) {
					case V_TEMP:
						break;
						
					case V_HUM:
						break;
						
					case V_UV:
					  break;
						
					case V_PRESSURE:
					  break;
						
					case V_LEVEL:
					  break;
				}
				break;
	}
	
	#else
		#error "Unsupported nodes selected"
	#endif	
}

===============================================================================================================
===============================================================================================================


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
    #ifdef defined(LED_state_ID_1)
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

    #elseif defined(LED_state_ID_2)
      case 95:  //.. Patio node. Relay node
		#elsif defined(LED_state_ID_3 && !STAR_DISTRIBUTION)
		  case 96:
		#elsif defined(LED_state_ID_4 && !STAR_DISTRIBUTION)
		  case 97:			
		#elsif defined(LED_state_ID_5 && !STAR_DISTRIBUTION)
		  case 98:			
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
  #endif  //.. End of START distrubution
  }
}


===============================================================================================================
===============================================================================================================

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


