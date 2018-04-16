import processing.video.*;
import gab.opencv.*;

Capture cam;
OpenCV opencv;

PGraphics pg;
boolean handR;
float handX, handY;

int scale = 4;
int h, w;

void setup() {
  size(640, 480);

  cam = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);

  cam.start();

  pg = createGraphics(cam.width, cam.height);
  opencv = new OpenCV(this, cam.width / scale, cam.height / scale);

  LeapMotion_setup();
}

void draw() {
  if ( cam.available() ) {
    cam.read();

    PImage smallerImg = createImage(cam.width/scale, cam.height/scale, RGB);

    smallerImg.copy(
      cam, 
      0, 0, cam.width, cam.height, 
      0, 0, cam.width/scale, cam.height/scale
      );

    opencv.loadImage(smallerImg);
  }

  image(cam, 0, 0);

  opencv.loadImage(cam);

  LeapMotion_run();

  if (handR == true) {
    rect(mouseX, mouseY, 20, 20);
  }
}
