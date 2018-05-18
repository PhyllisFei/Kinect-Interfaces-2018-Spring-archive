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
NetAddress myRemoteLocation;


void setup() {
  size(400,400);
  frameRate(25);
  
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
}


void draw() {
  //
}


void mousePressed() {
  OscMessage msg = new OscMessage("/test");
   
  // let's send a random value in the color range
  int w = int( random(255) );
  msg.add( w );
  oscP5.send( msg, myRemoteLocation );
  
  background(w);
}
