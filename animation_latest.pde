//// Class for animating a sequence of GIFs
//float xpos;
//float ypos;
//float centerX = 150; // this should change relative to scale... how to rotate around the center?
//float centerY = 150; // this should change relative to scale
//float angle;

//class Animation {
//  PImage[] images;
//  int imageCount;
//  int frame;
  
//  Animation(String imagePrefix, int count) {
//    imageCount = count;
//    images = new PImage[imageCount];

//    for (int i = 0; i < imageCount; i++) {
//      // Use nf() to number format 'i' into four digits
//      String filename = imagePrefix + i + ".png";
//      images[i] = loadImage(filename);
//    }
//  }

//  void display(float xpos, float ypos) {
//    frame = (frame+1) % imageCount;
    
//    if (pause) {
//      //println("trying to pause");
//      image(images[0], xpos, ypos);
//    } else {
//      image(images[frame], xpos, ypos);
//    }
//  }
  
//  int getWidth() {
//    return images[0].width;
//  }

//  void setDirection(int k, boolean decision) {
//    if (k == 38) {
//      north = decision;
//      println("going north");
//    } else if (k == 40) {
//      south = decision;
//      println("going south");
//    } else if (k == 37) {
//      west = decision;
//      println("going west");
//    } else if (k == 39) {
//      east = decision;
//      println("going east");
//    }
//  }
  
//  void confineToEdges() {
//    // needs translate center, constrain, translate center back
//    xpos = constrain(xpos, 0, w);
//    ypos = constrain(ypos, 0, h);
//  }
  
//  void moveObject() {
    
//    xpos += (east? SPX : 0) - (west? SPX : 0);
//    ypos += (south? SPY : 0) - (north? SPY : 0);
    
//    ////println("xpos: " + xpos + " / ypos: " + ypos);
//  }
  
//  void setAngle(int k) {
//    // if potentiometer value increases, increase angle
//    // if potentiometer value decreases, decrease angle
//    // k is input from potentiometer or keyboard input
    
//    if (k == 'Q') {
//      angle -= radians(20); // change the int in radians() to rotate slower/faster
//    } if (k == 'W') {
//      angle += radians(20);
//    }
//  }
  
//  void rotateObject() {
//    // needs translate center, constrain, translate center back
//    translate(xpos+centerX, ypos+centerY);
    
//    rotate(angle);
//    translate(xpos-centerX, ypos-centerY);
//  }
  
//  void setScale(int k) {
//    scale = k;
//  }
  
//  void scaleObject() {
//    //println("scale is: " + scale);
    
//    if (scale > 0) {
//      for (int i=0; i<images.length; i++) {
//          images[i].resize(scale, 0);
//      }
//    }
//  }
//}
