import de.voidplus.leapmotion.*;
import processing.video.*;

Capture cam;

PGraphics pg;
float handX, handY;
float _handX, _handY;
float x, y;

void setup() {
  size(640, 480);
  background(0);

  cam = new Capture(this, 640, 480);
  cam.start();

  pg = createGraphics(cam.width, cam.height);

  LeapMotion_setup();
}

void draw() {
  background(0);

  if ( cam.available() ) {
    cam.read();
    cam.updatePixels();
  }

  LeapMotion_run();

  //handX = _handX;
  //handY = _handY;

  float distance = dist(_handX, _handY, handX, handY);
  float draw = map(distance, 0, 100, 0, 20);
  color c = cam.get(int(x), int(y));

  translate(handX, handY);
  pushMatrix();

  pg.beginDraw();
  pg.noFill();
  //pg.rect(0, 0, cam.width, cam.height);
  pg.strokeWeight(3);
  pg.stroke(c);
  pg.line(_handX, _handY, handX, handY);
  pg.endDraw();
  
  popMatrix();


  image(cam, 0, 0);
  image(pg, 0, 0);
}
