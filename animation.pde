// Class for animating a sequence of GIFs
float xpos;
float ypos;
float centerX = 150; // this should change relative to scale... how to rotate around the center?
float centerY = 150; // this should change relative to scale
float angle;

class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  int anim_color; // 0 is RED, 1 is BLUE, 2 is GREEN, 3 is YELLOW
  boolean hasRecord;
  String imagePrefix;
  
  Animation(String imagePrefix, int count, int anim_color) {
    this.imagePrefix = imagePrefix;
    imageCount = count;
    images = new PImage[imageCount];
    this.anim_color = anim_color;
    hasRecord = false;

    //for (int i = 0; i < imageCount; i++) {
    //  // Use nf() to number format 'i' into four digits
    //  String filename = imagePrefix + i + ".png";
    //  images[i] = loadImage(filename);
    //}
  }

  void display(float xpos, float ypos) {
    for (int i = 0; i < this.imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = this.imagePrefix + i + ".png";
      this.images[i] = loadImage(filename);
      println("looping : " + i);
      if (scale > 0) {
        images[i].resize(scale,0);
      }
    }
    frame = (frame+1) % this.imageCount;
    //if (pause) {
    //  println("trying to pause");
    //  image(images[0], xpos, ypos);
    //} else {
      image(images[frame], xpos, ypos);
    //}
  }
  
  void recordToBlock(){
    println("Gets to recordOnBlock.");
    record(colors[anim_color]);
  }
    
// True if animation has been recorded to this block
// False if not
  void setHasRecord(boolean setting){
    this.hasRecord = setting;
  }

// Getter for hasRecord value
  boolean getHasRecord(){
    return hasRecord;
  }
  
  int getWidth() {
    //return images[0].width
    return 480;
  }
  
  void setDirection(int k, boolean decision) {
    if (k == 38) {
      north = decision;
      //println("going north");
    } else if (k == 40) {
      south = decision;
      //println("going south");
    } else if (k == 37) {
      west = decision;
      //println("going west");
    } else if (k == 39) {
      east = decision;
      //println("going east");
    }
  }
  
  void confineToEdges() {
    // needs translate center, constrain, translate center back
    xpos = constrain(xpos, 0, w);
    ypos = constrain(ypos, 0, h);
  }
  
  void moveObject() {
    
    xpos += (east? SPX : 0) - (west? SPX : 0);
    ypos += (south? SPY : 0) - (north? SPY : 0);
    
    ////println("xpos: " + xpos + " / ypos: " + ypos);
  }
  
  void setAngle(int k) {
    // if potentiometer value increases, increase angle
    // if potentiometer value decreases, decrease angle
    // k is input from potentiometer or keyboard input
    
    if (k == 'Q') {
      angle -= radians(20); // change the int in radians() to rotate slower/faster
    } if (k == 'W') {
      angle += radians(20);
    } else {
      angle = radians(k/360);
    }
  }
  
  void rotateObject() {
    // needs translate center, constrain, translate center back
    translate(xpos+centerX, ypos+centerY);
    
    rotate(angle);
    translate(xpos-centerX, ypos-centerY);
  }
  
  void setScale(int k) {
    scale = k;
  }
  
  void scaleObject() {
    //println("scale is: " + scale);
    
    
    if (scale > 0) {
      for (int i=0; i<images.length; i++) {
        println("*********************8in the resize loop");  
        images[i].resize(scale, 0);
      }
    }
  }
  
  float getXpos() {
    return xpos;
  }
  
  float getYpos() {
     return ypos; 
  }
  
  String toString(){
    return Integer.toString(anim_color);
  
  }
}
