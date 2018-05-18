// IMA NYU Shanghai
// Kinetic Interfaces
// MOQN
// Apr 19 2018


import oscP5.*;
import netP5.*;


OscP5 oscP5;

PVector[] joints = new PVector[26]; 


void setup() {
  size(1920, 1080);
  noStroke();
  textAlign(CENTER);
  
  // initialize the PVectors
  for (int i = 0; i < joints.length; i++) {
    joints[i] = new PVector();
  }

  oscP5 = new OscP5(this, 12000);
}


void draw() {
  background(100);
  
  noStroke();
  fill(255);
  for (int i = 0; i < joints.length; i++) {
    ellipse(joints[i].x, joints[i].y, 20, 20);
  }
  
  fill(255);
  text(frameRate, 10, 20);
}


void oscEvent(OscMessage msg) {
  println("___");
  println("Pattern: " + msg.addrPattern() );
  println("Typetag: " + msg.typetag() );
  println("Length: " + msg.typetag().length() );

  int total = msg.typetag().length();
  if (total == 78) {
    for (int i = 0; i < joints.length; i++) {
      int msgIndex = i*3;
      joints[i].x = msg.get(msgIndex + 0).floatValue();
      joints[i].y = msg.get(msgIndex + 1).floatValue();
      joints[i].z = msg.get(msgIndex + 2).floatValue();
    }
  }
}