import de.voidplus.leapmotion.*;
import processing.video.*;

Capture cam;

PGraphics pg;
boolean handR;
float handX, handY;
float phandX, phandY;

ArrayList<Circle> circles = new ArrayList<Circle>();


void setup() {
  size(640, 480, P3D);
  noStroke();

  cam = new Capture(this, 640, 480);
  cam.start();

  pg = createGraphics(cam.width, cam.height);

  LeapMotion_setup();
}

void draw() {
  background(0);

  // show user in webcam
  if ( cam.available() ) {
    cam.read();
    cam.updatePixels(); // ***
  }

  // draw ellipse trail on user
  LeapMotion_run();

  PImage camImg = cam.copy();
  circles.add( new Circle( handX, handY, random(30), camImg) );
  circles.add( new Circle( handX, handY, random(30), camImg) );

  pg.beginDraw();
  // update & draw circles
  for (int i=0; i<circles.size(); i++) {
    circles.get(i).update();
    circles.get(i).displayIn( pg );
  }
  pg.endDraw();

  // remove the circles whose alpha are less than 0
  for (int i=circles.size()-1; i>=0; i--) {
    if (circles.get(i).alpha <= 0) {
      circles.remove(i);
    }
  }



  image(pg, 0, 0);
  image(cam, 0, 0, cam.width * 0.2, cam.height * 0.2);
}


class Circle {
  float x, y;
  float size;
  color c;
  int alpha;
  float speed;
  float directionX, directionY;

  Circle(float _x, float _y, float _size, PImage _cam) {
    x = _x;
    y = _y;
    size = _size;
    //int x = int (random (handX, handY) );
    //int y = int (random (handX, handY) );

    // right hand to draw face; left hand to erase
    
    if (handR == true) {
      c = _cam.get(int(x), int(y));
    } else {
      c = (0); 
    }
    
    alpha = 255;
    directionX = random(-1, 1);
    directionY = random(-1, 1);
    speed = 0.3;
  }

  void update() {
    x = x + directionX*speed;
    y = y + directionY*speed;
    alpha -= 1.5;
    speed *= 1.02;
  }
  void display() {
    pushStyle();
    fill(c, 105);
    noStroke();
    ellipse(x, y, size, size);
    popStyle();
  }
  void displayIn( PGraphics p ) {
    p.pushStyle();
    p.fill(c, 105);
    p.noStroke();
    p.ellipse(x, y, size, size);
    p.popStyle();
  }
}