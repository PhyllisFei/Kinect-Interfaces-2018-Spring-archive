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

ArrayList<Circle> circles = new ArrayList<Circle>(); 


void setup() {
  size(800, 500);
  noStroke();
  textAlign(CENTER);

  oscP5 = new OscP5(this, 12000);
}


void draw() {
  background(100);

  for (int i=0; i<circles.size(); i++) {
    Circle c = circles.get(i);
    c.update();
    c.display();
  }

  for (int i=circles.size()-1; i>=0; i--) {
    Circle c = circles.get(i);
    if (c.isDone) {
      circles.remove(i);
    }
  }
}


void oscEvent(OscMessage msg) {
  println("___");
  println("Pattern: " + msg.addrPattern() );
  println("Typetag: " + msg.typetag() );
  println();

  if ( msg.typetag().equals("fffiiis") ) {
    float x = map(msg.get(0).floatValue(), 0, 1, 0, width);
    float y = map(msg.get(1).floatValue(), 0, 1, 0, height);
    float dia = msg.get(2).floatValue();
    int r = msg.get(3).intValue();
    int g = msg.get(4).intValue();
    int b = msg.get(5).intValue();
    String name = msg.get(6).stringValue();

    circles.add( new Circle(x, y, dia, r, g, b, name) );
  } else {
    println("no");
  }
}
