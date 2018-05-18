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
  
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
}


void draw() {
  //
}


void mousePressed() {
  OscMessage msg = new OscMessage("/test");
   
  // let's send mouseX&Y positions
  float x = map(mouseX, 0, width, 0, 1);
  float y = map(mouseY, 0, height, 0, 1);
  msg.add( x );
  msg.add( y );
  oscP5.send( msg, myRemoteLocation );
  
  ellipse(mouseX, mouseY, 10, 10);
}
