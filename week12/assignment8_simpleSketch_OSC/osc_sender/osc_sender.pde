import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400, 400);
  background(0, 150);
  noStroke();

  oscP5 = new OscP5(this, 12000);

  String ipAddress = "127.0.0.1";
  myRemoteLocation = new NetAddress(ipAddress, 12000);
}

void draw() {
  //
}

void mouseMoved() {
  OscMessage myMessage = new OscMessage("/phyllis");

  float x = map(mouseX, 0, width, 0, 1);
  float y = map(mouseY, 0, height, 0, 1);

  myMessage.add( x );
  myMessage.add( y );
  oscP5.send( myMessage, myRemoteLocation );

  fill(random(255), random(255), random(255), 100);

  ellipse(mouseX, mouseY, random(5, 25), random(5, 25));
}
