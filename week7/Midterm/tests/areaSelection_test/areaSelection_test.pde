import gab.opencv.*;
import processing.video.*;

Capture cam;
OpenCV opencv;

int scale = 4;
int h, w;
int roiWidth = 150;
int roiHeight = 150;

PImage smallerImg;
PGraphics selection;

boolean useROI = true;

void setup() {
  size(640, 480);
  cam = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);

  cam.start();
  h = cam.height;
  w = cam.width;
  opencv = new OpenCV(this, cam.width / scale, cam.height / scale);
}

void draw() {
  if ( cam.available() ) {
    cam.read();

    smallerImg = createImage(cam.width/scale, cam.height/scale, RGB);

    smallerImg.copy(
      cam, 
      0, 0, cam.width, cam.height, 
      0, 0, cam.width/scale, cam.height/scale
      );

    opencv.loadImage(smallerImg);
  }

  image(cam, 0, 0);

  opencv.loadImage(cam);
  selection = createGraphics(20, 20);

  selection.beginDraw();
  if (useROI) {
    opencv.setROI(mouseX, mouseY, roiWidth, roiHeight);
  }

  opencv.findCannyEdges(20, 75);
  image(opencv.getOutput(), 0, 0);

  // if an ROI is in-use then getSnapshot()
  // will return an image with the dimensions
  // and content of the ROI
  if (useROI) {
    image(opencv.getSnapshot(), width-roiWidth, 0);
  }
  selection.endDraw();
}
