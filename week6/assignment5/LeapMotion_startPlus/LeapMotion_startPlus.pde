import de.voidplus.leapmotion.*;
import processing.video.*;

Capture cam;

PGraphics pg;
PImage imgU;
float handX, handY;
float phandX, phandY;

ArrayList<Circle> circles = new ArrayList<Circle>();


void setup() {
  size(640, 480, P3D);
  noStroke();

  cam = new Capture(this, 640, 480);
  cam.start();

  pg = createGraphics(cam.width, cam.height);
  imgU = createImage (cam.width, cam.height, ARGB);

  LeapMotion_setup();
}

void draw() {
  // show user in webcam
  if ( cam.available() ) {
    cam.read();
    cam.loadPixels();
    imgU.loadPixels();
  }

  int h = cam.height;
  int w = cam.width;
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      int i = x + y*w;

      float r = red(cam.pixels[i]);
      float g = green(cam.pixels[i]);
      float b = blue(cam.pixels[i]);

      imgU.pixels[i] = color(r, g, b);
    }
  }
  imgU.updatePixels();
  image(imgU, 0, 0);

  // draw ellipse trail on user
  LeapMotion_run();

  pg.beginDraw();

  circles.add( new Circle( handX, handY, random(30)) );
  circles.add( new Circle( handX, handY, random(30)) );

  // update & draw circles
  for (int i=0; i<circles.size(); i++) {
    circles.get(i).update();
    circles.get(i).display();
  }
  // remove the circles whose alpha are less than 0
  for (int i=circles.size()-1; i>=0; i--) {
    if (circles.get(i).alpha <= 0) {
      circles.remove(i);
    }
  }
  pg.endDraw();

  image(pg, 0, 0);
}


class Circle {
  float x, y;
  float size;
  color c;
  int alpha;
  float speed;
  float directionX, directionY;

  Circle(float _x, float _y, float _size) {
    x = _x;
    y = _y;
    size = _size;
    int x = int (random (handX, handY) );
    int y = int (random (handX, handY) );
    c = imgU.get(x, y);
    noStroke();
    alpha = 255;
    directionX = random(-1, 1);
    directionY = random(-1, 1);
    speed = 0.1;
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
    ellipse(x, y, size, size);
    popStyle();
  }
}