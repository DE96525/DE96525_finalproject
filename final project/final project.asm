#include <Servo.h>
#include <IRremote.h> 	
//Automatic Remote Door Lock system//

int receive = 3;
IRrecv irrecv(receive);
decode_results results;

const int RED = 10;
const int GREEN = 11;
const int piezo = 12;

Servo motor;


void setup() { 
  Serial.begin(9600); 
  irrecv.enableIRIn();
  pinMode(10,OUTPUT);	// Set redLED - pin 10 as an output
  pinMode(11,OUTPUT);	// Set greenLED - pin 11 as an output
  pinMode(12, OUTPUT);	// Set piezo - pin 9 as an output
  motor.attach(13);
}

void loop() {
	if (irrecv.decode(&results)){
        	
      switch (results.value){

      	case 0xFD50AF:				 	// door locks when UP button pressed
      		motor.write(-180);
        	digitalWrite(10, HIGH); 	// set pin 10 to high voltage, turning LED on
 		 	digitalWrite(11, LOW);   	// set pin 11 to low voltage, or zero. LED off.
 		 	digitalWrite(12, HIGH);		// set pin 12 to high voltage, turn on piezo so
        	delay(1000);				// delay 1 sec
        	digitalWrite(12, LOW);		// set pin 12 to low voltage, turn off piezo 
        	delay(1000);
        	break;
      	case 0xFD10EF:					// door unlocks when DOWN button pressed
			motor.write(180);
        	digitalWrite(11, HIGH);  	// set pin 11 to high voltage, turning LED on
 		 	digitalWrite(10, LOW);   	// set pin 10 to low voltage, or zero. LED off.
 		 	digitalWrite(12, HIGH);
        	delay(1000);
        	digitalWrite(12, LOW);
        	delay(1000);
        	break; 
      	default:
        	break;      
    }    
    irrecv.resume(); 
  }
  delay(100);
}