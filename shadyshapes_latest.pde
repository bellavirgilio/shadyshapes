//// https://processing.org/examples/animatedsprite.html

//// TODO
//// Make constraints responsive to scale
//// known bugs: sprite rotates a lot on its own. won't happen when potentiometer
//// is plugged in

//import processing.serial.*;

//import cc.arduino.*;

//Arduino arduino;
//boolean keyboard = false; // boolean to switch to keyboard input

//Animation animation1, animation2, currentSprite;

//int w = 640; // canvas width
//int h = 360; // canvas height

//boolean north = false;
//boolean south = false;
//boolean west = false;
//boolean east = false;

//int potVal; // potentiometer value
//int sliderVal; // slider value

//// pin assignments
//// TODO: go back through and assign pins to NESW for joystick
//int northPin = 8; // the wire that causes the sprite to move north
//int eastPin = 10;
//int southPin = 2;
//int westPin = 4;
//int[] joystickPins = {northPin, eastPin, southPin, westPin};
//int[] joystickKeys = {38, 39, 40, 37};

//int potentiometerPin = 0;
//int sliderPin = 3;

//// play/pause button
//int pauseButtonPin = 6;
//int pauseLedPin = 9; // the number of the pause LED pin
//int pauseButtonState = 0; // variable for reading pushbutton status
//boolean pause; // should display a still of all animations
//int timesPressed = 0;

//// record button
//int recordButtonPin = 15;
//int recordLedPin = 14;
//int recordButtonState = 0;
//int numTimesRecordPressed = 0;

//int maxSliderVal = 1023;
//int scale;

//final static byte SPX = 2, SPY = 2; // speed

//void setup() {
//  noSmooth();
  
//  fullScreen();
  
//  if (!keyboard) {
//    arduino = new Arduino(this, "/dev/cu.usbmodem144101", 57600);
  
//    // Set the Arduino digital pins as inputs.
  
//    for (int i = 0; i <= 53; i++) {
//      arduino.pinMode(i, Arduino.INPUT);
//    }
    
//    arduino.pinMode(pauseLedPin, Arduino.OUTPUT);
//    arduino.pinMode(pauseButtonPin, Arduino.INPUT_PULLUP);
//    arduino.pinMode(northPin, Arduino.INPUT_PULLUP);
//    arduino.pinMode(northPin, Arduino.INPUT_PULLUP);
//    arduino.pinMode(northPin, Arduino.INPUT_PULLUP);
//    arduino.pinMode(northPin, Arduino.INPUT_PULLUP);
    
//    potVal = arduino.analogRead(potentiometerPin);
//    //println("potval: " + potVal);
//    sliderVal = arduino.analogRead(sliderPin);
//    scale = sliderVal;
//    for (int i=0; i<4; i++) {
//      arduino.digitalWrite(joystickPins[i], Arduino.HIGH);
//    }
//  } else {
//     // if in keyboard mode, these values default to 0
//      potVal = 0;
//      sliderVal = 0;
//  }
  
//  //size(640, 360);
//  background(255, 204, 0);
//  frameRate(6);
//  animation1 = new Animation("bird", 7);
//  currentSprite = animation1;
//  currentSprite.scaleObject();
//  //currentSprite.rotateObject();
//  //animation2 = new Animation("PT_Teddy_", 60);
//}

//void draw() { 
//    // Display the sprite at the position xpos, ypos
//    background(153, 153, 0);


//    // analog
//    if (!keyboard) {
//      for (int i = 0; i < 4; i++) {
//        //println("joystick analog read: " + arduino.analogRead(joystickPins[i]));
//        if (arduino.analogRead(joystickPins[i]) == 0) {
//          currentSprite.setDirection(joystickKeys[i], true);
//          //println("in here for " + joystickPins[i]);
//        }
//        currentSprite.moveObject();
//        currentSprite.setDirection(joystickKeys[i], false);
//      }
//    }
        
//    // for potentiometer input for rotation and scale
      
//    //if (!keyboard) {
//    //  if (arduino.analogRead(potentiometerPin) > potVal) {
//    //    potVal = arduino.analogRead(potentiometerPin);
//    //    //println("potVal: " + potVal);
//    //    currentSprite.setAngle('Q'); // sprite rotates left
//    //  }
//    //  if (arduino.analogRead(potentiometerPin) < potVal) {
//    //    potVal = arduino.analogRead(potentiometerPin);
//    //    //println("potVal: " + potVal);
//    //    //currentSprite.setAngle('W'); // sprite rotates right
//    //  } 
//    //if (arduino.analogRead(sliderPin) != sliderVal) {
//    //    sliderVal = maxSliderVal - arduino.analogRead(sliderPin);
//    //    //println("slider val = " + sliderVal);
//    //    if (sliderVal > 0) {
//    //      currentSprite.setScale(sliderVal);
//    //    }
//    //}
//    //}
    
//    pauseButtonState = arduino.analogRead(pauseButtonPin);
    
//    if (pauseButtonState < 1023) {
//      timesPressed++;
//    }
    
//    //println("button state: " + pauseButtonState);
//    if (timesPressed%2 == 1) {
//      arduino.analogWrite(pauseLedPin, Arduino.HIGH);
//      pause = true;
//      // println("button is on");
//    } if (timesPressed%2 == 0) {
//      pause = false;
//    }
    
//    recordButtonState = arduino.analogRead(recordButtonPin);
//    //println("record button state: " + recordButtonState);
    
//    if (recordButtonState == 0) {
//      arduino.analogWrite(recordLedPin, Arduino.HIGH);
//      numTimesRecordPressed++;
//      //record();
//    }
    
//    //println("num times record pressed: " + numTimesRecordPressed);
   
//    //currentSprite.confineToEdges();
//    //currentSprite.moveObject();
//    currentSprite.scaleObject();
//    currentSprite.rotateObject();
//    currentSprite.display(xpos-animation1.getWidth()/2, ypos);
//}

//void keyPressed() {
//  int k = keyCode;

//  currentSprite.setDirection(k, true);
//  currentSprite.setAngle(k);
//  currentSprite.setScale(k);
//}

//void keyReleased() {
//  currentSprite.setDirection(keyCode, false);
//}
