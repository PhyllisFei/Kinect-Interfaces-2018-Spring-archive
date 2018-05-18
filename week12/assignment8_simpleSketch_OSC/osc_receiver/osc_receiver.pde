import oscP5.*;
import netP5.*;

OscP5 oscP5;

int x, y;
float xValue = 0;
float yValue = 0;

void setup() {
  size(400, 400);
  background(0, 150);
  noStroke();

  oscP5 = new OscP5(this, 12000);
}

void draw() {
  int x = (int)map(xValue, 0, 1, 0, width);
  int y = (int)map(yValue, 0, 1, 0, height);

  fill(random(255), random(255), random(255), 100);

  ellipse(x, y, random(5, 25), random(5, 25));
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
