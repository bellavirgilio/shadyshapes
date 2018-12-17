//// https://processing.org/examples/animatedsprite.html

//// TODO
//// Add rotate, move, etc. methods to animation class
//// so each animation can be controlled independently

//import processing.serial.*;

//import cc.arduino.*;

//Arduino arduino;

//Animation animation1, animation2;

//int w = 1000; // canvas width
//int h = 500; // canvas height

//// Booleans to test whether BLOCKS have animations on them
//boolean red_rec = false;
//boolean blue_rec = false;
//boolean green_rec = false;
//boolean yellow_rec = false;

//// This should be set to true if something is in the editing slot
//boolean edit = false;

//final static byte SPX = 20, SPY = 20; // speed

//void setup() {  
//  //size(640,360);
//  background(0, 0, 0);
//  frameRate(30);
//  //animation1 = new Animation("../green_output/", 3);
//}

//void draw() { 
//   background(0, 0, 0);
//   if (keyCode == 'G') {
//     println("Recording on GREEN block");
//     record("GREEN");
//     green_rec = true;
//   }
//   if (keyCode == 'R') {
//     println("Recording on RED block");
//     record("RED");
//     blue_rec = true;
//   }
//   if (keyCode == 'B') {
//     println("Recording on BLUE block");
//     record("BLUE");
//     red_rec = true;
//   }
//   if (keyCode == 'Y') {
//     println("Recording on RED block");
//     record("YELLOW");
//     green_rec = true;
//   }
//}
