// IMA NYU Shanghai
// Kinetic Interfaces
// MOQN
// Apr 11 2018

/** 
 * Based on Kinect for Windows v2 library for processing example code
 * by Thomas Sanchez Lengeling (http://codigogenerativo.com/)
 **/


import KinectPV2.*;

KinectPV2 kinect2;
PImage depthImg;
PImage registeredImage;  // ***

int resolution = 5;
int thresholdMin = 1;
int thresholdMax = 4499;


void setup() {
  size(800, 600, P3D);

  kinect2 = new KinectPV2(this);
  kinect2.enableDepthImg(true);
  kinect2.enableColorImg(true);  // ***
  kinect2.enablePointCloud(true);  // ***
  kinect2.init();

  // Allocate a blank image
  depthImg = new PImage(KinectPV2.WIDTHDepth, KinectPV2.HEIGHTDepth, ARGB);
  registeredImage = new PImage(KinectPV2.WIDTHDepth, KinectPV2.HEIGHTDepth, RGB);  // ***
}


void draw() {
  background(0);


  updateRegisteredImage();  // ***


  // 3D space
  pushMatrix();
  translate(width/2, height/2);
  rotateY(frameCount * 0.01);

  noFill();
  stroke(255);
  box(200);


  int[] rawDepth = kinect2.getRawDepthData();
  int w = KinectPV2.WIDTHDepth;
  int h = KinectPV2.HEIGHTDepth;
  depthImg.loadPixels();
  for (int y = 0; y < h; y += resolution) {
    for (int x = 0; x < w; x += resolution) {
      int i = x + y*w;
      int depth = rawDepth[i]; // z


      if ( depth >= thresholdMin
        && depth <= thresholdMax
        && depth != 0) {

        float r = map(depth, thresholdMin, thresholdMax, 255, 0);
        float b = map(depth, thresholdMin, thresholdMax, 0, 255);

        depthImg.pixels[i] = color(r, 0, b);

        if (x % resolution == 0 && y % resolution == 0) { 
          float pX = map(x, 0, w, -w/2, w/2); 
          float pY = map(y, 0, h, -h/2, h/2);
          float pZ = map(depth, 1, 4499, 500, -500);

          stroke(registeredImage.pixels[i]);  // ***
          strokeWeight(3);
          point(pX, pY, pZ);
        }
      } else {
        depthImg.pixels[i] = color(0, 0);
      }
    }
  }
  depthImg.updatePixels();


  popMatrix();


  image(kinect2.getDepthImage(), 0, 0, w * 0.3, h * 0.3);
  image(depthImg, 0, 0, w * 0.3, h * 0.3);

  fill(255);
  text(frameRate, 10, 20);
}


void mousePressed() {
  thresholdMin = (int)map(mouseX, 0, width, 0, 4499);
}


void mouseDragged() {
  thresholdMax = (int)map(mouseX, 0, width, 0, 4499);
}



void updateRegisteredImage() {
  float [] mapDtoC = kinect2.getMapDepthToColor();

  kinect2.getColorImage(); // in order to update the RawColor data
  int[] rawColor = kinect2.getRawColor();
  int cw = KinectPV2.WIDTHColor;
  int ch = KinectPV2.HEIGHTColor;

  int[] rawDepth = kinect2.getRawDepthData();
  int w = KinectPV2.WIDTHDepth;
  int h = KinectPV2.HEIGHTDepth;

  registeredImage.loadPixels();
  for (int y = 0; y < h; y ++) {
    for (int x = 0; x < w; x ++) {
      int i = x + y*w;
      int depth = rawDepth[i];

      int cx = (int)mapDtoC[i*2 + 0];
      int cy = (int)mapDtoC[i*2 + 1];

      if (cx > 0 && cx < cw
        && cy > 0 && cy < ch) {

        int cIndex = cx + cy*cw;
        registeredImage.pixels[i] = rawColor[cIndex];
      }
    }
  }
  registeredImage.updatePixels();
}
