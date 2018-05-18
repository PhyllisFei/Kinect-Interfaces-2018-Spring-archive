import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddress myRemoteLocation;


void setup() {
  size(1920, 1080, P3D);
  
  oscP5 = new OscP5(this,12000);
  String ipAddress = "127.0.0.1"; // localHost
  myRemoteLocation = new NetAddress( ipAddress, 12000 );
  
  setupKinect();
}


void draw() {
  background(0);

  updateKinect();
  
  //
  
  fill(255, 0, 0);
  text(frameRate, 50, 50);
}
