// https://processing.org/examples/animatedsprite.html

// TODO
// Add rotate, move, etc. methods to animation class
// so each animation can be controlled independently

import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

Animation test = new Animation("../red_output/", 3, 0);
Animation red = new Animation("../red_output/", 3, 0);
Animation blue = new Animation("../blue_output/", 3, 1);
Animation green = new Animation("../green_output/", 3, 2);
Animation yellow = new Animation("../yellow_output/", 3, 3);
String[] colors = new String[]{"red", "blue", "green", "yellow"};
Animation[] blocks = new Animation[]{red, blue, green, yellow};
Animation currentSprite;

float R1 = 4700; // known resistor
float Vin = 5; // input voltage on arduino board
float TOLERANCE = 0.05; // tolerance value used in resistance calculations
int CALIBRATION = 0; // calibrates the raw analog input to the proper resistance
int pin = 1; // analog pin

int w = 1000; // canvas width
int h = 500; // canvas height

boolean north = false;
boolean south = false;
boolean west = false;
boolean east = false;

int potVal; // potentiometer value
int sliderVal; // slider value

// pin assignments
// TODO: go back through and assign pins to NESW for joystick
int northPin = 8; // the wire that causes the sprite to move north
int eastPin = 10;
int southPin = 2;
int westPin = 4;
int[] joystickPins = {northPin, eastPin, southPin, westPin};
int[] joystickKeys = {38, 39, 40, 37};

int potentiometerPin = 0;
int sliderPin = 3;

// play/pause button
int pauseButtonPin = 6;
int pauseLedPin = 9; // the number of the pause LED pin
int pauseButtonState = 0; // variable for reading pushbutton status
boolean pause; // should display a still of all animations
int timesPressed = 0;

// record button
int recordButtonPin = 15;
int recordLedPin = 14;
int recordButtonState = 1;
int numTimesRecordPressed = 0;

int maxSliderVal = 1023;
int scale = 1;
boolean editable;

import java.io.File;

final static byte SPX = 5, SPY = 5; // speed

void setup() {  
  noSmooth(); 
  //fullScreen();
  arduino = new Arduino(this, "COM5", 57600);
  // Set the Arduino digital pins as inputs.
  for (int i = 0; i <= 53; i++) {
    arduino.pinMode(i, Arduino.INPUT);
  }
  
  arduino.pinMode(pauseLedPin, Arduino.OUTPUT);
  arduino.pinMode(pauseButtonPin, Arduino.INPUT_PULLUP);    
  potVal = arduino.analogRead(potentiometerPin);
  //println("potval: " + potVal);
  sliderVal = arduino.analogRead(sliderPin);
  scale = sliderVal;
  for (int i=0; i<4; i++) {
    arduino.digitalWrite(joystickPins[i], Arduino.HIGH);
  }
  size(1000,860);
  background(255);
  //frameRate(6);
  Animation currentSprite = test;
  editable = false;
 
}

void draw() { 
  background(255);
  
    println("A" + 12 + ": " + getColor(12));

/***************IF BLOCK IN EDIT SLOT********************/
  if (getColor(12) < 4){ // edit slot is analog pin 12
    Animation currentSprite = blocks[getColor(12)];
    println("currentSprite: " + currentSprite);
    //currentSprite.scaleObject();
    
/******************************RECORD*************************/
    recordButtonState = arduino.analogRead(recordButtonPin);
    println("record button state: " + recordButtonState);
    if (recordButtonState == 0){
      println("Record button was pressed.");
      arduino.analogWrite(recordLedPin, Arduino.HIGH);
      currentSprite.setHasRecord(true);
      currentSprite.recordToBlock();
    }
    
    
/**********************END RECORD STATE***********************/
/*************************************************************/


/*************************************************************/
/**************************EDIT*******************************/

/**********JOYSTICK************/// for translation
    for (int i = 0; i < 4; i++) {
      //println("joystick analog read: " + arduino.analogRead(joystickPins[i]));
      if (arduino.analogRead(joystickPins[i]) == 0) {
        currentSprite.setDirection(joystickKeys[i], true);
        //println("in here for " + joystickPins[i]);
      }
      currentSprite.moveObject();
      currentSprite.setDirection(joystickKeys[i], false);
      //println("xpos: " + xpos + " / ypos: " + ypos);
      currentSprite.display(xpos, ypos);
    }

/*******POTENTIOMETER*********/// for rotation and scale    
    //if (arduino.analogRead(potentiometerPin) > potVal) {
    //  potVal = arduino.analogRead(potentiometerPin);
    //  //println("potVal: " + potVal);
    //  currentSprite.setAngle('Q'); // sprite rotates left
    //}
    //if (arduino.analogRead(potentiometerPin) < potVal) {
    //  potVal = arduino.analogRead(potentiometerPin);
    //  //println("potVal: " + potVal);
    //  currentSprite.setAngle('W'); // sprite rotates right
    //} 
    if (arduino.analogRead(potentiometerPin) >= 0) {
      potVal = arduino.analogRead(potentiometerPin);
      println("potval: " + potVal);
      //println("potVal: " + potVal);
      currentSprite.setAngle(potVal); // sprite rotates right
    } 
    if (arduino.analogRead(sliderPin) != sliderVal) {
        sliderVal = maxSliderVal - arduino.analogRead(sliderPin);
        //println("slider val = " + sliderVal);
        if (sliderVal > 0) {
          currentSprite.setScale(sliderVal + 1);
        }
    }
    
    //currentSprite.confineToEdges();
    //currentSprite.moveObject();
    currentSprite.display(xpos, ypos);
    currentSprite.scaleObject();
    currentSprite.rotateObject();
    //currentSprite.display(xpos, ypos);
  } 
/***********************END EDIT STATE************************/
/*************************************************************/

/*************************************************************/
/***********************DISPLAY STATE*************************/
    
    //// if editable is not true
    else {
      for (int i = 1; i <12; i++){ // for each edit slot
        if (getColor(i) < 4){  // if the color is valid
          Animation currentSprite = blocks[getColor(i)];
          if (currentSprite.hasRecord == true){
            currentSprite.display(currentSprite.getXpos(), currentSprite.getYpos());  
          } else {
            println("Block has no animation on it.");
          }
        }
      }
    
    
    //// PAUSE/PLAY BUTTON
    //pauseButtonState = arduino.analogRead(pauseButtonPin);
    
    //if (pauseButtonState < 1023) {
    //  timesPressed++;
    //}
    
    //if (timesPressed%2 == 1) {
    //  arduino.analogWrite(pauseLedPin, Arduino.HIGH);
    //  pause = true;
    //  // println("button is on");
    //} if (timesPressed%2 == 0) {
    //  pause = false;
    //}
   
    }
  
  
  //delay(1000);
}

float calculateResistance(int pin){
    float rawValue = arduino.analogRead(pin);
    float Vout = (rawValue - CALIBRATION) / 1024 * Vin; // translating raw value into Vout (change of scale from 0-1024 to 0-5
    float R2 = (Vin / Vout - 1) * R1;
    //println(R2);
    return R2;
    //Serial.println("resistance calculator working!");
}

float lowResistance(float ledResistor){
  return ledResistor - (ledResistor * TOLERANCE);
}

float highResistance(float ledResistor){
  return ledResistor + (ledResistor * TOLERANCE);
}


// Gets color on a specific pin
int getColor(int pin){
    float checkResistance = calculateResistance(pin);
    if ((900 <= checkResistance) && (checkResistance <= 1400)){
      println("Blue");
      return 1;
    } if ((2000 <= checkResistance) && (checkResistance <= 2900)){
      println("Green");
      return 2;
    } if ((6700 <= checkResistance) && (checkResistance <= 9200)){
      println("Yellow");
      return 3;
    } if ((9900 <= checkResistance) && (checkResistance <= 11500)){
      println("Red");
      return 0;
    }
  return 4;
}


void keyPressed() {
  int k = keyCode;

  currentSprite.setDirection(k, true);
  currentSprite.setAngle(k);
  currentSprite.setScale(k);
}

void keyReleased() {
  currentSprite.setDirection(keyCode, false);
}
