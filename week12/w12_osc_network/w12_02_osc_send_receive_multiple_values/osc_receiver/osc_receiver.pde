// IMA NYU Shanghai
// Kinetic Interfaces
// MOQN
// Apr 19 2018

/**
 * based on oscP5sendreceive by andreas schlegel
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 

import oscP5.*;
import netP5.*;


OscP5 oscP5;

int x, y;
float xValue = 0;
float yValue = 0;


void setup() {
  size(800,500);
  
  oscP5 = new OscP5(this,12000);
}


void draw() {
  int x = (int)map(xValue, 0, 1, 0, width);
  int y = (int)map(yValue, 0, 1, 0, height);
  ellipse(x, y, 10, 10);
}


void oscEvent(OscMessage msg) {
  println("___");
  println("Pattern: " + msg.addrPattern() );
  println("Typetag: " + msg.typetag() );
  
  xValue = msg.get(0).floatValue();
  yValue = msg.get(1).floatValue();
  println("x: " + xValue );
  println("y: " + yValue );
  println();
}
