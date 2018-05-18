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

int value = 0;


void setup() {
  size(400,400);
  frameRate(25);
  
  oscP5 = new OscP5(this,12000);
}


void draw() {
  background( value );
}


void oscEvent(OscMessage msg) {
  println("___");
  println("Pattern: " + msg.addrPattern() );
  println("Typetag: " + msg.typetag() );
  
  value = msg.get(0).intValue();
  println("Value: " + value );
  println();
}
