// IMA NYU Shanghai
// Kinetic Interfaces
// MOQN
// Apr 9 2018


import KinectPV2.*;
import controlP5.*;


ControlP5 cp5;

KinectPV2 kinect2;
PImage depthImg;

int thresholdMin = 0;
int thresholdMax = 4499;


void setup() {
  size(512, 424, P2D);

  kinect2 = new KinectPV2(this);
  kinect2.enableDepthImg(true);
  kinect2.init();

  // Blank image
  depthImg = new PImage(KinectPV2.WIDTHDepth, KinectPV2.HEIGHTDepth, ARGB);
  
  // add gui
  int sliderW = 100;
  int sliderH = 20;
  cp5 = new ControlP5( this );
  cp5.addSlider("thresholdMin")
    .setPosition(10, 40)
    .setSize(sliderW, sliderH)
    .setRange(1, 4499)
    .setValue(0)
    ;
  cp5.addSlider("thresholdMax")
    .setPosition(10, 70)
    .setSize(sliderW, sliderH)
    .setRange(1, 4499)
    .setValue(4499)
    ;
}


void draw() {
  background(0);

  float sumX = 0;
  float sumY = 0;
  int count = 0;
  int[] rawDepth = kinect2.getRawDepthData();
  depthImg.loadPixels();
  for (int i=0; i < rawDepth.length; i++) {
    int depth = rawDepth[i];

    if (depth >= thresholdMin
      && depth <= thresholdMax
      && depth != 0) {

      int x = i % KinectPV2.WIDTHDepth;
      int y = floor(i / KinectPV2.WIDTHDepth);

      float r = map(depth, thresholdMin, thresholdMax, 255, 0);
      float b = map(depth, thresholdMin, thresholdMax, 0, 255);

      depthImg.pixels[i] = color(r, 0, b);

      sumX += x;
      sumY += y;
      count++;
    } else {
      depthImg.pixels[i] = color(0, 0);
    }
  }
  depthImg.updatePixels();

  image(kinect2.getDepthImage(), 0, 0);
  image(depthImg, 0, 0);

  // get the center position
  float avgX = 0;
  float avgY = 0;
  if (count > 0) {
    avgX = sumX / count;
    avgY = sumY / count;
  }

  // draw the center position
  stroke(0, 255, 0);
  line(avgX, 0, avgX, height);
  line(0, avgY, width, avgY);


  fill(255);
  text(frameRate, 10, 20);
}
