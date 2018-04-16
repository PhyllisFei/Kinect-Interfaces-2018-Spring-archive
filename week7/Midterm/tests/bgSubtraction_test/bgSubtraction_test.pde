import gab.opencv.*;
import processing.video.*;

Capture cam;
OpenCV opencv;

int scale = 4;
int h, w;

void setup() {
  size(640, 480);
  cam = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 720, 480);

  opencv.startBackgroundSubtraction(5, 3, 0.5);

  cam.start();
  h = cam.height;
  w = cam.width;
  opencv = new OpenCV(this, cam.width / scale, cam.height / scale);
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
    //cam.loadPixels();
  }
  image(cam, 0, 0);
  
  opencv.loadImage(cam);

  opencv.updateBackground();

  opencv.dilate();
  opencv.erode();

  noFill();
  stroke(255, 0, 0);
  strokeWeight(3);
  for (Contour contour : opencv.findContours()) {
    contour.draw();
  }
}

void movieEvent(Movie m) {
  m.read();
}
