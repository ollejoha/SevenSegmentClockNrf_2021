






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


