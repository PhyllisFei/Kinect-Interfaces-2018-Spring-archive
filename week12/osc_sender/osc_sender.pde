import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400, 400);
  oscP5 = new OscP5(this, 12000);

  String ipAddress = "127.0.0.1";
  myRemoteLocation = new NetAddress(ipAddress, 12000);
}

void draw() {
  //
}

void mousePressed() {
  OscMessage myMessage = new OscMessage("/phyllis");

  myMessage.add(5);
  myMessage.add(10);
  myMessage.add(0.5);
  myMessage.add("HI!");
  
  oscP5.send(myMessage, myRemoteLocation);
}
