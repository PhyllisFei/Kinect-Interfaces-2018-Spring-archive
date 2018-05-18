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
  background(100);
  
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
  float dia = random(10, 200);
  int r = int(random(255));
  int g = int(random(255));
  int b = int(random(255));
  String name = "Moon"; 
  msg.add( x );
  msg.add( y );
  msg.add( dia );
  msg.add( r );
  msg.add( g );
  msg.add( b );
  msg.add( name );
  oscP5.send( msg, myRemoteLocation );
  
  noStroke();
  fill(r,g,b);
  ellipse(mouseX, mouseY, 10, 10);
}