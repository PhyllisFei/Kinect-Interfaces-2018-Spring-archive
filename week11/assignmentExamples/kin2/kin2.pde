import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import gab.opencv.*;
import controlP5.*;


OpenCV opencv;
ControlP5 cp5;

Kinect2 kinect2;
PImage depthImg;

PVector closestPos;
PVector pclosestPos;

color[] colors = {color(255,0,0), 
                  color(255), color(255,255,0),
                   color(0,0,255)};
                   
int colorIndex = 0;
int status = 0;

int thresholdMin = 0;
int thresholdMax = 4499;

int count = 0;


void setup() {
  size(512, 424, P2D);
  background(0);
  
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();

  // Blank image
  depthImg = new PImage(kinect2.depthWidth, kinect2.depthHeight, ARGB);
  
  // Blank OpenCV Image
  opencv = new OpenCV(this, depthImg);

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

  int[] rawDepth = kinect2.getRawDepth();
  depthImg.loadPixels();
  for (int i=0; i < rawDepth.length; i++) {
    int depth = rawDepth[i];
    
    if (depth >= thresholdMin
      && depth <= thresholdMax
      && depth != 0) {

      int x = i % kinect2.depthWidth;
      int y = floor(i / kinect2.depthWidth);

      float w = map(depth, thresholdMin, thresholdMax, 255, 0);
      depthImg.pixels[i] = color(w);
    } else {
      depthImg.pixels[i] = color(0, 0);
    }
  }
  depthImg.updatePixels();

  //image(kinect2.getDepthImage(), 0, 0);
  
  opencv.loadImage(depthImg);
  opencv.gray();
  opencv.erode();
  opencv.erode();
  opencv.erode();
  opencv.dilate();
  
  
  //image(opencv.getOutput(), 0, 0);
  
  if (pclosestPos == null) {
    pclosestPos = opencv.max();
  } else {
    pclosestPos = closestPos;
  }
  
  closestPos = opencv.max();
  PVector diff = closestPos.copy().sub(pclosestPos);
  if (diff.x > 50) {
    
  colorIndex += 1;
  colorIndex %= colors.length;
    
   status = 1;
   
  } else if (diff.x < -50) {
   colorIndex -= 1;
   colorIndex += colors.length;
   colorIndex %= colors.length;
   status = 2;
  }
  float ans = PVector.angleBetween(closestPos, pclosestPos);
  if (abs(ans) > 0.001) {
     count += 1; 
  } else {
     count = 0; 
  }
  if (count > 5) {
     println("circle");
     background(0);
     count = 0;
  }
  
  noStroke();
  println(colorIndex);
  fill(colors[colorIndex]);
  ellipse(closestPos.x, closestPos.y, 10, 10);
  
  // draw the closest position
  //stroke(0, 255, 0);
  //line(closestPos.x, 0, closestPos.x, height);
  //line(0, closestPos.y, width, closestPos.y);


  fill(255);
  text(frameRate, 10, 20);
}