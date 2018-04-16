// IMA NYU Shanghai
// Kinetic Interfaces
// MOQN
// Apr 9 2018


import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import controlP5.*;


ControlP5 cp5;

Kinect2 kinect2;
PImage depthImg;

int thresholdMin = 0;
int thresholdMax = 4499;

float closestX = 0;
float closestY = 0;

void setup() {
  size(512, 424, P2D);

  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();

  // Blank image
  depthImg = new PImage(kinect2.depthWidth, kinect2.depthHeight, ARGB);

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

  int depthMin = 4499;
  int[] rawDepth = kinect2.getRawDepth();
  depthImg.loadPixels();
  for (int i=0; i < rawDepth.length; i++) {
    int depth = rawDepth[i];
    
    if (depth >= thresholdMin
      && depth <= thresholdMax
      && depth != 0) {

      int x = i % kinect2.depthWidth;
      int y = floor(i / kinect2.depthWidth);

      float r = map(depth, thresholdMin, thresholdMax, 255, 0);
      float b = map(depth, thresholdMin, thresholdMax, 0, 255);

      depthImg.pixels[i] = color(r, 0, b);

      if (depthMin > depth){
        depthMin = depth;
        closestX = x;
        closestY = y;
      }
    } else {
      depthImg.pixels[i] = color(0, 0);
    }
  }
  depthImg.updatePixels();

  image(kinect2.getDepthImage(), 0, 0);
  image(depthImg, 0, 0);
  
  // draw the closest position
  stroke(0, 255, 0);
  line(closestX, 0, closestX, height);
  line(0, closestY, width, closestY);


  fill(255);
  text(frameRate, 10, 20);
}
