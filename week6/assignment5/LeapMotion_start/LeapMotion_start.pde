import de.voidplus.leapmotion.*;
import processing.video.*;

Capture cam;

PGraphics pg;
PImage imgU;
float handX, handY;
float phandX, phandY;

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

  float acc = dist(phandX, phandY, handX, handY);
  if (acc > 10) {
    //println("moved");
    int x = int (random (imgU.width) );
    int y = int (random (imgU.height) );
    color c = imgU.get(x, y);

    pg.beginDraw();
    pg.fill(red(c), green(c), blue(c), 35);
    pg.noStroke();
    pg.ellipse(handX, handY, 40, 40);
    pg.endDraw();

    image(pg, 0, 0);
  }
}